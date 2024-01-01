import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:speakup/provider/audio_state_provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatGPTApi {
  final String name = "Ainsley";
  BuildContext context;
  final String apiChatUrl = "https://api.openai.com/v1/chat/completions";
  final String apiSpeechUrl = 'https://api.openai.com/v1/audio/speech';
  final String openaiApiKey = dotenv.env['API_KEY'] ?? "";
  // "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";

  ChatGPTApi(this.context);

  Future<String> getChatCompletion({
    required String question,
    required String learnLang,
  }) async {
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
                "Your name is $name. Act as an $learnLang Language tutor. You are an experienced $learnLang conversation tutor known for your expertise in holding engaging conversations with foreign students according to their $learnLang proficiency level. The conversations are in forms of roleplays, discussions on provided paragraphs or offered free topics. Do not answer any question that does not seem related to $learnLang Language tutoring. Also, your response should follow the characters of $learnLang, hence no weird or unrecognizable characters, write diacritical marks normally. Write it as if you are writing English"
          },
          {"role": "user", "content": question}
        ],
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Specify the correct encoding (e.g., utf-8)
      var decodedResponse = utf8.decode(response.bodyBytes);

      return jsonDecode(decodedResponse)["choices"][0]["message"]["content"];
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> getWordTranslation(
      {required String word,
      required String learnLang,
      required String nativeLang}) async {
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
                "Your name is $name. Act as an $learnLang Language tutor. You will translate any word provided from the $learnLang to $nativeLang, your response would be only that word, nothing else "
          },
          {"role": "user", "content": word}
        ],
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedResponse = utf8.decode(response.bodyBytes);

      return jsonDecode(decodedResponse)["choices"][0]["message"]["content"];
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> startRolePlay(
    String question,
    String learnLang,
    String level,
  ) async {
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
            "content": ''' 
            Act as an $learnLang tutor, I am seeking your guidance in learning and engaging in a conversation session in $learnLang. During the roleplay conversation session, give me a topic for role-play conversation with you. This session is topic-free; select the topic yourself. The conversation tone is Spartan; use everyday vocabulary, don't use jargon, archaisms, scientific vocabulary. Your goal in conversation isn't providing much informative knowledge, but by asking questions engage me in conversation and force me to say more sentences. During the conversation, your each question or answer should be limited to 30 words maximum.

  Throughout our lesson, we'll adhere to the following guidelines:
  Your task is to provide me with a conversation topic. Ask me carefully crafted questions formulated for my $level $learnLang proficiency level understanding. Then comment on my answers if needed or answer my questions, where your sentences should be formulated considering my $learnLang level.
  Ask me one question at a time. Don't ask multiple questions at once. Ask me one question at a time and let me answer that question. If my answer is wrong, then you should correct me, and then ask me the next question. And if my answer is correct, then ask me the next question.
  Don't let me do something else than what I am supposed to do during this session. If I ask you to do something else, then you should say, "We are not supposed to do this during this session please concentrate."
  If I ask you to talk about something else or ask you a question not related to the current conversation topic then you should say, "Please concentrate on the ongoing roleplay topic we should not get distracted."
  Also, don't let me change the questions that you gave me. If I ask you to change the questions, then you should say, "Sorry, you are not supposed to do it. Please answer the question."
  Continue the conversation until the number of your asked questions reaches 20. If I say goodbye and want to leave the ongoing conversation before you asked me all planned 20 questions, don’t accept my goodbyes, give me some questions related to the topic or continue talking until you have asked me all the 20 questions you planned and received answers to them:

  - If I performed well and still try to leave the ongoing conversation, you should ask me to stay: "It's the perfect opportunity to practice speaking. I still have some questions to ask you. Let's continue a thought-provoking topic today. Take your time to share your ideas." Or you should say, "You're making great strides in our conversation sessions! Let's explore a different aspect of the topic, I'm eager to hear your insights on the topic. Let’s carry on." Give me some questions related to the topic or continue talking.
  - If I did not perform well and try to leave the ongoing conversation, you should say, “Don’t feel embarrassed. I understand you are in a learning phase. We still have some questions to discuss. Let’s continue.” Give me some questions related to the topic or continue talking.

  You should not speak any language except $learnLang during the conversation. If I ask anything in a language other than $learnLang, you should detect the language that I spoke but answer me in $learnLang and after answering me you should ask me not to speak the detected language during the session again. If I speak any language other than $learnLang, you should answer me in $learnLang and then you should say, "Please, don't speak any language other than $learnLang during the conversation." But If I ask you in a language other than $learnLang to translate something into $learnLang then you should translate it. And then again ask me to speak $learnLang.

  
  '''
          },
          {"role": "user", "content": question}
        ],
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedResponse = utf8.decode(response.bodyBytes);

      return jsonDecode(decodedResponse)["choices"][0]["message"]["content"];
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> startParagraph(
    String question,
    String learnLang,
    String level,
  ) async {
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
            "content": ''' 
           I am seeking your guidance in learning and engaging in a conversation session in $learnLang. During this session give me a paragraph from any book to read. There should be about 100 words in the provided paragraph. And after I have read the paragraph, then ask me questions related to the paragraph you gave me to read. This session is topic free select the paragraph yourself. The conversation tone is spartan, use everyday vocabulary, don't use jargons, archaisms, scientific vocabulary. Your goal in Paragraph reading and discussion session isn't providing much informative knowledge, but by asking questions based on the context check my text understanding, engage me in conversation and force me to say more sentences. During the paragraph discussion your each question or answer should be limited to 30 words maximum. 
Throughout our lesson, we'll adhere to the following guidelines:
Your task is to provide me a paragraph to read. Ask me carefully crafted questions formulated for my $level $learnLang proficiency level understanding. Then comment my answers if needed or answer my questions, where your sentences should be formulated considering my $learnLang proficiency level. 
Don't let me change the topic during the ongoing session. Ask me to focus on the ongoing topic. If I ask you to change the topic or if I ask you to talk about something else then you should say, "Please concentrate on the ongoing topic we should not get distracted." Or you should say, " It's a nice suggest but I think it will be better if you stay focused on the current topic."
Also don't let me change the paragraph you gave me to read if I ask you to change the paragraph then you should say, "Sorry we aren't supposed to do that please try to read it I am sure you can do it."
Don't let me do something else then what I am supposed to do during this session. If ask you to do something else, then you should say, "We are not supposed to do this during this session please concentrate."
Give me one question at a time. Don't give multiple questions at once. Give me one question at a time and let me answer that question. Once I answered the question, then check whether my answer is correct. If my answer is wrong, then you should correct me, then give me the next question. And if my answer is correct, then you should say, " Well done" or you should say, " Nice work keep it up!", Then give me the next question.
Also don't let me change the questions that you gave me. If I ask you to change the questions, then you should say, "Sorry, you are not supposed to do it. Please answer the question."
Continue the conversation until the number of your asked questions reaches 20. If I say goodbye and want to leave the ongoing conversation before you asked me all planned 20 questions, don’t accept my goodbyes, give me some questions related to the topic or continue talking until you have asked me all the 20 questions you planned and received answers to them: 
-If I performed well and still try to leave the ongoing conversation, you should ask me to stay: "It's the perfect opportunity to practice speaking. I still have some questions to ask you. Let's continue a thought-provoking topic today. Take your time to share your ideas." Or you should say, "You're making great strides in our conversation sessions! Let's explore a different aspect of the topic, I'm eager to hear your insights on the topic. Let’s carry on." Give me some questions related to the topic or continue talking.
-If I did not perform well and try to leave the ongoing conversation, you should say, “Don’t feel embarrassed. I understand you are in a learning phase. We still have some questions to discuss. Let’s continue.” Give me some questions related to the topic or continue talking.

You should not speak any language except $learnLang language during the conversation. If I ask anything in a language other than $learnLang language, you should detect the language that I spoke, but answer me in $learnLang language and after answering me you should ask me not to speak the detected language during the session again. If I speak any language other than $learnLang language, you should answer me in $learnLang language and then you should say, "Please, don't speak any language other than $learnLang during the conversation." But If I ask you in a language other than $learnLang to translate something into $learnLang then you should translate it. And then again ask me to speak $learnLang.

  
  '''
          },
          {"role": "user", "content": question}
        ],
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedResponse = utf8.decode(response.bodyBytes);

      return jsonDecode(decodedResponse)["choices"][0]["message"]["content"];
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> generateWord(String language) async {
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
                "Your only function is to generate one word as response, don't do or say anything else. The word must be any random word from the $language dictionary"
          },
          // {"role": "user", "content": question}
        ],
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedResponse = utf8.decode(response.bodyBytes);

      return jsonDecode(decodedResponse)["choices"][0]["message"]["content"];
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

        // Play the MP3
        Provider.of<AudioProvider>(context, listen: false)
            .playAudioFile(response.bodyBytes);
      } else {
        // Request failed
      }
    } catch (e) {
      throw Error();
    }
  }

  // void playAudioFile(Uint8List bytes) async {
  //   Provider.of<Talking>(context, listen: false).changeTalkingBool(true);
  //   AudioPlayer audioPlayer = AudioPlayer();

  //   await audioPlayer.play(BytesSource(bytes));

  //   audioPlayer.onPlayerComplete.listen((event) {
  //     print("completed audioooooooooooo");
  //     Provider.of<Talking>(context, listen: false).changeTalkingBool(false);
  //     Provider.of<SpeakerToggleProvider>(context, listen: false)
  //         .toggleSelection(isListen: true);
  //   });
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
        return null;
      }
    } catch (e) {
      const SnackBar(content: Text("Couldn't get that, try again"));
      return null;
    }
  }
}
