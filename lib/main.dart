import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interviewapp/models/student.dart';
import 'package:interviewapp/provider/student_provider.dart';
import 'package:interviewapp/theme.dart';
import 'package:interviewapp/widgets/student_card.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Interview App')),
        ),
        body: SafeArea(
            bottom: false,
            child: ListView(
              children: [
                SizedBox(
                  height: edge,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2,
                  ),
                  child: FutureBuilder(
                    future: studentProvider.getStudent(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Student> datas = snapshot.data as List<Student>;
                        getRank(datas);
                        //
                        Student max = getMax(datas);
                        Student min = getMin(datas);
                        double ratarataNilai = getAvgNilai(datas);
                        double ratarataWaktu = getAvgWaktu(datas);
                        double nilaiMax = getMax(datas).nilai!.toDouble();
                        double nilaiMin = getMin(datas).nilai!.toDouble();

                        return Column(
                          children: [
                            Column(
                              children: datas.map((e) {
                                if (e.nilai == nilaiMax) {
                                  return Container(
                                    color: orangeColor,
                                    child: StudentCard(e),
                                  );
                                } else if (e.nilai == nilaiMin) {
                                  return Container(
                                    color: greyColor,
                                    child: StudentCard(e),
                                  );
                                }
                                return Container(
                                  child: StudentCard(e),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: edge,),
                            Container(
                              child: Column(
                                children: [
                            Text('Nilai terendah : ${min.nilai} oleh : ${min.name}',style: blackTextStyle,),
                            Text('Nilai tertinggi : ${max.nilai} oleh : ${max.name}',style: blackTextStyle,),
                            Text('Nilai rata-rata : ${ratarataNilai} ',style: blackTextStyle,),
                            Text('Waktu rata-rata : ${ratarataWaktu} ',style: blackTextStyle,),                                  
                                ],
                              ),
                            )
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: edge*2+2,
                ),
              ],
            )));
  }
}

//membaca dari local data
Future<List<Student>> ReadJsonData() async {
  final data = await rootBundle.loadString('jsonfile/app.json');
  final list = jsonDecode(data) as List<dynamic>;
  return list.map((e) => Student.fromJson(e)).toList();
}

//function Rank
List<Student> getRank(List<Student> data) {
  Student tempStudent;
  for (int i = 0; i < data.length; i++) {
    for (int j = i + 1; j < data.length; j++) {
      if (data[i].nilai!.toDouble() >= data[j].nilai!.toDouble()) {
        //swap elements if not in order
        if (data[i].waktu!.toDouble() > data[j].waktu!.toDouble()){
          tempStudent = data[i];
          data[i] = data[j];
          data[j] = tempStudent;
        }else{
          tempStudent = data[j];
          data[j] = data[i];
          data[i] = tempStudent;          
        }

      }
    }
  }
  return data;
}


//function student dengan nilai max
Student getMax(List<Student> data) {
  double min = data[0].nilai!.toDouble();
  Student maxStudent = data[0];
  for (int i = 0; i < data.length; i++) {
    if (data[i].nilai!.toDouble() > min) {
      min = data[i].nilai!.toDouble();
      maxStudent = data[i];
    }
  }
  return maxStudent;
}

//function student dengan nilai min
Student getMin(List<Student> data) {
  double min = data[0].nilai!.toDouble();
  Student minStudent = data[0];
  for (int i = 0; i < data.length; i++) {
    if (data[i].nilai!.toDouble() < min) {
      min = data[i].nilai!.toDouble();
      minStudent = data[i];
    }
  }
  return minStudent;
}

//function mendapatkan rata-rata nilai
double getAvgNilai(List<Student> data) {
  double res = 0;
  for (int i = 0; i < data.length; i++) {
    res += data[i].nilai!.toDouble();
  }
  return res / data.length;
}

//function mendapatkan rata-rata waktu
double getAvgWaktu(List<Student> data) {
  double res = 0;
  for (int i = 0; i < data.length; i++) {
    res += data[i].waktu!.toDouble();
  }
  return res / data.length;
}


//read data dari local
// Future<List<Student>> ReadJsonData() async {
//   final data = await rootBundle.loadString('jsonfile/app.json');
//   final list = jsonDecode(data) as List<dynamic>;
//   return list.map((e) => Student.fromJson(e)).toList();
// }




