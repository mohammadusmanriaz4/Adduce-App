import 'dart:async';
import 'package:daily_quotes_app/Screens/Quotes_Screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {  
  super.initState();
    
  Timer(
  const Duration(seconds: 3), 
  () 
  {
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => QuoteScreen(),
  ),
  ); 
  }
  );
  }
  
  
  @override
  Widget build(BuildContext context) 
  {
  return const SafeArea(
  child: Scaffold(
  body: Image(
  height: double.infinity,
  fit: BoxFit.fitHeight,
  image: AssetImage(
  'lib/assets/P1.png',
  ),
  ),
  ),
  );
  }
}