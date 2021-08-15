import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:codelabz/domain/auth/auth_repository.dart';
import 'package:codelabz/domain/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(const AuthState.initial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(
      authCheckRequested: (e) async* {
        final userOption = await _authRepository.getSignedInUser();
        yield userOption.fold(
          () => const AuthState.unauthenticated(),
          (user) => AuthState.authenticated(user),
        );
      },
      signedOut: (e) async* {
        await _authRepository.signout();
        yield const AuthState.unauthenticated();
      },
    );
  }
}