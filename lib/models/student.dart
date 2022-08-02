import 'dart:ffi';

import 'package:flutter/material.dart';

class Student {
  int? id;
  String? name;
  num? nilai;
  num? waktu;

  Student({this.id, this.name, this.nilai, this.waktu});

  Student.fromJson(json) {
    id = json['id'];
    name = json['Nama'];
    nilai = json['Nilai'];
    waktu = json['Waktu'];
  }
}
