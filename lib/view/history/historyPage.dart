import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class FileModel {
  final int id;
  final String fileName;
  final String filePath;

  FileModel({required this.id, required this.fileName, required this.filePath});

  Map<String, dynamic> toMap() {
    return {'id': id, 'fileName': fileName, 'filePath': filePath};
  }
}

class DatabaseHelper {
  static Database? _database;
  static final String tableName = 'files';
  static final String columnId = 'id';
  static final String columnFileName = 'fileName';
  static final String columnFilePath = 'filePath';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'files.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnFileName TEXT,
        $columnFilePath TEXT
      )
    ''');
  }

  Future<int> insertFile(FileModel file) async {
    Database db = await database;
    return await db.insert(tableName, file.toMap());
  }

  Future<List<FileModel>> getFiles() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return FileModel(
        id: maps[i][columnId],
        fileName: maps[i][columnFileName],
        filePath: maps[i][columnFilePath],
      );
    });
  }
}



class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageScreen createState() => _HistoryPageScreen();
}

class _HistoryPageScreen extends State<HistoryPage> {
  final dbHelper = DatabaseHelper();
  late List<FileModel> files;

  @override
  void initState() {
    super.initState();
    _refreshFileList();
  }

  Future<void> _refreshFileList() async {
    List<FileModel> fetchedFiles = await dbHelper.getFiles();
    setState(() {
      files = fetchedFiles;
    });
  }

  Future<void> _pickAndSaveFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;
      String filePath = result.files.single.path!;
      int id = await dbHelper.insertFile(FileModel(id: 0, fileName: fileName, filePath: filePath));
      setState(() {
        files.add(FileModel(id: id, fileName: fileName, filePath: filePath));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(files[index].fileName),
                  subtitle: Text(files[index].filePath),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _pickAndSaveFile,
            child: Icon(Icons.attach_file),
          ),
        ],
      ),
    );
  }
}
