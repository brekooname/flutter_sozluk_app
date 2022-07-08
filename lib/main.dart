import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/DetailPage.dart';
import 'package:sozluk_uygulamasi/Words.dart';
import 'package:sozluk_uygulamasi/Wordsdao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool makeCall = false;
  String callWord = "";

  String? get searchWord => null;


  Future<List<Words>> allWordsShow() async {

    var wordsList = await Wordsdao().allWords();
    return wordsList;
  }

  Future<List<Words>> call(String searchWord) async {

    var wordsList = await Wordsdao().wordSearch(searchWord);
    return wordsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: makeCall ?
            TextField(
              decoration: InputDecoration(hintText: "Arama yapmak için yazınız"),
              onChanged: (callFinish){
                print("Arama Sonucu : $callFinish");
                setState(() {
                  callWord = callFinish;
                });
              },
            )
            : Text("Sözlük uygulaması"),
        actions: [
          makeCall ?
          IconButton(
              icon: Icon(Icons.cancel),
              onPressed:(){
                setState(() {
                  makeCall = false;
                  callWord = "";
                });
              }
          )
          : IconButton(
              icon: Icon(Icons.search),
              onPressed:(){
                setState(() {
                  makeCall = true;
                });
              }
          ),
        ],
      ),
      body: FutureBuilder<List<Words>>(
        future: makeCall ? call(searchWord!) : allWordsShow(),
        builder: (context,snapshot){

          if(snapshot.hasData){
            
            var wordsList = snapshot.data;
            return ListView.builder(
              itemCount: wordsList!.length,
              itemBuilder: (context,index){
                var word = wordsList[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(word: word,)));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(word.english, style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(word.turkish),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },

      ),

    );
  }
}

