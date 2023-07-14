import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wheater_app/home/secret.dart';
import 'forcast/forecast.dart';
import 'additional_info/additionalinfo.dart';
import 'location_l/location.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  //weather api
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getWeather() async {
    LocationManager location = LocationManager();
    await location.fetchLocationData();
    double? lat = location.lat;
    double? long = location.long;

    try {
      final response1 = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$openweatherApikey"),
      );
      final response2 = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$openweatherApikey"),
      );

      final data1 = jsonDecode(response1.body);
      final data2 = jsonDecode(response2.body);
      // print("$lat $long");

      if ((int.parse(data1['cod']) != 200) & (data2['cod'] != 200)) {
        throw data2['message'];
      }
      return {
        'data1': data2,
        'data2': data1,
      };
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  weather = getWeather();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          final data = snapshot.data!;
          final data1 = data["data1"];
          final data2 = data["data2"];
          // print(data2);
          // print();

          final currentWeatherdata = data1['main'];
          final currentemp = data1['main']['temp'] - 273.15;
          final country = data1['sys']['country'];
          final area = data1['name'];
          final currentWeatherDes = data1['weather'][0]['main'];

          gettime(int time, int index) {
            int unixTimestamp = time;
            DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
            DateTime localDateTime = dateTime.toLocal();
            String formattedTime = DateFormat('hh:mm a').format(localDateTime);

            return formattedTime;
          }

          String convertToAMPM(String timee) {
            final time = DateTime.parse(timee);
            String formattedTime = DateFormat.j().format(time);
            return formattedTime;
          }

          String convertDateFormat(String date) {
            List<String> dateComponents = date.split('-');
            String year = dateComponents[0];
            String month = dateComponents[1];
            String day = dateComponents[2];

            String convertedDate = "$day/$month/$year";
            return convertedDate;
          }

          // final currentWeatherDes = "";

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "$area, $country",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${currentemp.toStringAsFixed(2)}° C",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(
                                currentWeatherDes == "Rain"
                                    ? CupertinoIcons.cloud_rain
                                    : currentWeatherDes == "Clouds"
                                        ? CupertinoIcons.cloud
                                        : currentWeatherDes == "Haze"
                                            ? CupertinoIcons.sun_haze
                                            : CupertinoIcons.sun_max,
                                size: 64,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "$currentWeatherDes",
                                style: const TextStyle(fontSize: 25),
                              ),
                              const Text(
                                "Now",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  "Hourly Forecast",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                //Weather forcast Card
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 1; i < 6; i++)
                //         ForcastCard(
                //           icon: data2['list'][i]['weather'][0]['main'] == "Rain"
                //               ? CupertinoIcons.cloud_rain
                //               : data2['list'][i]['weather'][0]['main'] ==
                //                       "Clouds"
                //                   ? CupertinoIcons.cloud
                //                   : data2['list'][i]['weather'][0]['main'] ==
                //                           "Haze"
                //                       ? CupertinoIcons.sun_haze
                //                       : CupertinoIcons.sun_max,
                //           temperature: double.parse(
                //               (data2['list'][i]['main']['temp'] - 273.15)
                //                   .toStringAsFixed(2)),
                //           time: convertToAMPM(
                //               (data2['list'][i]['dt_txt'].split(" ")).last),
                //           date: convertDateFormat(
                //               (data2['list'][i]['dt_txt'].split(" ")).first),
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 39,
                    itemBuilder: (context, index) {
                      return ForcastCard(
                        icon: data2['list'][index + 1]['weather'][0]['main'] ==
                                "Rain"
                            ? CupertinoIcons.cloud_rain
                            : data2['list'][index + 1]['weather'][0]['main'] ==
                                    "Clouds"
                                ? CupertinoIcons.cloud
                                : data2['list'][index + 1]['weather'][0]
                                            ['main'] ==
                                        "Haze"
                                    ? CupertinoIcons.sun_haze
                                    : CupertinoIcons.sun_max,
                        temperature: double.parse(
                            (data2['list'][index + 1]['main']['temp'] - 273.15)
                                .toStringAsFixed(2)),
                        time:
                            convertToAMPM((data2['list'][index + 1]['dt_txt'])),
                        date: convertDateFormat(
                            (data2['list'][index + 1]['dt_txt'].split(" "))
                                .first),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                // additional information
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfo(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        valuee: currentWeatherdata['humidity'].toString(),
                      ),
                      AdditionalInfo(
                        icon: Icons.air_outlined,
                        label: "Air Speed",
                        valuee: data1['wind']['speed'].toString(),
                      ),
                      AdditionalInfo(
                        icon: CupertinoIcons.rocket,
                        label: "Air Pressure",
                        valuee: currentWeatherdata['pressure'].toString(),
                      ),
                      AdditionalInfo(
                        icon: CupertinoIcons.sunrise,
                        label: "Sunrise",
                        valuee: gettime(
                            (data1['sys']['sunrise']), data1['timezone']),
                      ),
                      AdditionalInfo(
                        icon: CupertinoIcons.sunset,
                        label: "Sunset",
                        valuee: gettime(
                            (data1['sys']['sunset']), data1['timezone']),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
