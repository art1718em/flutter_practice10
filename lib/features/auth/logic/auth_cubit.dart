import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/auth/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  final _uuid = const Uuid();
  final Map<String, Map<String, String>> _users = {};

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 1));

    if (!_isValidEmail(email)) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Неверный формат email',
      ));
      return;
    }

    if (!_users.containsKey(email)) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Пользователь не найден',
      ));
      return;
    }

    if (_users[email]!['password'] != password) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Неверный пароль',
      ));
      return;
    }

    final user = UserModel(
      id: _users[email]!['id']!,
      email: email,
      name: _users[email]!['name']!,
      registrationDate: DateTime.parse(_users[email]!['registrationDate']!),
    );

    emit(state.copyWith(
      status: AuthStatus.authenticated,
      user: user,
      clearError: true,
    ));
  }

  Future<void> register(String email, String password, String name) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 1));

    if (!_isValidEmail(email)) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Неверный формат email',
      ));
      return;
    }

    if (password.length < 6) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Пароль должен быть не менее 6 символов',
      ));
      return;
    }

    if (name.trim().isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Введите имя',
      ));
      return;
    }

    if (_users.containsKey(email)) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Пользователь с таким email уже существует',
      ));
      return;
    }

    final userId = _uuid.v4();
    final registrationDate = DateTime.now();

    _users[email] = {
      'id': userId,
      'password': password,
      'name': name,
      'registrationDate': registrationDate.toIso8601String(),
    };

    final user = UserModel(
      id: userId,
      email: email,
      name: name,
      registrationDate: registrationDate,
    );

    emit(state.copyWith(
      status: AuthStatus.authenticated,
      user: user,
      clearError: true,
    ));
  }

  void logout() {
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  void clearError() {
    emit(state.copyWith(clearError: true));
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

