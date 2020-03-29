import 'package:myapp/API/home_products.dart';
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
      image: 'https://lh3.googleusercontent.com/F2OKBSNQTGWP0Cbu-9F4eC7Hh_7acf9YacCDh97653AMlbeFkUqNNx7zLpiP2_XDOBF4hOkKawyZ5C7qZqTPQnSGKIOXRCdD4-GjPnK52tZYA01YlT5GgzQwy3F8mErThtsOese3xL6QwwTb76H4vYvg9BUu23PUZryTBnxBbLx-l1A9nDRCB2Ttyakznj-tdNvYsodYRzj5aWu6cZ179Hf8UzuLAUvvzrbSabzAJJDlKIIjqJiRBKTtYM0J2zAJNTPR4eJG0YBSJQqPfYpmRcSuEPO4QudiikV_93--KxQeKZOaAb50OqFa2cf9myBMHBcIzEbcMsmjJZ8mouPi0mMJNrjYNl0etkACKzDvdKq-0_PYfI1fUz3p6r6IS1gdEe4eec2mL25AK6iaf3qyXY3Q0nUzqpdsTPgUN0SNoVPOisuGj1kxkVDQ1cD_MUWfZhaRnX8db_lgUB9cRonjW10lMwu_RsfGkM9Idgpi8kEfpytm31Rd95Pfjp2-Z95rE7pFUKlCSRBiI9LZNXqThr0u_O0ZzXiMBkYJCrrwlKkbrkMua7F45sc0t-sn4XmlAvI8HWpWLJ8CqyqP8IsOo2LQeQrOaF2ZrFsXvARi91B_G1jw3rHiXQqsajmk07uTfk4W7NlWHy6QAeK_q_PkQrjDCIralU2UAYQkgxsvHG0ITfMSMeP2ktmveoRTcmg=w392-h696-no',
      text: 'I am using biobrix products since two years. It has removed my skin infection properly and now I feel more comfortable when going shirtless. Thanks to biobrix'
    ));

    return testimonies;
  }

}