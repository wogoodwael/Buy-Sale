import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:shopping/data/models/sub_categories_adv_model.dart';
import 'package:shopping/data/services/apis.dart';

part 'sub_cate_create_adv_state.dart';

class SubCateCreateAdvCubit extends Cubit<SubCateCreateAdvState> {
  SubCateCreateAdvCubit(this.apiServices, this.lenght)
      : super(SubCateCreateAdvInitial());
  ApiServices apiServices;
  SubCategoriesAdvModel? subCategoriesModel;
  int? lenght;
  void subCateCreateAdvCubit() async {
    emit(SubCateCreateAdvLoading());
    try {
      subCategoriesModel = await apiServices.getSubCategoriesAdv();
      lenght = subCategoriesModel!.data!.length;
      emit(SubCateCreateAdvSuccess());
    } catch (e) {
      print(e.toString());
      emit(SubCateCreateAdvFail());
    }
  }
}
