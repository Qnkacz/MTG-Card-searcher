
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:mtg_card_attempt/Card.dart';

class FileUtils{
  static File jsonFile;
  static Directory dir;
  static String fileName = "save.json";
  static bool fileExists = false;
  static String fileContent;
  static void createFile(String content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  static void writeToFile(String value) {
    print("Writing to file!");
    if (fileExists) {
      print("File exists");
      String jsonFileContent = jsonFile.readAsStringSync();
      jsonFileContent=value;
      jsonFile.writeAsStringSync(jsonFileContent);
    } else {
      print("File does not exist!");
      createFile(value, dir, fileName);
    }
   fileContent = jsonFile.readAsStringSync();
    print(fileContent);
  }

  static void clearFile(){
      jsonFile.delete();
  }

}