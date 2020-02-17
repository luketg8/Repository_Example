import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;

  User(this.id, this.name);
}
