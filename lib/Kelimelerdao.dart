// ignore_for_file: file_names, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sozluk_app/Kelimeler.dart';
import 'package:sozluk_app/VeritabaniYardimcisi.dart';

class Kelimelerdao{
  Future<List<Kelimeler>>tumKelimeler()async{
    var db= await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>>maps=await db.rawQuery("SELECT * FROM kelimeler");

    return List.generate(maps.length, (i){
      var satir=maps[i];
      return Kelimeler(kelime_id: satir["kelime_id"], ingilizce: satir["ingilizce"], turkce: satir["turkce"]);

    });


  }

   Future<List<Kelimeler>>kelimeAra(String aramaKelimesi)async{
    var db =await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>>maps=await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$aramaKelimesi% '");

    return List.generate(maps.length, (i){
      var satir=maps[i];
      return Kelimeler(kelime_id: satir["kelime_id"], ingilizce: satir["ingilizce"], turkce: satir["turkce"]);

    });


  }
}