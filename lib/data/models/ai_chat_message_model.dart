import 'dart:convert';

class ChatMessageModel {
  final String text;
  final DateTime timestamp;
  final bool isMe;

  ChatMessageModel({
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isMe': isMe,
    };
  }

  // ✅ Create an object from Map (JSON)
  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      text: map['text'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
      isMe: map['isMe'] ?? false,
    );
  }

  String toJson() => jsonEncode(toMap());
  factory ChatMessageModel.fromJson(String source) =>
      ChatMessageModel.fromMap(jsonDecode(source));
}
