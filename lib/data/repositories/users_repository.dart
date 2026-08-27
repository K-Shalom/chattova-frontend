// lib/data/repositories/users_repository.dart

import '../../domain/models/public_user.dart';
import '../datasources/users_api.dart';

class UsersRepository {
  UsersRepository(this._api);

  final UsersApi _api;

  Future<List<PublicUser>> search(String query) async {
    final rows = await _api.search(query);
    return rows.map(PublicUser.fromJson).toList();
  }
}
