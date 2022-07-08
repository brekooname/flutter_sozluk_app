import 'package:sozluk_uygulamasi/Words.dart';
import 'package:sozluk_uygulamasi/dataBaseSupport.dart';

class Wordsdao {

  Future<List<Words>> allWords() async {
    var db = await DatabaseSupport.dataBaseAccess();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM words");
    
    return List.generate(maps.length, (index) {
      var line = maps[index];
      return Words(line["word_id"], line["english"], line["turkish"]);

    });
  }

  Future<List<Words>> wordSearch(String searchWord) async {
    var db = await DatabaseSupport.dataBaseAccess();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM words WHERE english like '%$searchWord%'");

    return List.generate(maps.length, (index) {
      var line = maps[index];
      return Words(line["word_id"], line["english"], line["turkish"]);

    });
  }
}