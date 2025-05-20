abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;
  RegisterSuccess({required this.message});
}
class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}
