import '../../../core/data/network/dio_client.dart';
import '../models/get_conversation_response.dart';

class ChatApi {
  //static const String baseUrl = 'http://aap-soloutions.com';
  static const String baseUrl = 'https://dev2.newgooobig.com';

  static String sendMessage() => '$baseUrl/api/Chat/send';

  static String getConversation(String senderId, String receiverId) =>
      '$baseUrl/api/Conversation/GetConversation/$senderId/$receiverId';
}

class ChatApiService {
  final NetworkClient networkClient;

  ChatApiService(this.networkClient);

  Future<void> sendMessage(Map<String, dynamic> data) async {
    await networkClient.postData(endpoint: ChatApi.sendMessage(), query: data);
  }

  Future<GetConversationResponse> getConversation({
    required String senderId,
    required String receiverId,
  }) async {
    var data = await networkClient.getData(endpoint: ChatApi.getConversation(senderId, receiverId));

    return GetConversationResponse.fromJson(data);
  }
}
