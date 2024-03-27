import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';
import 'package:shopping/data/services/apis.dart';

part 'attrs_categories_state.dart';

class AttrsCategoriesCubit extends Cubit<AttrsCategoriesState> {
  AttrsCategoriesCubit(this.apiServices) : super(AttrsCategoriesInitial());
  ApiServices apiServices;
  GetCateAttrsModel? getCateAttrsModel;
  int? lenght;
  void getCategoriesAttrsCubit({required String id }) async {
    emit(AttrsCategoriesLoading());

    try {
      getCateAttrsModel = await apiServices.getCategoriesAttrs(id: id);
      lenght = getCateAttrsModel!.data!.length;
      if (lenght != null && lenght! > 0) {
        emit(AttrsCategoriesSuccess());
      } else {
        emit(AttrsCategoriesFail());
      }
    } catch (e) {
      print(e.toString());
      emit(AttrsCategoriesFail());
    }
  }
}
