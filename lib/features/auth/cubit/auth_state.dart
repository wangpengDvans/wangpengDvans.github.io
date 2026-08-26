part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final UserRole userRole;

  const AuthState({required this.userRole});

  @override
  List<Object?> get props => [userRole];
}
