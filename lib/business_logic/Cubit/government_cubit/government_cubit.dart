import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/data/models/government_model.dart';
import 'package:shopping/data/services/apis.dart';

part 'government_state.dart';

class GovernmentCubit extends Cubit<GovernmentState> {
  GovernmentCubit(this.apiServices) : super(GovernmentInitial());
  ApiServices apiServices;
  GovernmentModel? governmentModel;
  void  getGovernmentData() async {
    emit(GovernmentLoading());
    
    try {
      governmentModel = await apiServices.getGovernments();
      emit(GovernmentSuccess());
      
    } catch (e) {
      print(e.toString());
      emit(GovernmentFail());
    
    }
    
    
    
  }
  
}
