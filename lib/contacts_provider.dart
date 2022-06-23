import 'package:demo_app/my_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsProvider extends StateNotifier<MyContacts> {
  ContactsProvider(MyContacts state) : super(state);
}
