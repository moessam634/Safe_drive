// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_model2.dart';

class EmergencyModel2Adapter extends TypeAdapter<EmergencyModel2> {
  @override
  final int typeId = 1;

  @override
  EmergencyModel2 read(BinaryReader reader) {
    return EmergencyModel2(
      decision: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyModel2 obj) {
    writer.writeString(obj.decision);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EmergencyModel2Adapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
