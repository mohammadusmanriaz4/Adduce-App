import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String _quote = '';
  List<String> _favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    _getQuote();
    _getFavoriteQuotes();
    _deleteItem;
  }


  @override
  Widget build(BuildContext context) {
  return SafeArea(
  child: Scaffold(

  backgroundColor: Color.fromARGB(255, 255, 247, 173),
  
  body: Padding(
    padding: const EdgeInsets.symmetric(
    horizontal: 20,
    ),
    child: Column(
    children: [
    
    const SizedBox(
    height: 10,
    ),
    
    //Quotes Widget
    Container(
    width: 250,
    decoration: BoxDecoration(
    color: Colors.teal,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
    children: [
    
    Padding(
    padding: const EdgeInsets.only(
    top: 20,
    bottom: 20,
    left: 30,
    right: 30,
    ),
    child: Center(
    child: Text(
    _quote ,
    textAlign: TextAlign.center,
    style: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color:Colors.white, 
    ),
    ),
    ),
    ),

   
     Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

      IconButton(
      onPressed: () 
      {
       _getQuote();
      }, 
      icon: const Icon(
      Icons.refresh,
      color: Colors.white,
      ),
      ),
      
      IconButton(
      onPressed: () 
      {
       _addFavoriteQuote();
      }, 
      icon: const Icon(
      Icons.favorite,
      color: Colors.white,
      ),
      ),
      
      ],
      ),
    

    
    ],
    ),
    ),


       
    const SizedBox(
    height: 30,
    ),

  
              
    //Favourite quote list heading.          
    const Text(
    'Favorite Quotes:',
    style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold
    ),
    ),

    //Favoorite Quotes List         
    Expanded(
    child: ListView.builder(
    itemCount: _favoriteQuotes.length,
    itemBuilder: (context, index) {
    return Padding(
    padding: const EdgeInsets.only(
    top: 15,
    ),
    child: ListTile(
    title: Text(
    _favoriteQuotes[index],
    style: const TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    ),
    ),
    trailing: IconButton(
    onPressed: () 
    {
      _deleteItem(index);
    }, 
    icon: const Icon(
    size: 23,
    Icons.delete,
    color: Colors.white,
    ),
    ),
    tileColor: Colors.teal,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(60),
    ),
    contentPadding: const EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 2,
    ),
    ),
    );
    },
    ),
    ),
    ],
    ),
  ),
  ),
  );
  }


  //Function to fetch code from Api
  Future<void> _getQuote() async {
    String url = 'https://api.adviceslip.com/advice';
    var res = await http.get(Uri.parse(url));
    var result = jsonDecode(res.body);
    print(result["slip"]["advice"]);
    setState(() {
      _quote = result["slip"]["advice"];
    });
  }

  //Function to delete Quote from Fav Quote List
  Future<void> _deleteItem(int index) async 
  { 
    setState(() 
    {
      _favoriteQuotes.removeAt(index);
    });
  }
  
  //Function to fetch quote marked as favourite.
  Future<void> _getFavoriteQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteQuotes = prefs.getStringList('favoriteQuotes') ?? [];
    });
  }
  
  ////Function to add favourite quote to favourite quote list.
  Future<void> _addFavoriteQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteQuotes.add(_quote);
      prefs.setStringList('favoriteQuotes', _favoriteQuotes);
    });
  }
  
}