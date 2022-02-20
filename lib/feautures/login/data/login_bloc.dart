import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshflow_test/services/auth_service.dart';

class LoginBlocState extends Equatable {
  final bool isLoggedIn;
  final bool hasError;
  final bool isLoading;

  const LoginBlocState({
    this.isLoggedIn = false,
    this.hasError = false,
    this.isLoading = false,
  });

  LoginBlocState copyWith({
    bool isLoggedIn = false,
    bool hasError = false,
    bool isLoading = false,
  }) =>
      LoginBlocState(
        isLoggedIn: isLoggedIn,
        hasError: hasError,
        isLoading: isLoading,
      );

  @override
  List<Object?> get props => [
        isLoggedIn,
        hasError,
        isLoading,
      ];
}

class LoginCubit extends Cubit<LoginBlocState> {
  final BaseAuthService auth;

  LoginCubit(this.auth) : super(const LoginBlocState());

  void signIn(String email, String password) async {
    String? userId;
    emit(state.copyWith(isLoading: true));
    try {
      userId = await auth.signIn(email.trim(), password);
    } catch (e) {
      emit(state.copyWith(
        isLoggedIn: false,
        hasError: false,
        isLoading: false,
      ));
      print(e);
    }
    emit(state.copyWith(
      isLoggedIn: userId != null,
      hasError: false,
      isLoading: false,
    ));
  }

  Future<void> getCurrentUser() async {
    final user = await auth.getCurrentUser();
    if (user != null) {
      emit(state.copyWith(
        isLoggedIn: true,
      ));
    }
  }

  void logOut() async {
    await auth.signOut();
    emit(state.copyWith(
      isLoggedIn: false,
      hasError: false,
      isLoading: false,
    ));
  }
}
