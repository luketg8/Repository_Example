import 'package:flutter_repository_example/domain/models/user.dart';

class HomeState {
  final Iterable<User> users;
  final bool isFetching;

  HomeState({
    this.users,
    this.isFetching: false,
  });
}
