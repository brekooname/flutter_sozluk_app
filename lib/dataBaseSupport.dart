import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSupport{

  static final String databaseName = "sozluk.sqlite";

  static Future<Database> dataBaseAccess() async {
    String dataBaseRoute = join(await getDatabasesPath(), databaseName);

    if(await databaseExists(dataBaseRoute)){
      print("Veritabanı zaten var. Kopyalamaya gerek yok.");
    }else{
      ByteData data = await rootBundle.load("database/$databaseName");

      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(dataBaseRoute).writeAsBytes(bytes, flush: true);
      print("Veribanaı kopyalandı");
    }
    return openDatabase(dataBaseRoute);
  }
}