import 'package:flutter/material.dart';
import 'package:security_system/ui/login.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/resetpass.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 250,
                    left: 15,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3259),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 180,
                    left: 15,
                    child: SizedBox(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.mail_outlined,
                            color: Colors.grey,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 300,
                            child: const TextField(
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'example@gmail.com',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 15,
                    right: 15,
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Reset Password'),
                                  content: Text(
                                      'Please check your email for update password'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => const Login()));
                                      },
                                      child: Text("OK"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF0CC0DF)),
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF0CC0DF),
                                    Color(0xFFFFDE59),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Center(
                              child: Text('Submit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  )),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
