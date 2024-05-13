import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';

part 'third_sub_state.dart';

class ThirdSubCubit extends Cubit<ThirdSubState> {
  ThirdSubCubit(this.apiServices) : super(ThirdSubInitial());
  ApiServices apiServices;
  SubCategoriesModel? subCategoriesModel;
  void thirdSubCubit({required String id}) async {
    emit(ThirdSubLoading());
    try {
      subCategoriesModel = await apiServices.getThirdSubCategoriesAdv(id: id);
      emit(ThirdSubSuccess());
    } catch (e) {
      print(e.toString());
      emit(ThirdSubFail());
    }
  }
}
