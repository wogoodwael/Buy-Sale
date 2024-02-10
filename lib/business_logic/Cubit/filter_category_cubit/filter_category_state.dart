part of 'filter_category_cubit.dart';

@immutable
sealed class FilterCategoryState {}

final class FilterCategoryInitial extends FilterCategoryState {}
final class FilterCategoryLoading extends FilterCategoryState {}
final class FilterCategorySuccess extends FilterCategoryState {}
final class FilterCategoryFail extends FilterCategoryState {}
