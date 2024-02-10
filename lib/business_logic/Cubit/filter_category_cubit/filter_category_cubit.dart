import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/filter_model.dart';
import 'package:shopping/data/services/apis.dart';

part 'filter_category_state.dart';

class FilterCategoryCubit extends Cubit<FilterCategoryState> {
  FilterCategoryCubit(this.apiServices) : super(FilterCategoryInitial());
  ApiServices apiServices;
  FilterModel? filterModel;
  void getCategoryFilterCubit({String? name}) async {
    emit(FilterCategoryLoading());
    try {
      filterModel = await apiServices.getCategoryFilter(name: name!);
      emit(FilterCategorySuccess());
    } catch (e) {
      print(e.toString());
      emit(FilterCategoryFail());
    }
  }
}
