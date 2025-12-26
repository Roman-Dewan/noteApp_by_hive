import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_notes/Boxes/boxes.dart';
import 'package:hive_notes/models/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes By Hive"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Text(
                            data[index].title.toString(),
                            style: TextStyle(fontWeight: .bold, fontSize: 20),
                          ),
                          Spacer(),
                          // edit
                          TextButton(onPressed: () {}, child: Icon(Icons.edit)),
                          // delete
                          TextButton(
                            onPressed: () {
                              delete(data[index]);
                            },
                            child: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                      Text(
                        data[index].description.toString(),
                        maxLines: 2,
                        overflow: .ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // add new tsk.

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Data"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // title
                TextFormField(
                  controller: _titleTEController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Title",
                  ),
                ),
                const SizedBox(height: 8),
                // description
                TextFormField(
                  maxLines: 3,
                  controller: _descriptionTEController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Description",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),

            // Add Button
            TextButton(
              onPressed: () {
                final data = NotesModel(
                  title: _titleTEController.text,
                  description: _descriptionTEController.text,
                );
                final box = Boxes.getData();
                box.add(data);

                debugPrint("ttile: ${_titleTEController.text}");
                debugPrint("ttile: ${_descriptionTEController.text}");

                // data.save();
                _titleTEController.clear();
                _descriptionTEController.clear();

                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
  // delete task

  void delete(NotesModel notesModel) async{
    await notesModel.delete();
  }
}
