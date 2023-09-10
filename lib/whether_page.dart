 import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whether__app/whether_forcarst_items.dart';
 import 'package:intl/intl.dart';
import 'additional_info_items.dart';
import 'package:http/http.dart' as http;

import 'open_weather_api_key.dart';
class WhetherPage extends StatefulWidget {

  const WhetherPage({super.key});

  @override
  State<WhetherPage> createState() => _WhetherPageState();
}

class _WhetherPageState extends State<WhetherPage> {
  Future<Map<String,dynamic>> getWeatherApiData() async {
    try{
      String countryName = 'America';
      String wheatherorforecast = 'forecast';
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/$wheatherorforecast?q=$countryName&APPID=$openWeatherApiKey'
      ));
      final data = jsonDecode(res.body);
      if(data['cod']!='200'){
        throw 'An occurred a Server side error';
      }
      return data;
    }catch(e){
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App 🥂",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            setState(() {

            });
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getWeatherApiData(),
        builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(
              backgroundColor: Colors.white,color: Colors.black,
            ),);
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          final allData= snapshot.data!;
          final currentData = allData['list'][0]['main']['temp'];
          final currentSky = allData['list'][0]['weather'][0]['main'];
          final currentPressur = allData['list'][0]['main']['pressure'];
          final windSpeed = allData['list'][0]['wind']['speed'];
          final humidity = allData['list'][0]['main']['humidity'];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child:  Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                             '$currentData k',
                              style: TextStyle(
                                  fontSize: 34, fontWeight: FontWeight.bold),
                            ),
                            currentSky == 'Clouds' || currentSky == 'Rin' ?Icon(
                              Icons.cloud,
                              size: 69,
                            ):Icon(
                              Icons.sunny,
                              size: 69,
                            ),
                            Text(
                              currentSky,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                'Whether Forecast',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 113,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                    itemBuilder:(context,index){
                      final currentSky = allData['list'][index+1]['weather'][0]['main'];
                      final time = DateTime.parse(allData['list'][index+1]['dt_txt']);
                      return hourlyForcastItems(
                        time: DateFormat.jm().format(time).toString(),
                        icon: currentSky == 'Clouds' || currentSky == 'Rain' ?Icons.cloud:Icons.sunny,
                        temp: currentSky,);
                    } ),
              ),



              //Additional forcast
              SizedBox(
                height: 10,
              ),
              //whether forcast
              Text(
                'Additional Information',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItems(icon: Icons.water_drop_sharp,name:'humidity',value: humidity.toString(),),
                  AdditionalInfoItems(icon: Icons.air,name:'Wild Speed',value: windSpeed.toString(),),
                  AdditionalInfoItems(icon: Icons.beach_access,name:'Pressure',value: currentPressur.toString(),),
                ],
              )
            ]),
          );
        },
      )

    );
  }
}


