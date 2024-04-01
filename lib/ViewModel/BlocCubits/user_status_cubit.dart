import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/user_status_model.dart';

class UserStatusCubit extends Cubit<UserStatusModel> {
  UserStatusCubit(super.initialState);
  static UserStatusModel user = UserStatusModel.fromJson(
    {},
  );

  void updateAppUserStatus(UserStatusModel newUserStatus) {
    user = newUserStatus;
    emit(user);
  }
}
