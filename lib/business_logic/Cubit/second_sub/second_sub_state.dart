part of 'second_sub_cubit.dart';

@immutable
sealed class SecondSubState {}

final class SecondSubInitial extends SecondSubState {}
final class SecondSubLoading extends SecondSubState {}
final class SecondSubSuccess extends SecondSubState {}
final class SecondSubFail extends SecondSubState {}
