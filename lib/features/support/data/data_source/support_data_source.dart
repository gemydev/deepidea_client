import 'package:remotely/features/home/data/models/responses/get_list_of_activity_response.dart';
import 'package:remotely/features/support/data/models/requests/reply_user_ticket_request.dart';
import 'package:remotely/features/support/data/models/requests/re_open_ticket_request.dart';
import 'package:remotely/features/support/data/models/responses/get_all_tickets_response.dart';
import 'package:remotely/features/support/data/models/responses/get_ticket_details_response.dart';
import 'package:remotely/features/support/data/models/responses/close_ticket.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/network/api.dart';
import '../../../../core/data/network/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/requests/get_ticket_conversation_request.dart';
import '../models/requests/submit_ticket_with_files_request.dart';
import 'package:remotely/features/support/data/models/responses/get_all_ticket_faq_response.dart';
import 'package:remotely/features/support/data/models/responses/get_faqs_by_category_response.dart';
import '../models/responses/get_ticket_categories_response.dart';
import '../models/responses/get_ticket_conversation_response.dart';
import '../models/responses/submit_ticket_with_files_response.dart';
import '../models/responses/re_open_ticket_response.dart';
import '../models/responses/reply_user_ticket.dart';

abstract class SupportDataSource {
  getListOfActivity();

  getAllTickets();

  getTicketDetails(String ticketId);

  getTicketCategories({int? parentId});

  submitTicketWithFiles(TicketSubmissionRequest request);

  getTicketConversation(GetTicketConversationRequest request);

  reOpenTicket(ReOpenTicketRequest request);

  replyUserTicket(ReplyUserTicketRequest request);

  closeTicket(String ticketId);

  getAllTicketFAQ();

  getFAQsByCategory(int categoryId);
}

class SupportDataSourceImp implements SupportDataSource {
  final NetworkClient networkClient;
  final SharedPreferences prefs;

  SupportDataSourceImp({required this.networkClient, required this.prefs});

  @override
  getListOfActivity() async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getListOfActivity(),
      );

      final GetListOfActivityResponse listOfActivityResponse = GetListOfActivityResponse.fromJson(
        response,
      );

      return listOfActivityResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  getAllTickets() async {
    try {
      Map<String, dynamic> response = await networkClient.getData(endpoint: Api.getAllTickets());

      final GetAllTicketsResponse finalResponse = GetAllTicketsResponse.fromJson(response);

      return finalResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  getTicketCategories({int? parentId}) async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getAllTicketCategories(parentId: parentId),
      );

      final GetTicketCategoriesResponse finalResponse = GetTicketCategoriesResponse.fromJson(
        response,
      );

      return finalResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  getTicketDetails(String ticketId) async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getTicketDetails(ticketId),
      );

      final GetTicketDetailsResponse finalResponse = GetTicketDetailsResponse.fromJson(response);

      return finalResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  submitTicketWithFiles(TicketSubmissionRequest request) async {
    try {
      Map<String, dynamic> response = await networkClient.postData(
        endpoint: Api.submitTicketWithFiles(),
        query: request.toJson(),
      );

      final SubmitTicketWithFilesResponse finalResponse = SubmitTicketWithFilesResponse.fromJson(
        response,
      );

      return finalResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  getTicketConversation(GetTicketConversationRequest request) async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getTicketConversation(request.ticketId),
        request: request.toJson(),
      );

      final GetTicketConversationResponse finalResponse = GetTicketConversationResponse.fromJson(
        response,
      );

      return finalResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  replyUserTicket(ReplyUserTicketRequest request) async {
    try {
      Map<String, dynamic> response = await networkClient.postData(
        endpoint: Api.replyUserTicket(),
        query: request.toJson(),
      );

      final ReplyUserTicketResponse finalResponse = ReplyUserTicketResponse.fromJson(response);

      return finalResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  reOpenTicket(ReOpenTicketRequest request) async {
    try {
      Map<String, dynamic> response = await networkClient.postData(
        endpoint: Api.reOpenTicket(),
        query: request.toJson(),
      );

      final ReOpenTicketResponse finalResponse = ReOpenTicketResponse.fromJson(response);

      return finalResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  closeTicket(String ticketId) async {
    try {
      Map<String, dynamic> response = await networkClient.postData(
        endpoint: Api.closeTicket(ticketId),
      );

      final CloseTicketResponse finalResponse = CloseTicketResponse.fromJson(response);

      return finalResponse;
    } on DioException catch (e) {
      throw ServerException(message: e.response!.data['message']);
    }
  }

  @override
  getAllTicketFAQ() async {
    try {
      final Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getAllTicketFAQ(),
      );
      return GetAllTicketFaqResponse.fromJson(response);
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data?['message']?.toString());
    }
  }

  @override
  getFAQsByCategory(int categoryId) async {
    try {
      final Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getFAQsByCategory(categoryId),
      );
      return GetFaqsByCategoryResponse.fromJson(response);
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data?['message']?.toString());
    }
  }
}
