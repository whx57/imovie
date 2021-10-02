import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


void getHttp() async {
  try {
    var response = await Dio().get('http://www.google.com');
    print(response);
  } catch (e) {
    print(e);
  }
}

void main(){

  getHttp();
}