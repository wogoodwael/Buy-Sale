part of 'cities_cubit.dart';

@immutable
sealed class CitiesState {}

final class CitiesInitial extends CitiesState {}
final class CitiesLoading extends CitiesState {}
final class CitiesSuccess extends CitiesState {}
final class CitiesFail extends CitiesState {}
