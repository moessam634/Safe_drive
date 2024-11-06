

part of 'emergency_model.dart';

class EmergencyModelAdapter extends TypeAdapter<EmergencyModel> {
  @override
  final int typeId = 0;

  @override
  EmergencyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmergencyModel(
      name: fields[0] as String,
      number: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
