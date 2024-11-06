part of 'add_emergency_number_cubit.dart';

sealed class AddEmergencyNumberState {}

final class AddEmergencyNumberInitial extends AddEmergencyNumberState {}
final class AddEmergencyNumberLoading extends AddEmergencyNumberState {}
final class AddEmergencyNumberSuccess extends AddEmergencyNumberState {}
final class AddEmergencyNumberError extends AddEmergencyNumberState {
  final String errorMsg;

  AddEmergencyNumberError(this.errorMsg);
}


