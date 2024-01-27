import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';

part 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  SubCategoriesCubit(this.apiServices) : super(SubCategoriesInitial());
  ApiServices apiServices;
  SubCategoriesModel? subCategoriesModel;
  void getSubCategoriesCubit() async {
    emit(SubCategoriesLoading());
    try {
      subCategoriesModel = await apiServices.getSubCategories();
      emit(SubCategoriesSuccess());
    } catch (e) {
      print(e.toString());
      emit(SubCategoriesFail());
    }
  }
}
