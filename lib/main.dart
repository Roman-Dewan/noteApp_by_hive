import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_notes/app.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  runApp(const MyApp());
  
}

