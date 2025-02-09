import 'package:flutter_iller_ilceler/Ilce.dart';

class Sehir{
  String sehir_id;
  String sehir_ad;
  String sehir_plaka;
  List<Ilce> sehir_ilceler;

  Sehir(
      {
        required this.sehir_id,
        required this.sehir_ad,
        required this.sehir_plaka,
        required this.sehir_ilceler
      }
  );

}