import 'package:flutter_repository_example/data/irepository.dart';
import 'package:flutter_repository_example/domain/models/user.dart';

class UserApiRepository implements IRepository<User> {
  @override
  Future<void> add(object) => Future.delayed(Duration(seconds: 2), () {
        //Send to a remote data source
      });

  @override
  Future<User> get(id) =>
      Future.delayed(Duration(seconds: 2), () => User(id, 'User #$id'));
}
