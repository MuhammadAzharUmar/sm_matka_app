import 'package:flutter_bloc/flutter_bloc.dart';
enum AppLoadingStates {
  initialLoading,
  withdrawFundSubmitRequest,
  bankDetailSubmitButton,
  pinLoginProceed,
  changePasswordSubmit,
  gameBidSubmitButton,
  homePageAppDetailsApiLoading,
  updateProfileButton,
  historySubmitLoading,
  signupButtonLoading,
  loginbuttonLoading,
  verifyOtpResendLoading,
  forgotPasswordLoading,
  forgotPinLoading,
  updatePhonePeGPayPaytm,
  transferSubmitButtonLoading,
  homePageInitDataLoading,


}


class AppLoadingCubit extends Cubit<AppLoadingStates> {
  AppLoadingCubit(super.initialState);

  void updateAppLoadingState(AppLoadingStates newState) {
    emit(newState);
  }
}
