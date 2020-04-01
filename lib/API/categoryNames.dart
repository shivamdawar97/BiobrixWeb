import 'package:myapp/config/config.dart';
import 'package:myapp/models/categoty.dart';
import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;

const path='/category/category_list';

Future<List<Category>> getCategories() async {
  
   final response = await http.get(base_url+ path,
    //Only accept json response
    headers: {"Accept":"application/json"},);

  if(response.statusCode == 200) {
      
      final parsed = json.decode(response.body).cast<Map<String,dynamic>>();
      try {
          return parsed.map<Category>((json)=> Category.fromJson(json)).toList();
      }catch(e,trace){
          print(e+trace);
          return null;
      }
    
  }
  else throw Exception('Failed to load products');
}