import 'dart:convert';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;
import '../Models/WorldStatesModel.dart';

class StatesServices{

  Future<WorldStatesModel> getWorldstatesdata() async{
      var response = await http.get(Uri.parse(AppUrl.worldStateurl));

      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        return WorldStatesModel.fromJson(data);
      }
      else{
        throw Exception('Error');
      }
  }


  Future<List<dynamic>> getCountriesList() async{
    var response = await http.get(Uri.parse(AppUrl.countryurl));

    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());
      return data;
    }
    else{
      throw Exception('Error');
    }
  }

}