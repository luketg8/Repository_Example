import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_repository_example/data/hive_repository.dart';
import 'package:flutter_repository_example/data/irepository.dart';
import 'package:flutter_repository_example/data/user_repository/user_api_repository.dart';
import 'package:flutter_repository_example/data/user_repository/user_repository.dart';
import 'package:flutter_repository_example/domain/models/user.dart';
import 'package:flutter_repository_example/screens/home_screen.dart';
import 'package:flutter_repository_example/services/inetwork_connectivity_service.dart';
import 'package:flutter_repository_example/services/network_connectivity_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  final userBox = await Hive.openBox<User>('Users');
  final networkConnectivityService = NetworkConnectivityService();

  runApp(MyApp(
    userBox: userBox,
    networkConnectivityService: networkConnectivityService,
  ));
}

class MyApp extends StatelessWidget {
  final Box<User> userBox;
  final INetworkConnectivityService networkConnectivityService;

  const MyApp(
      {Key key,
      @required this.userBox,
      @required this.networkConnectivityService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IRepository<User>>(
          create: (_) => UserRepository(
            source: UserApiRepository(),
            cache: HiveRepository<User>(this.userBox),
            hasConnection: this.networkConnectivityService.isConnected,
          ),
        )
      ],
      child: MaterialApp(
        title: 'Repository Example',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
