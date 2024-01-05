import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_application/service/database_client.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('달력'),
      ),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2300),
            onDateChanged: (value) {
              _dateTime = value;
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                builder: (context, snapshot) {
                  List<Map<String, dynamic>> data =
                      snapshot.hasData ? snapshot.data! : [];
                  return ListView.builder(
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text('${data[index]['title']}'),
                        trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => DatabaseClient.instance
                                    .deleteNote(
                                  data[index]['id'],
                                )
                                    .then(
                                  (value) {
                                    setState(() {});
                                  },
                                )),
                        onTap: () => Get.toNamed('/note', arguments: data[index]),
                      ),
                    ),
                    itemCount: data.length,
                  );
                },
                future: DatabaseClient.instance.getDatasWithDate(_dateTime.toString().split(' ').first),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(
          '/add',
          arguments: _dateTime.toString().split(' ').first,
        )?.then((value) {
          setState(() {});
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
