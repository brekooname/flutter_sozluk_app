import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/Words.dart';

class DetailPage extends StatefulWidget {

  Words word;


  DetailPage({required this.word});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.word.english, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.red),),
            Text(widget.word.turkish, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
          ],
        ),
      ),
    );
  }
}
