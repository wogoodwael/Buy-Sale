import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/data/services/apis.dart';

part 'second_sub_state.dart';

class SecondSubCubit extends Cubit<SecondSubState> {
  SecondSubCubit(
    this.apiServices,
  ) : super(SecondSubInitial());
  ApiServices apiServices;
  SubCategoriesModel? subCategoriesModel;
  void secondSubCubit({required String id}) async {
    emit(SecondSubLoading());
    try {
      subCategoriesModel = await apiServices.getSecondSubCategoriesAdv(id: id);
      emit(SecondSubSuccess());
    } catch (e) {
      print(e.toString());
      emit(SecondSubFail());
    }
  }
}
