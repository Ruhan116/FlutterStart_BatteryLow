import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> backgroundColors = [
    const Color(0xFF001F4D),
    const Color(0xFF001F4D),
    Colors.white,
    Colors.white,
    const Color(0xFF001F4D),
    const Color(0xFF001F4D),
  ];

  final List<TextStyle Function({Color? color, double? fontSize, FontWeight? fontWeight})> fonts = [
    GoogleFonts.roboto,
    GoogleFonts.lato,
    GoogleFonts.oswald,
    GoogleFonts.poppins,
    GoogleFonts.montserrat,
  ];


  final _random = Random();
  TextStyle currentFont = GoogleFonts.roboto(fontSize: 20);


  void _incrementCounter() {
    setState(() {
      // Generate 3 random colors
      List<Color> threeColors = List.generate(
        3,
        (_) => Color.fromARGB(
          255,
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextInt(256),
        ),
      );

      // Repeat each color twice to get 6 elements
      backgroundColors = [
        threeColors[0],
        threeColors[0],
        threeColors[1],
        threeColors[1],
        threeColors[2],
        threeColors[2],
      ];

      final fontFunction = fonts[_random.nextInt(fonts.length)];
      // Inverse color of threeColors[1]
      Color inverseColor = Color.fromARGB(
        255,
        255 - threeColors[1].red,
        255 - threeColors[1].green,
        255 - threeColors[1].blue,
      );
      currentFont = fontFunction(fontSize: 20, color: inverseColor, fontWeight: FontWeight.bold);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: backgroundColors,
                        stops: [0.0, 0.35, 0.35, 0.96, 0.96, 1.0],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // spacing: 16, // Remove spacing property, not valid for Column
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image(image: AssetImage('assets/images/IUT.png'), fit: BoxFit.contain),
                        ),
                        const Text(
                          'Islamic University of Technology',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Add spacing between sections
                        DefaultTextStyle(
                          style: currentFont,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // left-aligns all children
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: Image(image: AssetImage('assets/images/id_image.jpg'), fit: BoxFit.cover),
                                ),
                                SizedBox(height: 10), // space between image and text
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.vpn_key,
                                      size: 16
                                    ),
                                    const SizedBox(width: 6), // small space
                                    const Text('Student ID'),
                                  ],
                                ),
                                Card(
                                  color: Colors.blue[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: const Text("210041116"),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16
                                    ),
                                    const SizedBox(width: 6), // small space
                                    const Text('Student Name'),
                                  ],
                                ),
                                Text("      Shigaraki Tomura"),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.school,
                                      size: 16
                                    ),
                                    const SizedBox(width: 6), // small space
                                    const Text('Program: Bsc in CSE'),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.computer,
                                      size: 16
                                    ),
                                    const SizedBox(width: 6), // small space
                                    const Text('Department CSE'),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.gps_fixed,
                                      size: 16
                                    ),
                                    const SizedBox(width: 6), // small space
                                    const Text('Bangladesh'),
                                  ],
                                ),
                                SizedBox(height: 10), // Add spacing between sections
                              ]
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
