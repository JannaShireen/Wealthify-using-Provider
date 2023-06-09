import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        
        // backgroundColor: const Color(0x00000000),
        leading: IconButton(
          onPressed: (() {
            Navigator.of(context).pop();
          }),
          icon: Icon(
            Icons.adaptive.arrow_back,
            // color: themeDarkBlue,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 69, 8, 57),
        centerTitle: true,
        title: const Text(
          'About',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Wealthify',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Developed by Janna Shireen ",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Version 1.0.2',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}