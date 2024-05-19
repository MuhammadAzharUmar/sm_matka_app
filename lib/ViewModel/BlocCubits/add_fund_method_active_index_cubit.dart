import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveFundMethodActiveIndexCubit extends Cubit<int>{
  ActiveFundMethodActiveIndexCubit():super(0);
  updateIndex(int newIndex){
    emit(newIndex);
  }
}