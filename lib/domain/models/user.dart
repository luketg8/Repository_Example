import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  User(this.id, this.name);
}
