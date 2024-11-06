import 'package:hive/hive.dart';

part 'emergency_model2.g.dart';

@HiveType(typeId: 1)
class EmergencyModel2 extends HiveObject {
  @HiveField(0)
  final String decision;

  EmergencyModel2({required this.decision});
}
