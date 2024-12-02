import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:sleepless_app/blocs/auth/auth_bloc.dart';
import 'package:sleepless_app/blocs/auth/auth_event.dart';
import 'package:sleepless_app/blocs/auth/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}

void main() {
  setupFirebaseAuthMocks();

  late AuthBloc authBloc;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    authBloc = AuthBloc(firebaseAuth: mockFirebaseAuth);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(authBloc.state, isA<AuthInitial>());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] when SignInRequested is successful',
      build: () {
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password123',
        )).thenAnswer((_) async => mockUserCredential);
        when(mockUserCredential.user).thenReturn(mockUser);
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInRequested(
        'test@example.com',
        'password123',
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<Authenticated>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when SignInRequested fails',
      build: () {
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'wrongpassword',
        )).thenThrow(
          FirebaseAuthException(code: 'wrong-password'),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInRequested(
        'test@example.com',
        'wrongpassword',
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] when SignUpRequested is successful',
      build: () {
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'new@example.com',
          password: 'password123',
        )).thenAnswer((_) async => mockUserCredential);
        when(mockUserCredential.user).thenReturn(mockUser);
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpRequested(
        'new@example.com',
        'password123',
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<Authenticated>(),
      ],
    );
  });
}