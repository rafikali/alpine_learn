part of 'qr_cubit.dart';

enum QrStatus { qrInitial, qrScanning, qrScanned, qrError }

@immutable
class QrState extends Equatable {
  QrStatus? status;

  QrState({this.status});

  @override
  List<Object?> get props => [status];

  QrState copyWith({QrStatus? status}) {
    return QrState(
      status: status ?? this.status,
    );
  }
}
