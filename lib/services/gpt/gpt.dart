import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:speakup/provider/is_talking.dart';
import 'package:speakup/provider/widget_switch.dart';

class ChatGPTApi {
  BuildContext context;
  final String apiChatUrl = "https://api.openai.com/v1/chat/completions";
  final String apiSpeechUrl = 'https://api.openai.com/v1/audio/speech';
  final String openaiApiKey =
      "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";
  // "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";

  // Initialize the Completer
  // Completer<bool> playbackCompleter = Completer<bool>();

  ChatGPTApi(this.context);

  Future<String> getChatCompletion(String question) async {
    final response = await http.post(
      Uri.parse(apiChatUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $openaiApiKey",
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "max_tokens": 500,
        "messages": [
          {
            "role": "system",
            "content":
                "Your name is Ainsley. Act as an English Language tutor. You are an experienced English conversation tutor known for your expertise in holding engaging conversations with foreign students according to their English proficiency level. The conversations are in forms of roleplays, discussions on provided paragraphs or offered free topics. Do not answer any question that do not seem related to English Language tutoring "
          },
          {"role": "user", "content": question}
        ],
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body)["choices"][0]["message"]["content"]);
      return jsonDecode(response.body)["choices"][0]["message"]["content"];
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> fetchSpeech(String input) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $openaiApiKey',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'model': 'tts-1',
      'input': input,
      'voice': 'alloy',
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiSpeechUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Request successful
        print(response.bodyBytes);

        // Play the MP3
        playAudioFile(response.bodyBytes);
      } else {
        // Request failed
        print('Error: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void playAudioFile(Uint8List bytes) async {
    Provider.of<Talking>(context, listen: false).changeTalkingBool(true);
    AudioPlayer audioPlayer = AudioPlayer();

    await audioPlayer.play(BytesSource(bytes));

    audioPlayer.onPlayerComplete.listen((event) {
      print("completed audioooooooooooo");
      Provider.of<Talking>(context, listen: false).changeTalkingBool(false);
      Provider.of<ToggleProvider>(context, listen: false).toggleSelection();
    });
  }

  // Future<String?> sendAudioToOpenAI(String filePath) async {
  //   try {
  //     var uri = Uri.parse('https://api.openai.com/v1/audio/transcriptions');
  //     var request = http.MultipartRequest('POST', uri);

  //     request.headers['Authorization'] = 'Bearer $openaiApiKey';
  //     request.headers['Content-Type'] = 'multipart/form-data';

  //     // Explicitly set the content length
  //     var file = await http.MultipartFile.fromPath('file', filePath);
  //     request.headers['Content-Length'] = file.length.toString();

  //     request.files.add(file);
  //     request.fields['model'] = 'whisper-1';

  //     var response = await http.Response.fromStream(await request.send());

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // Parse the OpenAI API response
  //       var decodedResponse = jsonDecode(response.body);

  //       // Extract the transcribed text
  //       String transcribedText = decodedResponse['text'];
  //       print('Transcribed Text: $transcribedText');
  //       return transcribedText;
  //     } else {
  //       print(
  //           'Failed to transcribe audio. Status code: ${response.statusCode}, ${response.body}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error sending audio to OpenAI: $e');
  //     return null;
  //   }
  // }

  // Future<String?> sendAudioToOpenAI(File audioFile) async {
  //   if (!audioFile.existsSync()) {
  //     print('Audio file does not exist at ${audioFile.path}');
  //     return null;
  //   }

  //   try {
  //     var uri = Uri.parse('https://api.openai.com/v1/audio/transcriptions');
  //     var request = http.MultipartRequest('POST', uri);

  //     request.headers['Authorization'] = 'Bearer $openaiApiKey';
  //     request.fields['model'] = 'whisper-1';

  //     // Add the audio file to the request
  //      request.files
  //         .add(await http.MultipartFile.fromPath('file', audioFile.path));

  //     var response = await http.Response.fromStream(await request.send());

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // Parse the OpenAI API response
  //       var decodedResponse = jsonDecode(response.body);

  //       // Extract the transcribed text
  //       String transcribedText = decodedResponse['text'];
  //       print('Transcribed Text: $transcribedText');
  //       return transcribedText;
  //     } else {
  //       print(
  //           'Failed to transcribe audio. Status code: ${response.statusCode}, ${response.body}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error sending audio to OpenAI: $e');
  //     return null;
  //   }
  // }

  Future<String?> transcribeAudio(String audioFilePath) async {
    final dio = Dio();

    try {
      // Create FormData with the file and additional fields
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(audioFilePath, filename: "audio.mp3"),
        "model": "whisper-1",
      });

      // Send the request
      final response = await dio.post(
        "https://api.openai.com/v1/audio/transcriptions",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $openaiApiKey",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response and return the transcribed text
        return response.data['text'];
      } else {
        print(
            "Failed to transcribe audio. Status code: ${response.statusCode}, ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      SnackBar(content: Text("Couldn't get that, try again"));
      return null;
    }
  }
}
