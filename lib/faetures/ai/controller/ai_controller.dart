import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/ai_chat_message_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AiChatController extends GetxController {
  var messages = <ChatMessageModel>[].obs;
  TextEditingController messageController = TextEditingController();

  final stt.SpeechToText speech = stt.SpeechToText();
  var isListening = false.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
  }

  void initSpeech() async {
    await speech.initialize(
      onStatus: (status) {
        if (status == 'done') stopListening();
      },
      onError: (error) {
        log("Speech error: ${error.errorMsg}");
        Get.snackbar("Speech Error", error.errorMsg);
      },
    );
  }

  void startListening() async {
    bool available = await speech.initialize();
    if (available) {
      isListening.value = true;
      speech.listen(
        onResult: (val) {
          messageController.text = val.recognizedWords;
        },
      );
    } else {
      Get.snackbar("Mic Error", "Microphone not available");
    }
  }

  void stopListening() {
    isListening.value = false;
    speech.stop();
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      sendMessage(text);
      messageController.clear();
    }
  }

  void toggleListening() {
    isListening.value ? stopListening() : startListening();
  }

  void sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // User message
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

    try {
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyC1BRthJ3VpSr5aDgPxGUgeSMv1Wef-HfU',
        ),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        String generatedText = responseBody['candidates'][0]['content']['parts'][0]['text'] ??
            'No response from API';

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
    } catch (e) {
      log('Exception: $e');
      messages.add(ChatMessageModel(
        text: "Something went wrong. Try again later.",
        timestamp: DateTime.now(),
        isMe: false,
      ));
    }
  }
}

