import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:myapp/config/config.dart';
import 'package:myapp/models/product.dart';

const path='/product/home_products';

Future<List<HomeProduct>> getRawData() async {
  
   final response = await http.get(base_url+ path,
    //Only accept json response
    headers: {"Accept":"application/json"},);

  if(response.statusCode == 200) {
      
      print('success');
      final parsed = json.decode(response.body).cast<Map<String,dynamic>>();
      
      try {
          final list = parsed.map<HomeProduct>((json)=> HomeProduct.fromJson(json)).toList();
          return list;  
      }catch(e,trace){
          print(e);
          print(trace);
          return null;
      }
    
  }
  else throw Exception('Failed to load products');
}