import 'package:apps_architecture/di/injections_container.dart';
import 'package:apps_architecture/modules/login/login_repository.dart';
import 'package:apps_architecture/utils/app_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "login_events.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final loginRepo = locator<LoginRepository>();

  LoginBloc() : super(LoginState()) {
    on<EmailChange>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChange>(_onPasswordChange);
    on<LoginApiCall>(_onLoginApiCall);
  }

  // ignore: unused_element
  void _onEmailChange(EmailChange event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChange(PasswordChange event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginApiCall(
      LoginApiCall event, Emitter<LoginState> emit) async {
    var dbResult = await loginRepo.fetchPostsFromDB();
    List<Map<String, dynamic>> jsonResult =
        dbResult.map((dto) => dto.toJson()).toList();
    print(jsonResult);
    if (dbResult.isNotEmpty) {
      emit(state.copyWith(
        apiStatus: ApiStatus.SUCCESS,
      ));
    } else {
      emit(
        state.copyWith(apiStatus: ApiStatus.ERROR),
      );
    }
  }
}
