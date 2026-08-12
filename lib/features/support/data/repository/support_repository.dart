import 'package:remotely/features/support/data/models/requests/reply_user_ticket_request.dart';
import 'package:remotely/features/support/data/models/requests/re_open_ticket_request.dart';
import 'package:remotely/features/support/data/models/responses/get_all_tickets_response.dart';
import 'package:remotely/features/support/data/models/responses/get_all_ticket_faq_response.dart';
import 'package:remotely/features/support/data/models/responses/get_faqs_by_category_response.dart';
import 'package:remotely/features/support/data/models/responses/get_ticket_categories_response.dart';
import 'package:remotely/features/support/data/models/responses/get_ticket_details_response.dart';
import 'package:remotely/features/support/data/models/responses/close_ticket.dart';
import 'package:remotely/features/support/data/models/responses/re_open_ticket_response.dart';
import 'package:remotely/features/support/data/models/responses/reply_user_ticket.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/support_repository.dart';
import '../data_source/support_data_source.dart';
import '../models/requests/get_ticket_conversation_request.dart';
import '../models/requests/submit_ticket_with_files_request.dart';
import '../models/responses/get_ticket_conversation_response.dart';
import '../models/responses/submit_ticket_with_files_response.dart';

class SupportRepositoryImp extends SupportRepository {
  late SupportDataSource supportDataSource;

  SupportRepositoryImp({required this.supportDataSource});

  @override
  Future<Either<Failure, GetAllTicketsResponse>> getAllTickets() async {
    try {
      final data = await supportDataSource.getAllTickets();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetTicketCategoriesResponse>> getTicketCategories({int? parentId}) async {
    try {
      final data = await supportDataSource.getTicketCategories(parentId: parentId);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetTicketDetailsResponse>> getTicketDetails(String ticketId) async {
    try {
      final data = await supportDataSource.getTicketDetails(ticketId);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CloseTicketResponse>> closeTicket(String ticketId) async {
    try {
      final data = await supportDataSource.closeTicket(ticketId);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SubmitTicketWithFilesResponse>> submitTicketWithFiles(
    TicketSubmissionRequest request,
  ) async {
    try {
      final data = await supportDataSource.submitTicketWithFiles(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetTicketConversationResponse>> getTicketConversation(
    GetTicketConversationRequest request,
  ) async {
    try {
      final data = await supportDataSource.getTicketConversation(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ReOpenTicketResponse>> reOpenTicket(ReOpenTicketRequest request) async {
    try {
      final data = await supportDataSource.reOpenTicket(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ReplyUserTicketResponse>> replyUserTicket(
    ReplyUserTicketRequest request,
  ) async {
    try {
      final data = await supportDataSource.replyUserTicket(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetAllTicketFaqResponse>> getAllTicketFAQ() async {
    try {
      final data = await supportDataSource.getAllTicketFAQ();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetFaqsByCategoryResponse>> getFAQsByCategory(int categoryId) async {
    try {
      final data = await supportDataSource.getFAQsByCategory(categoryId);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
