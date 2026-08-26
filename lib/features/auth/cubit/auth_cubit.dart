import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

enum UserRole { family, merchant, cemetery }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState(userRole: UserRole.family));

  void switchRole(UserRole role) {
    emit(AuthState(userRole: role));
  }
}
