import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/city_model.dart';
import 'package:shopping/data/services/apis.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit(this.apiServices) : super(CitiesInitial());
  ApiServices apiServices;
  CityModel? cityModel;
  void getCitiesCubit({required String countryId}) async {
    emit(CitiesLoading());
    try {
      cityModel = await apiServices.getCities(countryId: countryId);
      emit(CitiesSuccess());
    } catch (e) {
      print(e.toString());
      emit(CitiesFail());
    }
  }
}
