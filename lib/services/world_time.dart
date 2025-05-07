import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location;
  String time=''; //time in location
  String flag;//url to an asset flag icon
  String url;//location url for api

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async{
    try{
      //make request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      time = now.toString();
    }catch(e){
      print('Greska: $e');
      time='could not get time data';
    }
  }
}
