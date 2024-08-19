import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

Future<Map<String, dynamic>> readJson(String fileName) async {
  final filePath = path.join('test', 'fixtures', '$fileName.json');
  final file = File(filePath);
  final jsonString = await file.readAsString();
  return json.decode(jsonString);
}