import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/providers.dart';
import '../pdfs/generated_pdf_providers.dart';
import 'users_repository.dart';
import 'user_ref.dart';

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepository(
    dio: ref.read(dioProvider),
    prefs: ref.read(sharedPreferencesProvider),
  );
});

final usersListProvider = FutureProvider<List<UserRef>>((ref) async {
  return ref.read(usersRepositoryProvider).getUsers();
});

final usersListByGerenciaProvider = FutureProvider.family<List<UserRef>, int?>((
  ref,
  gerenciaId,
) async {
  return ref.read(usersRepositoryProvider).getUsers(gerenciaId: gerenciaId);
});
