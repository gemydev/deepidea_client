import 'package:remotely/features/home/domain/use_cases/upload_file_use_case.dart';
import 'package:remotely/features/chat/signal_r/chat_cubit/chat_cubit.dart';
import 'package:remotely/features/support/data/data_source/support_data_source.dart';
import 'package:remotely/features/support/domain/use_cases/close_ticket.dart';
import 'package:remotely/features/support/domain/use_cases/get_all_tickets_use_case.dart';
import 'package:remotely/features/support/domain/use_cases/get_ticket_categories_use_case.dart';
import 'package:remotely/features/support/domain/use_cases/get_ticket_details_use_case.dart';
import 'package:remotely/features/support/domain/use_cases/re_open_ticket.dart';
import 'package:remotely/features/support/domain/use_cases/reply_ticket.dart';
import 'package:remotely/features/support/domain/use_cases/submit_ticket_with_files_use_case.dart';
import 'package:remotely/features/support/presentation/cubits/close_ticket/close_ticket_cubit.dart';
import 'package:remotely/features/support/presentation/cubits/get_all_tickets/get_all_tickets_cubit.dart';
import 'package:remotely/features/support/domain/use_cases/get_all_ticket_faq_use_case.dart';
import 'package:remotely/features/support/domain/use_cases/get_faqs_by_category_use_case.dart';
import 'package:remotely/features/support/presentation/cubits/get_ticket_faq/get_ticket_faq_cubit.dart';
import 'package:remotely/features/support/presentation/cubits/get_ticket_categories/get_ticket_categories_cubit.dart';
import 'package:remotely/features/support/presentation/cubits/get_ticket_details/get_ticket_details_cubit.dart';
import 'package:remotely/features/support/presentation/cubits/re_open_ticket/re_open_ticket_cubit.dart';
import 'package:remotely/features/support/presentation/cubits/reply_user_ticket/reply_user_ticket_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/network/dio_client.dart';
import '../../features/chat/signal_r/signal_r_service.dart';
import '../../features/support/data/repository/support_repository.dart';
import '../../features/support/domain/repository/support_repository.dart';
import '../../features/support/domain/use_cases/get_ticket_conversation_use_case.dart';
import '../../features/support/presentation/cubits/get_ticket_conversation/get_ticket_conversation_cubit.dart';
import '../../features/support/presentation/cubits/submit_ticket_with_files/submit_ticket_with_files_cubit.dart';

Future<void> supportInit(GetIt sl) async {
  // Cubit
  sl.registerLazySingleton(
    () => GetAllTicketsCubit(getAllTicketsUseCase: sl<GetAllTicketsUseCase>()),
  );
  sl.registerFactory(
    () => GetTicketFaqCubit(
      getAllTicketFaqUseCase: sl<GetAllTicketFaqUseCase>(),
      getFaqsByCategoryUseCase: sl<GetFaqsByCategoryUseCase>(),
    ),
  );
  sl.registerFactory(
    () => GetTicketCategoriesCubit(getTicketCategoriesUseCase: sl<GetTicketCategoriesUseCase>()),
  );
  sl.registerFactory(
    () => GetTicketDetailsCubit(getTicketDetailsUseCase: sl<GetTicketDetailsUseCase>()),
  );
  sl.registerFactory(
    () => SubmitTicketWithFilesCubit(
      submitTicketWithFilesUseCase: sl<SubmitTicketWithFilesUseCase>(),
    ),
  );
  sl.registerFactory(
    () => GetTicketConversationCubit(
      getTicketConversationUseCase: sl<GetTicketConversationUseCase>(),
      replyUserTicketUseCase: sl<ReplyUserTicketUseCase>(),
      uploadFilesUseCase: sl<UploadFilesUseCase>(),
    ),
  );
  sl.registerFactory(
    () => ReplyUserTicketCubit(replyUserTicketUseCase: sl<ReplyUserTicketUseCase>()),
  );
  sl.registerFactory(() => ReOpenTicketCubit(reOpenTicketUseCase: sl<ReOpenTicketUseCase>()));
  sl.registerFactory(() => CloseTicketCubit(closeTicketUseCase: sl<CloseTicketUseCase>()));

  // UseCase
  sl.registerFactory(() => GetAllTicketsUseCase(supportRepository: sl<SupportRepository>()));
  sl.registerFactory(() => GetAllTicketFaqUseCase(supportRepository: sl<SupportRepository>()));
  sl.registerFactory(() => GetFaqsByCategoryUseCase(supportRepository: sl<SupportRepository>()));
  sl.registerFactory(() => GetTicketCategoriesUseCase(supportRepository: sl<SupportRepository>()));
  sl.registerFactory(() => GetTicketDetailsUseCase(supportRepository: sl<SupportRepository>()));
  sl.registerFactory(
    () => SubmitTicketWithFilesUseCase(supportRepository: sl<SupportRepository>()),
  );
  sl.registerFactory(
    () => GetTicketConversationUseCase(supportRepository: sl<SupportRepository>()),
  );
  sl.registerFactory(() => ReplyUserTicketUseCase(supportRepository: sl<SupportRepository>()));
  sl.registerFactory(() => ReOpenTicketUseCase(supportRepository: sl<SupportRepository>()));
  sl.registerFactory(() => CloseTicketUseCase(supportRepository: sl<SupportRepository>()));

  // Repository
  sl.registerFactory<SupportRepository>(
    () => SupportRepositoryImp(supportDataSource: sl<SupportDataSource>()),
  );

  // Data sources
  sl.registerFactory<SupportDataSource>(
    () => SupportDataSourceImp(networkClient: sl<NetworkClient>(), prefs: sl<SharedPreferences>()),
  );

  // Chat
  // Register SignalR service
  sl.registerLazySingleton<SignalRService>(() => SignalRService());

  // Register ChatCubit
  sl.registerLazySingleton<ChatCubit>(() => ChatCubit(sl<SignalRService>()));
}
