import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit(super.initialState);
  static UserModel user = UserModel.fromJson(json: {}, token: "");

  void updateAppUser(UserModel newUser) {
    user = newUser;
    emit(user);
  }
}
