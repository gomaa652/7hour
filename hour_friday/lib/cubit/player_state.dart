part of 'player_cubit.dart';

class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerSuccsful extends PlayerState {
  final List player;

  PlayerSuccsful({required this.player});
}

class PlayerError extends PlayerState {  final String message;

  PlayerError({required this.message});}

class PlayerLoading extends PlayerState {

}
