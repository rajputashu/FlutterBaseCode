part of 'login_bloc.dart';

// ignore: must_be_immutable
class LoginState extends Equatable {
  late String? email;
  late String? password;
  late ApiStatus apiStatus;

  LoginState(
      {this.email, this.password, this.apiStatus = ApiStatus.IS_INITIAL});

  @override
  List<Object?> get props => [email, password, apiStatus];

  LoginState copyWith({String? email, String? password, ApiStatus? apiStatus}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        apiStatus: apiStatus ?? this.apiStatus);
  }
}
