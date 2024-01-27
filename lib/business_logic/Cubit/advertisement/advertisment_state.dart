part of 'advertisment_cubit.dart';

@immutable
sealed class AdvertismentState {}

final class AdvertismentInitial extends AdvertismentState {}
final class AdvertismentLoading extends AdvertismentState {}
final class AdvertismentSuccess extends AdvertismentState {}
final class AdvertismentFail extends AdvertismentState {}
