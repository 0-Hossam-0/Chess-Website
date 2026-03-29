import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthTab { signIn, signUp }

class AuthCubit extends Cubit<AuthTab> {
  AuthCubit() : super(AuthTab.signIn);

  void switchToSignIn() => emit(AuthTab.signIn);
  void switchToSignUp() => emit(AuthTab.signUp);

  void toggle() {
    emit(state == AuthTab.signIn ? AuthTab.signUp : AuthTab.signIn);
  }
}
