import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/ai_chat_message_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AiChatController extends GetxController {
  var messages = <ChatMessageModel>[].obs;
  TextEditingController messageController = TextEditingController();

  void sendMessage(String message) async {
    if (message.isNotEmpty) {
      messages.add(ChatMessageModel(
        text: message,
        timestamp: DateTime.now(),
        isMe: true,
      ));
        final body = json.encode({
          "contents": [
            {
              "parts": [
                {"text": message}
              ]
            }
          ]
        });
        final response = await http.post(
          Uri.parse(
              'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyC1BRthJ3VpSr5aDgPxGUgeSMv1Wef-HfU'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );
        if (response.statusCode == 200) {
          // Log the response for debugging purposes
          print('API Response: ${response.body}');

          // Parse the response
          final responseBody = json.decode(response.body);

          // Extract the generated text
          String generatedText = responseBody['candidates'][0]['content']
                  ['parts'][0]['text'] ??
              'No response from API';

          // Add the response to the message list
          messages.add(ChatMessageModel(
            text: generatedText,
            timestamp: DateTime.now(),
            isMe: false,
          ));
        } else {
          log('Error: ${response.statusCode}, ${response.body}');
          messages.add(ChatMessageModel(
            text: "Failed to get a response from the API.",
            timestamp: DateTime.now(),
            isMe: false,
          ));
        }

    }
  }
}
