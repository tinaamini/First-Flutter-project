import 'dart:ui';
import "package:dio/dio.dart";
import "package:untitled1/model/CurrentCityDataModel.dart";

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    sendRequestCurrentWeather();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App', style: TextStyle(color: Colors.blue)),
        elevation: 15,
        actions: <Widget>[
          PopupMenuButton<String>(itemBuilder: (BuildContext context) {
            return {'sitting', 'log out'}.map((String choice) {
              return PopupMenuItem(
                child: Text(choice),
                value: choice,
              );
            }).toList();
          })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pic_bg.jpg'), fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 17),
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('find')),
                      ),
                      Expanded(
                          child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                            hintText: 'Enter city name',
                            border: UnderlineInputBorder()),
                      ))
                    ])),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Text('Mountain View',
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('clear sky',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Icon(
                    Icons.wb_sunny_outlined,
                    color: Colors.white,
                    size: 85,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    '14' + '\u00B0',
                    style: TextStyle(color: Colors.white, fontSize: 95),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            'Max',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            '16' + '\u00B0',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 45,
                      color: Colors.white,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            'Min',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            '12' + '\u00B0',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.white,
                  ),
                ),
                // ----------------------list--------
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: double.infinity,
                    height: 110,
                    child: Center(
                      child: ListView.builder(
                          itemCount: 15,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int pos) {
                            return Container(
                              height: 70,
                              width: 70,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Text(
                                        'sat,3 am',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.cloud,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        '14' + '\u00B0',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.white,
                  ),
                ),
                // -------------------detail weather----------
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text('min speed',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 17)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text('17 ms/h',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          )
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Text('sunrise',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Text('6:32 PM',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          )
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Text('sunset',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Text('9:03 AM',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          )
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Text('humidety',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Text('76 %',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendRequestCurrentWeather() async {
    var apiKey = '?';
    var cityname = 'mashhad';

    var response = await Dio().get(
        "https://api.openweathermap.org/data/2.5/weather",
        queryParameters: {'q': cityname, 'appid': apiKey, 'units': 'metrics'});
    print(response.data);
    print(response.statusCode);

    var datamodel = CorrentCityDataModel(
      response.data['name'],
      response.data["cord"]['lon'],
      response.data['cord']['let'],
      response.data['weather'][0]['main'],
      response.data['weather'][0]['description'],
      response.data['main']['temp'],
      response.data['main']['temp_min'],
      response.data['main']['temp_max'],
      response.data['main']['pressure'],
      response.data['main']['humidity'],
      response.data['wind']['speed'],
      response.data['dt'],
      response.data['sys']['country'],
      response.data['sys']['sunrise'],
      response.data['sys']['sunset'],
    );
  }
}
