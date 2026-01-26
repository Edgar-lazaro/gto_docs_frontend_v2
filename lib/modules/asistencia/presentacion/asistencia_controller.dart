import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/lan_status.dart';
import '../../../core/network/lan_status_provider.dart';
import '../domain/asistencia.dart';
import '../domain/asistencia_repository.dart';

class AsistenciaState {
  final bool loading;
  final String? error;

  const AsistenciaState({
    this.loading = false,
    this.error,
  });

  AsistenciaState copyWith({
    bool? loading,
    String? error,
  }) {
    return AsistenciaState(
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class AsistenciaController
    extends StateNotifier<AsistenciaState> {
  final AsistenciaRepository repository;
  final Ref ref;

  AsistenciaController(this.repository, this.ref)
      : super(const AsistenciaState());

  Future<void> registrarAsistencia({
    required String usuarioId,
    required TipoAsistencia tipo,
    String metodo = 'manual',
  }) async {
    // Validar LAN
    final lanStatus = ref.read(lanStatusProvider).maybeWhen(
          data: (s) => s,
          orElse: () => LanStatus.disconnected,
        );

    if (lanStatus != LanStatus.connected) {
      state = state.copyWith(
        error: 'Debes estar conectado a la red del aeropuerto',
      );
      return;
    }

    // Registrar
    state = state.copyWith(loading: true, error: null);

    try {
      await repository.registrar(
        usuarioId: usuarioId,
        tipo: tipo,
        metodo: metodo,
      );

      state = state.copyWith(loading: false);
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'No se pudo registrar la asistencia',
      );
    }
  }
}