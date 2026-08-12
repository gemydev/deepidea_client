import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/requests/post_invoices_with_confirm_request.dart';
import '../../../data/models/responses/post_invoices_with_confirm_response.dart';
import '../../../domain/use_cases/post_invoices_with_confirm_use_case.dart';

part 'post_invoices_state.dart';

class PostInvoicesCubit extends Cubit<PostInvoicesState> {
  final PostInvoicesWithConfirmUseCase postInvoicesUseCase;

  PostInvoicesCubit({required this.postInvoicesUseCase})
      : super(PostInvoicesInitial());

  Future<bool> postInvoices({
    required PostInvoicesWithConfirmRequest postInvoicesWithConfirmRequest,
  }) async {
    log("▶️ postInvoices request: $postInvoicesWithConfirmRequest");

    emit(PostInvoicesLoading());

    try {
      final result = await postInvoicesUseCase(postInvoicesWithConfirmRequest);

      bool success = false;

      await result.fold(
        (failure) async {
          log("❌ PostInvoices failed: $failure");
          emit(PostInvoicesError(
              message: 'حدثت مشكلة أثناء رفع الفاتورة'));
          success = false;
        },
        (response) async {
          log("✅ PostInvoices response: ${response.statusCode}");

          // تأكد أن statusCode فعلاً int
          final int? code = (response.statusCode is int
              ? response.statusCode
              : int.tryParse(response.statusCode?.toString() ?? '')) as int?;

          if (code == 200) {
            emit(PostInvoicesLoaded(postInvoicesWithConfirmResponse: response));
            success = true;
          } else {
            emit(PostInvoicesError(
              message: 'حدثت مشكلة أثناء رفع الفاتورة'));
            success = false;
          }
        },
      );

      return success;
    } catch (e, st) {
      log("🔥 Exception in postInvoices: $e\n$st");
      emit(PostInvoicesError(message: 'حدث خطأ غير متوقع'));
      return false;
    }
  }
}