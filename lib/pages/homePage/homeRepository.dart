import 'package:myapp/API/home_products.dart';
import 'package:myapp/API/categoryNames.dart' as categoryApi;
import 'package:myapp/models/categoty.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/models/testimony.dart';

class HomeRepository {
  
  Future<List<HomeProduct>> callApi()  {
    try {
      return getRawData();
    }catch(e,trace){
      print(e);
      print(trace);
      return null;
    }
  }

  List<Testimony> getTestimonies(){
    final List<Testimony> testimonies = [];
    testimonies.add(Testimony(
      name: 'Shivam Dawar',
      image: 'https://biobrix-files.s3.ap-south-1.amazonaws.com/images/IMG_20181016_101020.jpg',
      text: 'I am using biobrix products since two years. It has removed my skin infection properly and now I feel more comfortable when going shirtless. Thanks to biobrix'
    ));

    return testimonies;
  }

  Future<List<Category>> getCategories() {
    return categoryApi.getCategories();
  }
  

}