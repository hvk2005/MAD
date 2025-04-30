// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumptionLogAdapter extends TypeAdapter<ConsumptionLog> {
  @override
  final int typeId = 4;

  @override
  ConsumptionLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsumptionLog(
      id: fields[0] as String,
      materialId: fields[1] as String,
      processId: fields[2] as String,
      operatorId: fields[3] as String,
      quantity: fields[4] as double,
      timestamp: fields[5] as DateTime,
      isSynced: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ConsumptionLog obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.materialId)
      ..writeByte(2)
      ..write(obj.processId)
      ..writeByte(3)
      ..write(obj.operatorId)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsumptionLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
