import 'dart:developer';

import 'package:demo_app/my_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';
import 'contacts_adapter.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  final List<MyContacts> list = [];
  final List<String> sortMenu = [
    'Sort by A->Z',
    'Sort by Z->A',
    'Sort by 1->10',
    'Sort by 10->1'
  ];

  String sortBy = '-';

  final StateProvider<int> _listProvider = StateProvider((ref) => 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getContactsStream());
  }

  getContactsStream() async {
    await Hive.openBox<ContactsAdapter>(Constants.hiveBox);
    var box = Hive.box<ContactsAdapter>(Constants.hiveBox);
    var mKeys = box.keys;
    for (var items in mKeys) {
      list.add(
          MyContacts(name: box.get(items)!.name, phone: box.get(items)!.phone));
      ref.read(_listProvider.state).state = list.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Demo App'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.filter_alt_outlined),
              onSelected: (value) {
                sortBy = value.toString();
                sortList(sortBy);
              },
              itemBuilder: (context) {
                return sortMenu.map((String s) {
                  return PopupMenuItem<String>(
                    value: s,
                    child: Text(s),
                  );
                }).toList();
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addNewContact();
          },
          child: const Icon(Icons.add),
        ),
        body: getListItems(),
      ),
    );
  }

  getListItems() {
    return ListView.builder(
        itemCount: ref.watch(_listProvider.state).state,
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/details', arguments: {
                  'name': list[position].name,
                  'phone': list[position].phone
                });
              },
              title: Text(list[position].name),
              subtitle: Text(list[position].phone),
            ),
          );
        });
  }

  addNewContact() {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      'Add New Contact',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Name'),
                    ),
                    TextField(
                      maxLength: 10,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(hintText: 'Phone'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              (phoneController.text.isNotEmpty &&
                                  phoneController.text.length == 10)) {
                            addToDatabase(
                                nameController.text, phoneController.text);
                            Navigator.pop(context);
                          } else {
                            if (nameController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please enter a name"),
                              ));
                            } else if (phoneController.text.isEmpty ||
                                phoneController.text.length < 10) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("Please enter a valid phone number"),
                              ));
                            }
                          }
                        },
                        child: const Text('Add'))
                  ],
                ),
              ),
            ),
          );
        });
  }

  addToDatabase(String name, String phone) async {
    var box = Hive.box<ContactsAdapter>(Constants.hiveBox);
    await box.add(ContactsAdapter(name, phone)).then((value) => list.add(
        MyContacts(name: box.get(value)!.name, phone: box.get(value)!.phone)));
    ref.read(_listProvider.state).state = list.length;
    sortList(sortBy);
  }

  sortList(String num) {
    switch (num) {
      case 'Sort by A->Z':
        list.sort((a, b) => a.name
            .toString()
            .toLowerCase()
            .compareTo(b.name.toString().toLowerCase()));
        break;
      case 'Sort by Z->A':
        list.sort((a, b) => b.name
            .toString()
            .toLowerCase()
            .compareTo(a.name.toString().toLowerCase()));
        break;
      case 'Sort by 1->10':
        list.sort((a, b) => a.phone
            .toString()
            .toLowerCase()
            .compareTo(b.phone.toString().toLowerCase()));
        break;
      case 'Sort by 10->1':
        list.sort((a, b) => b.phone
            .toString()
            .toLowerCase()
            .compareTo(a.phone.toString().toLowerCase()));
        break;
    }
    ref.refresh(_listProvider.state);
  }
}
