// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProcessAdapter extends TypeAdapter<Process> {
  @override
  final int typeId = 3;

  @override
  Process read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Process(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      laborCost: fields[3] as double,
      energyCost: fields[4] as double,
      otherCosts: fields[5] as double,
      requiredMaterials: (fields[6] as List).cast<String>(),
      materialQuantities: (fields[7] as Map).cast<String, double>(),
    );
  }

  @override
  void write(BinaryWriter writer, Process obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.laborCost)
      ..writeByte(4)
      ..write(obj.energyCost)
      ..writeByte(5)
      ..write(obj.otherCosts)
      ..writeByte(6)
      ..write(obj.requiredMaterials)
      ..writeByte(7)
      ..write(obj.materialQuantities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
