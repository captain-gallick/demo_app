// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactsAdapterAdapter extends TypeAdapter<ContactsAdapter> {
  @override
  final int typeId = 1;

  @override
  ContactsAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactsAdapter(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactsAdapter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactsAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
