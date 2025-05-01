// lib/providers/chat_provider.dart
import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/cohere_api_service.dart';

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  final CohereApiService _apiService = CohereApiService();

  Future<void> sendMessage(String userMessage) async {
    _messages.add(Message(text: userMessage, isUser: true));
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getChatResponse(userMessage);
      _messages.add(Message(text: response, isUser: false));
    } catch (e) {
      _messages.add(Message(text: "Error: ${e.toString()}", isUser: false));
    }

    _isLoading = false;
    notifyListeners();
  }
}
