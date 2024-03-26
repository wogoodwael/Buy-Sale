part of 'sub_cate_create_adv_cubit.dart';

@immutable
sealed class SubCateCreateAdvState {}

final class SubCateCreateAdvInitial extends SubCateCreateAdvState {}
final class SubCateCreateAdvLoading extends SubCateCreateAdvState {}
final class SubCateCreateAdvSuccess extends SubCateCreateAdvState {}
final class SubCateCreateAdvFail extends SubCateCreateAdvState {}
// 