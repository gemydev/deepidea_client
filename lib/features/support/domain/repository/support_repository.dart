import 'package:remotely/features/support/data/models/responses/get_all_tickets_response.dart';
import 'package:remotely/features/support/data/models/responses/get_all_ticket_faq_response.dart';
import 'package:remotely/features/support/data/models/responses/get_faqs_by_category_response.dart';
import 'package:remotely/features/support/data/models/responses/get_ticket_categories_response.dart';
import 'package:remotely/features/support/data/models/responses/get_ticket_details_response.dart';
import 'package:remotely/features/support/data/models/responses/close_ticket.dart';
import 'package:remotely/features/support/data/models/responses/re_open_ticket_response.dart';
import 'package:remotely/features/support/data/models/responses/reply_user_ticket.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/requests/get_ticket_conversation_request.dart';
import '../../data/models/requests/reply_user_ticket_request.dart';
import '../../data/models/requests/submit_ticket_with_files_request.dart';
import '../../data/models/requests/re_open_ticket_request.dart';
import '../../data/models/responses/get_ticket_conversation_response.dart';
import '../../data/models/responses/submit_ticket_with_files_response.dart';

abstract class SupportRepository {
  Future<Either<Failure, GetAllTicketsResponse>> getAllTickets();

  Future<Either<Failure, GetTicketDetailsResponse>> getTicketDetails(String ticketId);

  Future<Either<Failure, GetTicketCategoriesResponse>> getTicketCategories({int? parentId});

  Future<Either<Failure, SubmitTicketWithFilesResponse>> submitTicketWithFiles(
    TicketSubmissionRequest request,
  );

  Future<Either<Failure, GetTicketConversationResponse>> getTicketConversation(
    GetTicketConversationRequest request,
  );

  Future<Either<Failure, ReOpenTicketResponse>> reOpenTicket(ReOpenTicketRequest request);

  Future<Either<Failure, ReplyUserTicketResponse>> replyUserTicket(ReplyUserTicketRequest request);

  Future<Either<Failure, CloseTicketResponse>> closeTicket(String ticketId);

  Future<Either<Failure, GetAllTicketFaqResponse>> getAllTicketFAQ();

  Future<Either<Failure, GetFaqsByCategoryResponse>> getFAQsByCategory(int categoryId);
}
