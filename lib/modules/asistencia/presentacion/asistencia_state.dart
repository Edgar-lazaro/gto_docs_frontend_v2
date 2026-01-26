enum AsistenciaStatus {
  idle,
  checkingLan,
  success,
  error,
}

class AsistenciaState {
  final AsistenciaStatus status;
  final String? message;

  const AsistenciaState({
    this.status = AsistenciaStatus.idle,
    this.message,
  });

  AsistenciaState copyWith({
    AsistenciaStatus? status,
    String? message,
  }) {
    return AsistenciaState(
      status: status ?? this.status,
      message: message,
    );
  }
}