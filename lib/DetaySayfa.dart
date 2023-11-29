// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sozluk_app/Kelimeler.dart';

class DetaySayfa extends StatefulWidget {
  Kelimeler kelime;
  DetaySayfa({super.key, required this.kelime});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detay Sayfa')),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
              Text(widget.kelime.ingilizce, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.amber),),
                Text(widget.kelime.turkce, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
          ],),
        ),
      ),
    );
  }
}