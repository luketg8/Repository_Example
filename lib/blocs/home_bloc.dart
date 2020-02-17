import 'package:flutter_repository_example/blocs/events/home_event.dart';
import 'package:flutter_repository_example/blocs/states/home_state.dart';
import 'package:flutter_repository_example/data/irepository.dart';
import 'package:flutter_repository_example/domain/models/user.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IRepository<User> _userRepository;

  HomeBloc(this._userRepository);

  final List<User> _users = [];
  int _currentUserIndex = 0;

  @override
  HomeState get initialState => HomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeEventFetchNextUser) {
      yield HomeState(isFetching: true);

      final newUser = await this._userRepository.get(this._currentUserIndex);

      this._currentUserIndex++;
      this._users.add(newUser);

      yield HomeState(users: this._users);
    }
  }
}
