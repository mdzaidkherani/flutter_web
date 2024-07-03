import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc/posts/posts_events.dart';
import 'package:bloc_test/bloc/posts/posts_states.dart';
import 'package:bloc_test/bloc/users/users_event.dart';
import 'package:bloc_test/bloc/users/users_state.dart';
import 'package:bloc_test/services/post_services/post_services.dart';
import 'package:bloc_test/services/users_services/users_services.dart';
import 'package:bloc_test/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UsersBloc extends Bloc<UsersEvent, UsersStates> {

  UsersRepository usersRepository = UsersRepository();

  UsersBloc() : super(UsersStates()) {
    on<UsersFetched>(fetchUsersApi);
    on<UsersRefresh>(refreshUsersApi);
  }

  void fetchUsersApi(UsersFetched event, Emitter<UsersStates> emit)async{
    emit(state.copyWith(apiStatus: ApiStatus.Loading,message: '',postList: [],timeTaken: 0.00));
    await usersRepository.fetchUsers().then((value){
      emit(state.copyWith(
        apiStatus: ApiStatus.Success,
        postList: value['data'],
        timeTaken: value['timeTaken'],
      ));

    }).onError((error,stackTrace) {
      print(error.toString() + 'aa');
      print(stackTrace.toString() + 'bbr');
      emit(state.copyWith(apiStatus: ApiStatus.Failed,message: error.toString(),timeTaken: 0.00));
    });
  }

  void refreshUsersApi(UsersRefresh event, Emitter<UsersStates> emit)async{
    emit(state.copyWith(apiStatus: ApiStatus.Refresh,message: '',postList: [],timeTaken: 0.00));
    await usersRepository.fetchUsers().then((value){
      emit(state.copyWith(
        apiStatus: ApiStatus.Success,
        postList: value['data'],
        timeTaken: value['timeTaken'],
      ));

    }).onError((error,stackTrace) {
      print(error.toString() + 'aa');
      print(stackTrace.toString() + 'bbr');
      emit(state.copyWith(apiStatus: ApiStatus.Failed,message: error.toString(),timeTaken: 0.00));
    });
  }

}
