import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes By Hive"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          FutureBuilder(future: Hive.openBox('db1'), 
          builder: (BuildContext context, AsyncSnapshot<Box<dynamic>> snapshot){
            return ListTile(
              /// there [Data] cant be null
              title: Text(snapshot.data?.get('name') ?? "null"),
              subtitle: Text(snapshot.data?.get('details')?['location'] ?? "no location"),
              trailing: IconButton(onPressed: (){
                snapshot.data!.put('name', 'roman');
                // snapshot.data!.delete('name');
                setState(() {
                  
                });
              }, icon: Icon(Icons.edit)),
            );
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('db1');
          box.put("name", "roman-dewan");

          box.put("age", 12);

          box.put('details', {'name': 'roman', 'age': 20, 'location': 'dhaka'});

          debugPrint(box.get('name'));
          debugPrint(box.get('age').toString());
          debugPrint(box.get("details")['age'].toString());
          debugPrint(box.get("details").toString());
          setState(() {
            
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}