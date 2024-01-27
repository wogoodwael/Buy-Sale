import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/advertisement_model.dart';
import 'package:shopping/data/services/apis.dart';

part 'advertisment_state.dart';

class AdvertismentCubit extends Cubit<AdvertismentState> {
  AdvertismentCubit(this.apiServices) : super(AdvertismentInitial());
  ApiServices apiServices;
  AdvertismentModel? advertismentModel;
  void getAdvertismentCubit() async {
    emit(AdvertismentLoading());
    try {
      advertismentModel = await apiServices.getAdvertisement();
      emit(AdvertismentSuccess());
    } catch (e) {
      print(e.toString());
      emit(AdvertismentFail());
    }
  }
}
