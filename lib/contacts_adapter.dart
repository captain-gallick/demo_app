import 'package:hive_flutter/adapters.dart';

part 'contacts_adapter.g.dart';

@HiveType(typeId: 1)
class ContactsAdapter {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phone;

  ContactsAdapter(this.name, this.phone);
}
