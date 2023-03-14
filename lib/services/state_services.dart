
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/WorldStatesModel.dart';
import '../utils/app_url.dart';

class StateServices{

  Future<WorldStatesModel> featchWorldStatesRecords() async{
    final respons = await http.get(Uri.parse(AppUrl.worldStateApi));

    if(respons.statusCode == 200){
      var data = jsonDecode(respons.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Some error occured");
    }
  }

  Future<List<dynamic>> featchCountryListApi() async{
    final respons = await http.get(Uri.parse(AppUrl.countryList));

    if(respons.statusCode == 200){
      var data = jsonDecode(respons.body);
      return data;
    }else{
      throw Exception("Some error occured");
    }
  }
}