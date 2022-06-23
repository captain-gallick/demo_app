import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final name = arguments['name'];
    final phone = arguments['phone'];
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Text(
                        'Phone Number : ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        phone,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
