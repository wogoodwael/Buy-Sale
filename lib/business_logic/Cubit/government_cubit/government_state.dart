part of 'government_cubit.dart';

@immutable
sealed class GovernmentState {}

final class GovernmentInitial extends GovernmentState {}
final class GovernmentSuccess extends GovernmentState {}
final class GovernmentLoading extends GovernmentState {}
final class GovernmentFail extends GovernmentState {}
