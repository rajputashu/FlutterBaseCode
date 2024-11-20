// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

class LoginEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailChange extends LoginEvents {
  late String email;
  EmailChange(this.email);
}

class PasswordChange extends LoginEvents {
  late String password;
  PasswordChange(this.password);
}

class LoginApiCall extends LoginEvents {}
