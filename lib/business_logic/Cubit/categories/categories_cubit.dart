import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/categories_model.dart';
import 'package:shopping/data/services/apis.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.apiServices) : super(CategoriesInitial());
  ApiServices apiServices;
  CategoriesModel? categoriesModel;
  void getCategoriesCubit() async {
    emit(CategoriesLoading());
    try {
      categoriesModel = await apiServices.getCategories();
      emit(CategoriesSuccess());
    } catch (e) {
      print(e.toString());
      emit(CategoriesFail());
    }
  }
}
