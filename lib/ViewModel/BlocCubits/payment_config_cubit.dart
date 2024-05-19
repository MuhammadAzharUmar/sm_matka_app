import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/payment_config_model.dart';

class PaymentConfigCubit extends Cubit<PaymentConfigModel> {
  PaymentConfigCubit(super.initialState);
  static PaymentConfigModel paymentConfigModel =
      PaymentConfigModel.fromJson({});

  void updateAppDetails(PaymentConfigModel newPaymentConfigModel) {
    paymentConfigModel = newPaymentConfigModel;
    emit(paymentConfigModel);
  }
}
