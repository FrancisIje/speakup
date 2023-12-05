// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:flutter_webrtc/flutter_webrtc.dart';

// class DIdService {
//   String apiKey;
//   String usernameApi;
//   String passwordApi;
//   String streamId; // Add default value
//   String sessionId; // Add default value
//   String sdpOffer; // Add default value
//   Map<String, dynamic> offer = {}; // Add default value
//   Map<String, dynamic> iceservers = {}; // Add default value
//   RTCPeerConnection? peerConnection;

//   // Add default values to the named parameters
//   DIdService(
//       {this.apiKey = "c3BlYWt1cDkyMUBnbWFpbC5jb20:pmeB_q9PrAwnr8aSZq9jK",
//       this.sessionId = '',
//       this.offer = const {},
//       this.iceservers = const {},
//       this.sdpOffer = '',
//       this.streamId = '',
//       this.usernameApi = "c3BlYWt1cDkyMUBnbWFpbC5jb20",
//       this.passwordApi = "pmeB_q9PrAwnr8aSZq9jK"});

//   Future<void> createNewStream() async {
//     String basicAuth =
//         'Basic ${base64.encode(utf8.encode('$usernameApi:$passwordApi'))}';

//     try {
//       final response = await http.post(
//         Uri.parse("https://api.d-id.com/talks/streams"),
//         headers: {
//           "accept": "application/json",
//           'content-type': 'application/json',
//           'authorization': basicAuth,
//         },
//         body: jsonEncode({
//           'source_url':
//               'https://responsive-layout-project.onrender.com/girlimage.jpeg',
//         }),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body);
        

//         streamId = data['id'];
//         sessionId = data['session_id'];
//       } else {
//         // Handle error
//         print(response.statusCode);
//         print('Failed to create a new stream.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> startStream() async {
//     // TODO: Implement Step 2 - Starting the stream
//     // Initialize WebRTC peer connection
//     try {
//       peerConnection = await createPeerConnections();

//       // Handle SDP offer and send SDP answer to the server
//       await peerConnection!
//           .setRemoteDescription(RTCSessionDescription(sdpOffer, 'offer'));

//       final sdpAnswer = await peerConnection!.createAnswer();
//       print(sdpAnswer);

//       await peerConnection!.setLocalDescription(sdpAnswer);

//       await sendSDPAnswerToServer(sdpAnswer);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> sendSDPAnswerToServer(RTCSessionDescription sdpAnswer) async {
//     String basicAuth =
//         'Basic ${base64.encode(utf8.encode('$usernameApi:$passwordApi'))}';
//     try {
//       final response = await http.post(
//         Uri.parse("https://api.d-id.com/talks/streams/$streamId/sdp"),
//         headers: {
//           'authorization': basicAuth,
//           'content-type': 'application/json',
//         },
//         body: jsonEncode({'answer': sdpAnswer.sdp}),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Successfully sent SDP answer to the server
//         print('SDP Answer sent successfully.');
//         var res = jsonDecode(response.body);
//         print(res);
//       } else {
//         // Handle HTTP error
//         print('Failed to send SDP Answer. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Error sending SDP Answer: $e');
//     }
//   }

//   Future<void> submitNetworkInfo() async {
//     // TODO: Implement Step 3 - Submit network information
//     // Gather ICE candidates and send them to the server
//     try {
//       peerConnection?.onIceCandidate = (candidate) {
//         if (candidate != null) {
//           // Send ICE candidate to the server
//           sendIceCandidate(candidate);
//         }
//       };
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> createTalkStream(String input) async {
//     // TODO: Implement Step 4 - Create a talk stream
//     try {
//       // Make a POST request to /talks/streams/{stream_id} endpoint.
//       http.Response response = await http.post(
//         Uri.parse('https://api.d-id.com/talks/streams/$streamId'),
//         headers: {
//           'authorization': 'Basic $apiKey',
//           'content-type': 'application/json',
//         },
//         body: jsonEncode({
//           'session_id': sessionId,
//           'script': {
//             "type": "text",
//             "subtitles": "false",
//             "provider": {"type": "microsoft", "voice_id": "en-US-JennyNeural"},
//             "ssml": "false",
//             "input": input
//           },
//         }),
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Successfully sent SDP answer to the server
//         print('Created talk stream successfully');
//         var res = jsonDecode(response.body);
//         print(res);
//       } else {
//         // Handle HTTP error
//         print('Failed to create stream. Status code: ${response.statusCode}');
//       }
//       var res = jsonDecode(response.body);
//       print(res);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> closeStream() async {
//     try {
//       // Close the WebRTC peer connection
//       peerConnection?.close();
//       peerConnection = null;

//       // Close the video streaming session
//       var res = await http.delete(
//         Uri.parse('https://api.d-id.com/talks/streams/$streamId'),
//         headers: {
//           'authorization': 'Basic $apiKey',
//           'content-type': 'application/json',
//         },
//         body: jsonEncode({'session_id': sessionId}),
//       );
//       if (res.statusCode == 200 || res.statusCode == 201) {
//         // Successfully sent SDP answer to the server
//         print('Streams deleted.');
//         var response = jsonDecode(res.body);
//         print(response);
//       } else {
//         // Handle HTTP error
//         print('Failed to delete stream. Status code: ${res.statusCode}');
//       }

//       print(jsonDecode(res.body));
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<RTCPeerConnection?> createPeerConnections() async {
//     try {
//       final connection = await createPeerConnection(offer, iceservers);

//       // Set up event listeners for the peer connection
//       connection.onIceCandidate = (candidate) {
//         // Handle ICE candidates
//       };

//       connection.onIceConnectionState = (state) {
//         // Handle ICE connection state changes
//       };

//       connection.onIceGatheringState = (state) {
//         // Handle ICE gathering state changes
//       };

//       connection.onConnectionState = (state) {
//         // Handle overall connection state changes
//       };

//       connection.onAddStream = (stream) {
//         // Handle when a new stream is added
//       };

//       return connection;
//     } catch (e) {
//       print('Error creating peer connection: $e');
//       return null;
//     }
//   }

//   Future<void> sendIceCandidate(RTCIceCandidate candidate) async {
//     try {
//       // Send ICE candidate to the server
//       var res = await http.post(
//         Uri.parse('https://api.d-id.com/talks/streams/$streamId/ice'),
//         headers: {
//           'authorization': 'Basic $apiKey',
//           'content-type': 'application/json',
//         },
//         body: jsonEncode({
//           'candidate': candidate.candidate,
//           'sdpMid': candidate.sdpMid,
//           'sdpMLineIndex': candidate.sdpMLineIndex,
//           'session_id': sessionId,
//         }),
//       );

//       if (res.statusCode == 200 || res.statusCode == 201) {
//         // Successfully sent SDP answer to the server
//         print('send ice candidate');
//         var response = jsonDecode(res.body);
//         print(response);
//       } else {
//         // Handle HTTP error
//         print('Failed to send ice candidate. Status code: ${res.statusCode}');
//       }

//       print(jsonDecode(res.body));
//     } catch (e) {
//       print(e);
//     }
//   }
// }
