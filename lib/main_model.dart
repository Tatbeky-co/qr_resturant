import 'package:flutter/material.dart';

class MainModel {
  String? name;
  String? phone;
  String? profileimg;
  Color? mainColor;
  List<SubModel> subcategory = [];
  List<String> maincategory = [];
  MainModel({required this.name,required this.subcategory ,required this.maincategory});
  MainModel.fromJson(json) {
    name = json['name'];
    phone = json['phone'];
    profileimg = json['profileimg'];
    mainColor = Color(int.parse(json['mainColor']!.replaceAll("#", "0xff")));
    if(json['maincategory']!=null){
     json['maincategory'].forEach((e){
        maincategory.add(e.toString());
     });
    }
     if(json['subcategory']!=null){
     json['subcategory'].forEach((e){
        subcategory.add(SubModel.fromJson(e));
     });
    }
  }
  toJson() {
    return {
      "name": name,
      "phone": phone,
      "profileimg": profileimg,
      "mainColor": mainColor,
      "maincategory": maincategory,
      "subcategory": subcategory.map((e) => e.toJson()).toList()
    };
  }
}

class SubModel {
  String? name, des, price, img,category;
  SubModel({required this.name,required this.des,required this.price,required this.img,required this.category});
  SubModel.fromJson(json) {
    name = json['name'];
    des = json['des'];
    price = json['price'];
    img = json['img'];
    category = json['category'];
  }
  toJson() {
    return {
      "name": name,
      "des": des,
      "price": price,
      "img": img,
      "category": category,
    };
  }
}

// MainModel sampleMainModel = MainModel(name: "Master Chef",maincategory: ["Breakfast","Lunch","c","d"], subcategory: [
//   SubModel(name: "a", des: "aaaaa", price: "11", img: "img",category: "Breakfast"),
//   SubModel(name: "a2", des: "aaaaa", price: "11", img: "img",category: "Breakfast"),
//   SubModel(name: "a3", des: "aaaaa", price: "11", img: "img",category: "Breakfast"),
//   SubModel(name: "b3", des: "bbbbb", price: "11", img: "img",category: "Lunch"),
//   SubModel(name: "c3", des: "aaaaa", price: "11", img: "img",category: "c"),
//   SubModel(name: "c3", des: "aaaaa", price: "11", img: "img",category: "c"),
//   SubModel(name: "d", des: "d", price: "11", img: "img",category: "d"),
//   SubModel(name: "d", des: "d", price: "11", img: "img",category: "d"),
//   SubModel(name: "d", des: "d", price: "11", img: "img",category: "d"),
//   SubModel(name: "d", des: "d", price: "11", img: "img",category: "d"),
//   SubModel(name: "d", des: "d", price: "11", img: "img",category: "d"),
//   SubModel(name: "d", des: "d", price: "11", img: "img",category: "d"),
//   SubModel(name: "d", des: "d", price: "11", img: "img",category: "d"),
//   SubModel(name: "d", des: "d", price: "11", img: "img",category: "d"),
// ]);
