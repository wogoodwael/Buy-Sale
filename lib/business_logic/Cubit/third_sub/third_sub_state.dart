part of 'third_sub_cubit.dart';

@immutable
sealed class ThirdSubState {}

final class ThirdSubInitial extends ThirdSubState {}
final class ThirdSubLoading extends ThirdSubState {}
final class ThirdSubSuccess extends ThirdSubState {}
final class ThirdSubFail extends ThirdSubState {}
