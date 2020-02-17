import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_repository_example/blocs/events/home_event.dart';
import 'package:flutter_repository_example/blocs/home_bloc.dart';
import 'package:flutter_repository_example/blocs/states/home_state.dart';
import 'package:flutter_repository_example/data/irepository.dart';
import 'package:flutter_repository_example/domain/models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc;

  @override
  void didChangeDependencies() {
    if (this._bloc == null) {
      final userRepository = RepositoryProvider.of<IRepository<User>>(context);
      this._bloc = HomeBloc(userRepository);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            RaisedButton(
              child: Text('Fetch User'),
              onPressed: () => this._bloc.add(HomeEventFetchNextUser()),
            ),
            SizedBox(height: 15),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: this._bloc,
                builder: (context, state) {
                  if (state.isFetching) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.hasNetworkError) {
                    return Text('Network error');
                  }

                  if (state.users?.isEmpty ?? true) {
                    return Text('No users');
                  }

                  return ListView(
                    children: [
                      for (final user in state.users)
                        Text(
                          user.name,
                          textAlign: TextAlign.center,
                        ),
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
