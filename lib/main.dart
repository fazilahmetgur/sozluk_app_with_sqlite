import 'package:flutter/material.dart';
import 'package:sozluk_app/DetaySayfa.dart';
import 'package:sozluk_app/Kelimeler.dart';
import 'package:sozluk_app/Kelimelerdao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({
    super.key,
  });

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu=false;
  String aramaKelimesi='';

  Future<List<Kelimeler>> tumKelimeleriGoster() async{
    
    var kelimelerListesi= await Kelimelerdao().tumKelimeler();
    return kelimelerListesi;
  }
    Future<List<Kelimeler>> aramaYap(String aramaKelimesi) async{
    
    var kelimelerListesi= await Kelimelerdao().kelimeAra(aramaKelimesi);
    return kelimelerListesi;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          aramaYapiliyorMu ? IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu=false;
              aramaKelimesi='';
            });
          }, icon: const Icon(Icons.cancel))
          : IconButton(onPressed: (){
          setState(() {
            aramaYapiliyorMu=true;
          },);
        }, icon: const Icon(Icons.search),),],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: aramaYapiliyorMu?
        TextField(
          decoration:const InputDecoration(hintText: 'Arama Yapın') ,
          onChanged: (aramaSonucu){
            // ignore: avoid_print
            print('Arama Sonucu : $aramaSonucu' );
            setState(() {
              aramaKelimesi=aramaSonucu;
            });
          },
        ) 
        : const Text("Sözlük Uygulaması"),
        centerTitle: true,
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Kelimeler>>(
          
          future: aramaYapiliyorMu? aramaYap(aramaKelimesi): tumKelimeleriGoster(),
          builder:(context,snapshot){
           
            if(snapshot.hasData){
              var kelimelerListesi= snapshot.data;
              return ListView.builder(
                itemCount: kelimelerListesi!.length,
                itemBuilder: (context,indeks){
                  var kelime=kelimelerListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetaySayfa(kelime: kelime,)));
                    },
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(kelime.ingilizce, style: const TextStyle(fontWeight: FontWeight.bold),),
                            Text(kelime.turkce),
                    
                          ],
                        ),
                      ),
                    ),
                  );
                }
              );
      
            }
            else{
              return const Center();
            }
          }
          
        ),
      ),
    );
  }
}
