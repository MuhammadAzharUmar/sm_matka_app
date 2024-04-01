import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';

class AppDetailsCubit extends Cubit<AppDetailsModel> {
  AppDetailsCubit(super.initialState);
  static AppDetailsModel appDetailsModel = AppDetailsModel.fromJson({});

  void updateAppDetails(AppDetailsModel newAppDetailsModel) {
    appDetailsModel = newAppDetailsModel;
    emit(appDetailsModel);
  }
}
