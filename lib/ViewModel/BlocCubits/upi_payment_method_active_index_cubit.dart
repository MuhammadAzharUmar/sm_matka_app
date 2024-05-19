import 'package:flutter_bloc/flutter_bloc.dart';

class UPIpaymentMethodActiveIndexCubit extends Cubit<int>{
  UPIpaymentMethodActiveIndexCubit():super(-1);
  updateIndex(int newIndex){
    emit(newIndex);
  }
}