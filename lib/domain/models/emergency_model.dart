import 'package:hive/hive.dart';
part 'emergency_model.g.dart';

@HiveType(typeId: 0)
class EmergencyModel extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int number;

  EmergencyModel({required this.name, required this.number});
}