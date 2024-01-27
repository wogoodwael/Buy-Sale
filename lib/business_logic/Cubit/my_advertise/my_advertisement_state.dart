part of 'my_advertisement_cubit.dart';

@immutable
sealed class MyAdvertisementState {}

final class MyAdvertisementInitial extends MyAdvertisementState {}
final class MyAdvertisementLoading extends MyAdvertisementState {}
final class MyAdvertisementSuccess extends MyAdvertisementState {}
final class MyAdvertisementFail extends MyAdvertisementState {}
