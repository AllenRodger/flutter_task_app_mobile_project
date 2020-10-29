
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> saveData(List data) async {
    String dataString = json.encode(data);
    final file = await getFile();
    return file.writeAsString(dataString);
  }

  Future<String> readData() async {
    try{
      final file = await getFile();
      return file.readAsString();
  }catch (e){
      return 'Error';
    }
  }

}