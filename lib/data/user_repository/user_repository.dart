import 'package:flutter/foundation.dart';
import 'package:flutter_repository_example/data/irepository.dart';
import 'package:flutter_repository_example/domain/models/user.dart';
import 'package:flutter_repository_example/exceptions/no_connection_exception.dart';

class UserRepository implements IRepository<User> {
  final IRepository<User> source;
  final IRepository<User> cache;
  final bool Function() hasConnection;
  UserRepository({
    @required this.source,
    @required this.cache,
    @required this.hasConnection,
  });

  @override
  Future<User> get(dynamic id) async {
    final cachedUser = await this.cache.get(id);

    if (cachedUser != null) {
      return cachedUser;
    }

    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    final remoteUser = await this.source.get(id);
    this.cache.add(remoteUser);

    return remoteUser;
  }

  @override
  Future<void> add(User object) async {
    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    await this.source.add(object);
    await this.cache.add(object);
  }
}
