import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/services/api_handling/failure.dart';
import 'package:flutter_application_1/core/services/navigation_service.dart';
import 'package:flutter_application_1/core/services/service_locator.dart';
import 'package:flutter_application_1/qr_view/repo/qr_repo.dart';
import 'package:meta/meta.dart';

import '../../core/toast/app_toast.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  final QrRepo _qrRepo = QrRepo();
  QrCubit() : super(QrState(status: QrStatus.qrInitial));

  Future<void> scanQr(String uniqueKey) async {
    emit(state.copyWith(status: QrStatus.qrScanning));
    final response = await _qrRepo.scanQr(uniqueKey);
    if (response == 200) {
      AppToasts().showToast(message: 'Qr Scanned Succesfully');
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        locator<NavigationService>().pop();
      });
      emit(state.copyWith(status: QrStatus.qrScanned));
    } else {
      emit(state.copyWith(status: QrStatus.qrError));
    }
    // response.fold((l) {
    //   emit(state.copyWith(status: QrStatus.qrScanned));
    // }, (r) {
    //   emit(state.copyWith(status: QrStatus.qrError));
    // });
  }
}
