import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../../app/app_texts.dart';
import '../../../domain/models/emergency_model.dart';

part 'emergency_item_state.dart';

class EmergencyItemCubit extends Cubit<EmergencyItemState> {
  EmergencyItemCubit() : super(EmergencyItemInitial());
  List<EmergencyModel>? emergencyItem;

  fetchAllEmergencyItem() {
    var emergencyBox = Hive.box<EmergencyModel>(AppText.emergencyBox);
    emergencyItem = emergencyBox.values.toList();
    emit(EmergencyItemSuccess());
  }
}
