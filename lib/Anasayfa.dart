import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iller_ilceler/Ilce.dart';

import 'Sehir.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  List<Sehir> tumSehirler = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      jsonCozumle();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Şehirler ve İlçeleri",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                    itemCount: tumSehirler.length,
                    itemBuilder: sehirListeBuilder
                  )
              )
            ],
          ),
        )
    );
  }

  void jsonCozumle() async {
    String jsonString = await rootBundle.loadString(
        "assets/json_files/iller_ilceler.json"
    );
    Map<String, dynamic> sehirlerMap = jsonDecode(jsonString);

    int ilce_id_counter = 1;
    int sehir_id_counter = 1;

    for(String sehir_plaka in sehirlerMap.keys){
      Map<String, dynamic> sehirMap = sehirlerMap[sehir_plaka];
      String sehir_ad = sehirMap["name"];

      Map<String, dynamic> ilcelerMap = sehirMap["districts"];

      List<Ilce> tumIlceler = [];

      sehir_id_counter++;

      for(String ilce_kodu in ilcelerMap.keys){
        Map<String, dynamic> ilceMap = ilcelerMap[ilce_kodu];
        String ilce_ad = ilceMap["name"];

        Ilce ilce = Ilce(
            ilce_id: "ilce_${ilce_id_counter.toString()}",
            sehir_id: "sehir_${sehir_id_counter.toString()}",
            ilce_ad: ilce_ad
        );
        tumIlceler.add(ilce);

        ilce_id_counter++;
      }

      Sehir sehir = Sehir(
        sehir_id: "sehir_${sehir_id_counter.toString()}",
        sehir_ad: sehir_ad,
        sehir_plaka: sehir_plaka,
        sehir_ilceler: tumIlceler,
      );

      tumSehirler.add(sehir);
    }
    // Her for dongusunde state olusturmak yerine bittikten sonra bir kere yapalim
    setState(() {});
  }

  Widget sehirListeBuilder(BuildContext context, int index){
    return Card(
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tumSehirler[index].sehir_ad,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              tumSehirler[index].sehir_plaka,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),)
          ],
        ),
        leading: Icon(Icons.location_city),
        //trailing: Text(tumSehirler[index].sehir_plaka),
        children: tumSehirler[index].sehir_ilceler.map((ilce){
          return ListTile(
            title: Text(ilce.ilce_ad),
          );
        }).toList(),
      ),
    );
  }
  
}





