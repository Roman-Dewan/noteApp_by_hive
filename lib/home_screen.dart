import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_notes/Boxes/boxes.dart';
import 'package:hive_notes/models/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes By Hive"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(children: [
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Data"),
          content:  SingleChildScrollView(
            child: Column(
              children: [
                // title
                TextFormField(
                  controller: _titleTEController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Title"
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
                    hintText: "Description"
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
                final data = NotesModel(title: _titleTEController.text, description: _descriptionTEController.text);
                final box = Boxes.getData();
                box.add(data);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
