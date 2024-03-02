import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';

part 'sub_cate_create_adv_state.dart';

class SubCateCreateAdvCubit extends Cubit<SubCateCreateAdvState> {
  SubCateCreateAdvCubit(this.apiServices, this.lenght)
      : super(SubCateCreateAdvInitial());
  ApiServices apiServices;
  SubCategoriesModel? subCategoriesModel;
  int? lenght;
  void subCateCreateAdvCubit() async {
    emit(SubCateCreateAdvLoading());

    // Start a timer to transition to fail state if data is not received after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      if (state is SubCateCreateAdvLoading) {
        emit(SubCateCreateAdvFail());
      }
    });

    try {
      subCategoriesModel = await apiServices.getSubCategoriesAdv();
      lenght = subCategoriesModel!.data!.categories!.length;
      emit(SubCateCreateAdvSuccess());
    } catch (e) {
      print(e.toString());
      emit(SubCateCreateAdvFail());
    }
  }
}
