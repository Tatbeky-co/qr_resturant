import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_resturant/const.dart';
import 'package:qr_resturant/dio.dart';
import 'package:qr_resturant/main_model.dart';

import 'home_page.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await DioApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(Uri.base.queryParameters['id']);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: FutureBuilder(
        future: DioApi.getData(url: Const.getRestrantLink+Uri.base.queryParameters['id'].toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ) {
            return  Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.data == null ){
             return Scaffold(body: Center(child: Text("لم يتم العثور على المطعم"),));
          } else {
             if(snapshot.data!.statusCode == 200){ 
                MainModel data = MainModel.fromJson(snapshot.data!.data);
                return HomePage(data:data);
             }else{
             return Scaffold(body: Center(child: Text("Something went wrong"),));
             }
           
          }
        },
      ),
    );
  }
}

