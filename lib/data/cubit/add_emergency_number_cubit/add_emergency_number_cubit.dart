import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:safedrive/app/app_texts.dart';
import 'package:safedrive/domain/models/emergency_model.dart';

part 'add_emergency_number_state.dart';

class AddEmergencyNumberCubit extends Cubit<AddEmergencyNumberState> {
  AddEmergencyNumberCubit() : super(AddEmergencyNumberInitial());

  static AddEmergencyNumberCubit get(context) => BlocProvider.of(context);

  addEmergencyNumber(EmergencyModel emergencyModel) async {
    emit(AddEmergencyNumberLoading());
    try {
      var emergencyBox = Hive.box<EmergencyModel>(AppText.emergencyBox);
      await emergencyBox.add(emergencyModel);
      emit(AddEmergencyNumberSuccess());
    } catch (e) {
      emit(AddEmergencyNumberError(e.toString()));
    }
  }
}
