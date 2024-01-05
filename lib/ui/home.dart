import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security_system/ui/history.dart';
import 'package:security_system/ui/managesensor.dart';
import 'package:security_system/ui/profile.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
//import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MqttManager mqttManager;

  late String temperature = '0';
  late String humidity = '0';
  late String flame = '0';
  late String door = '0';

  List<Map<String, dynamic>> data = [];

  final items = const [
    Icon(Icons.home, size: 25),
    Icon(Icons.settings_applications, size: 25),
    Icon(Icons.history, size: 25),
    Icon(Icons.people, size: 25),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    mqttManager = MqttManager();

    mqttManager.connect().then((result) {
      if (result is int && result == -1) {
        // Handle connection failure if needed
      }
    });

    // Listen to changes in temperature value
    mqttManager.datatemperature.addListener(() {
      setState(() {
        temperature = mqttManager.datatemperature.value;
      });
    });

    mqttManager.humidityData.addListener(() {
      setState(() {
        humidity = mqttManager.humidityData.value;
      });
    });

    mqttManager.flameData.addListener(() {
      setState(() {
        flame = mqttManager.flameData.value;
      });
    });

    mqttManager.doorData.addListener(() {
      setState(() {
        door = mqttManager.doorData.value;
      });
    });
  }

  @override
  void dispose() {
    mqttManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    List<Widget> widgets = [
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                child: Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bellefair',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Today's Detection",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 160,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1C2321),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 82, 81, 81)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 5),
                                  decoration: BoxDecoration(
                                    color:
                                        (double.tryParse(temperature) ?? 0.0) >
                                                45
                                            ? Colors.red
                                            : Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        temperature + '°C',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Temp',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    color:
                                        (double.tryParse(humidity) ?? 0.0) > 50
                                            ? Colors.red
                                            : Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        humidity + ' %RH',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Humidity',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    color: (double.tryParse(flame) ?? 0.0) > 0.0
                                        ? Colors.red
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        double.tryParse(flame) == 1.0
                                            ? 'Yes'
                                            : 'No',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Flame',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 5, right: 10),
                                  decoration: BoxDecoration(
                                    color: (double.tryParse(door) ?? 0.0) > 0.0
                                        ? Colors.red
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        double.tryParse(door) == 1.0
                                            ? 'Open'
                                            : 'Close',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Door',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 260,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 5,
                                right: 5,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Status:',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        (double.tryParse(temperature) ?? 0.0) >
                                                    45 ||
                                                (double.tryParse(humidity) ??
                                                        0.0) >
                                                    50 ||
                                                double.tryParse(flame) == 1 &&
                                                    double.tryParse(door) == 1
                                            ? 'DANGER!'
                                            : 'SAFE',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: (double.tryParse(
                                                              temperature) ??
                                                          0.0) >
                                                      45 ||
                                                  (double.tryParse(humidity) ??
                                                          0.0) >
                                                      50 ||
                                                  double.tryParse(flame) == 1 &&
                                                      double.tryParse(door) == 1
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Your Sensor",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF1C2321),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 82, 81, 81)
                                        .withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF1C2321),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 82, 81, 81)
                                        .withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF1C2321),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 82, 81, 81)
                                        .withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF1C2321),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 82, 81, 81)
                                        .withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "7-Day Sensor Detection Overview",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 237, 250, 246),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 82, 81, 81)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: Column(
                              // children: [
                              //   Expanded(
                              //     child: MyChartWidget(),
                              //   ),
                              // ],
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ManageSensor(),
      History(),
      Profile(),
    ];

    return Scaffold(
      backgroundColor: Color(0xFF5E6572),
      body: widgets[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF1C2321),
        items: items,
        index: index,
        onTap: (selectedIndex) {
          print(selectedIndex);
          setState(() {
            index = selectedIndex;
            print(index);
          });
        },
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class MqttManager with ChangeNotifier {
  final ValueNotifier<String> datatemperature = ValueNotifier<String>("");
  final ValueNotifier<String> humidityData = ValueNotifier<String>("");
  final ValueNotifier<String> flameData = ValueNotifier<String>("");
  final ValueNotifier<String> doorData = ValueNotifier<String>("");
  late MqttServerClient client;
  //late ChartData chartData;

  Future<Object> connect() async {
    //chartData = ChartData();
    client = MqttServerClient.withPort(
        'broker.hivemq.com', '62863b68-5e47-46ff-92da-97c291e49c3d', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.logging(on: true);

    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();

    final connMessage = MqttConnectMessage()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    print('MQTT_LOGS::Mosquitto client connecting....');

    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT_LOGS::Mosquitto client connected');
    } else {
      print(
          'MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      return -1;
    }

    print('MQTT_LOGS::Subscribing to the test/lol topic');
    const topicTemperature = 'asharilabs/suhu';
    const topicHumidity = 'IOT-SECURITY DD KELEMBAPAN';
    const topicFlame = 'IOT-SECURITY DD SENSOR API';
    const topicDoor = 'IOT-SECURITY DD SENSOR PINTU';

    client.subscribe(topicTemperature, MqttQos.atMostOnce);
    client.subscribe(topicHumidity, MqttQos.atMostOnce);
    client.subscribe(topicFlame, MqttQos.atMostOnce);
    client.subscribe(topicDoor, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      String topic = c[0].topic;
      print('Received data - Topic: $topic, Payload: $pt');
      if (topic == topicTemperature) {
        datatemperature.value = pt;
        //chartData.updateChartData('temperature:$pt');
      } else if (topic == topicHumidity) {
        humidityData.value = pt;
        //chartData.updateChartData('humidity:$pt');
      } else if (topic == topicFlame) {
        flameData.value = pt;
        //chartData.updateChartData('flame:$pt');
      } else if (topic == topicDoor) {
        doorData.value = pt;
        //chartData.updateChartData('door:$pt');
      }
      final f1score = extractF1Score(pt);
      //chartData.updateChartData('f1score:$f1score');
      notifyListeners();
      print(
          'MQTT_LOGS:: New data arrived: topic is <${c[0].topic}>, payload is $pt');
      print('');
    });

    return client;
  }

  double extractF1Score(String payload) {
    try {
      final dataMap = Map.fromIterable(
        payload.split(','),
        key: (item) => item.split(':')[0],
        value: (item) => double.tryParse(item.split(':')[1]) ?? 0.0,
      );

      return dataMap['f1score'] ?? 0.0;
    } catch (e) {
      print('Error extracting F1 score: $e');
      return 0.0;
    }
  }

  void onConnected() {
    print('MQTT_LOGS:: Connected');
  }

  void onDisconnected() {
    print('MQTT_LOGS:: Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTT_LOGS:: Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('MQTT_LOGS:: Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('MQTT_LOGS:: Unsubscribed topic: $topic');
  }

  void pong() {
    print('MQTT_LOGS:: Ping response client callback invoked');
  }

  void publishMessage(String message) {
    const topicSuhu = 'asharilabs/suhu/connection';
    const topicHumidity = 'IOT-SECURITY DD KELEMBAPAN/connection';
    const topicFlame = 'IOT-SECURITY DD SENSOR API/connection';
    const topicPintu = 'IOT-SECURITY DD SENSOR PINTU/connection';
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.publishMessage(topicSuhu, MqttQos.atMostOnce, builder.payload!);
    } else if (client.connectionStatus?.state ==
        MqttConnectionState.connected) {
      client.publishMessage(
          topicHumidity, MqttQos.atMostOnce, builder.payload!);
    } else if (client.connectionStatus?.state ==
        MqttConnectionState.connected) {
      client.publishMessage(topicFlame, MqttQos.atMostOnce, builder.payload!);
    } else {
      client.publishMessage(topicPintu, MqttQos.atMostOnce, builder.payload!);
    }
  }

  @override
  void dispose() {
    datatemperature.dispose();
    humidityData.dispose();
    flameData.dispose();
    doorData.dispose();
    super.dispose();
  }
}

// class ChartData extends ChangeNotifier {
//   List<double> temperature = [];
//   List<double> humidity = [];
//   List<double> flame = [];
//   List<double> door = [];

//   void updateChartData(String data) {
//     try {
//       final dataMap = Map.fromIterable(
//         data.split(','),
//         key: (item) => item.split(':')[0],
//         value: (item) => double.tryParse(item.split(':')[1]) ?? 0.0,
//       );

//       temperature.add(dataMap['temperature'] ?? 0.0);
//       humidity.add(dataMap['humidity'] ?? 0.0);
//       flame.add(dataMap['flame'] ?? 0.0);
//       door.add(dataMap['door'] ?? 0.0);

//       print('Temperature: $temperature');
//       print('Humidity: $humidity');
//       print('Flame: $flame');
//       print('Door: $door');

//       notifyListeners();
//     } catch (e) {
//       print('Error updating chart data: $e');
//     }
//   }
// }

// class MyChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     try {
//       //final chartData = Provider.of<ChartData>(context);

//       return LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(
//             rightTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: leftTitleWidgets,
//               ),
//             ),
//           ),
//           borderData: FlBorderData(
//             show: true,
//             border: Border.all(
//               color: const Color(0xff37434d),
//               width: 1,
//             ),
//           ),
//           minX: 0,
//           maxX: chartData.temperature.length.toDouble() - 1,
//           minY: 0,
//           maxY: 100, // Adjust the maximum value based on your data range
//           lineBarsData: [
//             _buildLineChartBar(
//                 chartData.temperature, Colors.red, "Temperature"),
//             _buildLineChartBar(chartData.humidity, Colors.blue, "Humidity"),
//             _buildLineChartBar(chartData.flame, Colors.orange, "Flame"),
//             _buildLineChartBar(chartData.door, Colors.green, "Door"),
//           ],
//         ),
//       );
//     } catch (e) {
//       print('Error building chart widget: $e');
//       // You might want to return a placeholder or an error message widget here
//       return Container();
//     }
//   }

//   LineChartBarData _buildLineChartBar(
//       List<double> data, Color color, String title) {
//     try {
//       return LineChartBarData(
//         spots: List.generate(
//           data.length,
//           (index) => FlSpot(index.toDouble(), data[index]),
//         ),
//         isCurved: true,
//         color: color,
//         dotData: FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         aboveBarData: BarAreaData(show: false),
//         barWidth: 2,
//       );
//     } catch (e) {
//       print('Error building LineChartBar: $e');
//       // You might want to return a placeholder or an error message widget here
//       return LineChartBarData();
//     }
//   }
// }
