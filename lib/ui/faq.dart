import 'package:flutter/material.dart';

class faq extends StatelessWidget {
  const faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5E6572),
      appBar: AppBar(
        title: Text("FAQ"),
        centerTitle: true,
        backgroundColor: Color(0xFF1C2321),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 120,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is Sensor Manage?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sensor Manage is an application designed to monitor and manage data from various connected sensors",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 150,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What should I do if a sensor is not functioning?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Ensure that the sensor is properly connected. Check the physical connection and make sure the sensor software is installed correctly.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 150,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How do I calculate BMI using the BMI calculator?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Navigate to the BMI Calculator menu. Choose your gender, input your height and weight, then press the calculate button. Your BMI and category will be displayed.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 180,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What are the BMI category criteria used in the app?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "The BMI categories used are as follows:\n- Less than 18.5: Underweight\n- 18.5 - 24.9: Normal\n- 25.0 - 29.9: Overweight\n- 30.0 or more: Obese",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
