part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}
class UserFailure extends UserState {
  @override
  List<Object> get props => [];
}

class UserSuccess extends UserState {
  @override
  List<Object> get props => [];
}
