import 'package:flutter_repository_example/domain/models/user.dart';

class HomeState {
  final Iterable<User> users;
  final bool isFetching;
  final bool hasNetworkError;

  HomeState({
    this.users,
    this.isFetching: false,
    this.hasNetworkError: false,
  });
}
