part of 'attrs_categories_cubit.dart';

@immutable
sealed class AttrsCategoriesState {}

final class AttrsCategoriesInitial extends AttrsCategoriesState {}
final class AttrsCategoriesLoading extends AttrsCategoriesState {}
final class AttrsCategoriesSuccess extends AttrsCategoriesState {}
final class AttrsCategoriesFail extends AttrsCategoriesState {}
