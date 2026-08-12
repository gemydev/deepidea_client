abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatMessageReceived extends ChatState {
  final dynamic message;
  ChatMessageReceived(this.message);
}

class ChatMessageSent extends ChatState {}

class ChatError extends ChatState {
  final String error;
  ChatError(this.error);
}
