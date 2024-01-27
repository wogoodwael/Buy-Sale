import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/my_advertise_model.dart';
import 'package:shopping/data/services/apis.dart';

part 'my_advertisement_state.dart';

class MyAdvertisementCubit extends Cubit<MyAdvertisementState> {
  MyAdvertisementCubit(this.apiServices) : super(MyAdvertisementInitial());
  ApiServices apiServices;
  MyAdvertisementModel? myAdvertisementModel;
  void getMyAdvertiseCubit() async {
    emit(MyAdvertisementLoading());
    try {
      myAdvertisementModel = await apiServices.getMyAdvertise();
      emit(MyAdvertisementSuccess());
    } catch (e) {
      print(e.toString());
      emit(MyAdvertisementFail());
    }
  }
}
