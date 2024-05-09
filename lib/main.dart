import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poké App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Pokémon Informations'),
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
  List<String> pokemonNames = [];
  List<String> pokemonImages = [];
  List<String> pokemonTypes = [];

  String url = 'https://pokeapi.co/api/v2/pokemon?limit=300';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    requisition();
  }

  formatName(String name){
    return name[0].toUpperCase()+name.substring(1);
  }

  void requisition() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> pokemonList = data['results'];

      for (var pokemon in pokemonList) {
        String pokemonName = pokemon['name'].toString();

        pokemonNames.add(formatName(pokemonName));
        pokemonImages.add('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemonList.indexOf(pokemon)+1}.png');
        
        // Obtém informações detalhadas sobre o Pokémon para obter os tipos
        final pokemonDetailResponse = await http.get(Uri.parse(pokemon['url']));
        if (pokemonDetailResponse.statusCode == 200) {
          Map<String, dynamic> pokemonDetailData = jsonDecode(pokemonDetailResponse.body);
          List<dynamic> types = pokemonDetailData['types'];
          List<String> pokemonTypeNames = [];
          for (var type in types) {
            pokemonTypeNames.add(type['type']['name']);
          }
          pokemonTypes.add(pokemonTypeNames.toString());
        } else {
          log('Failed to load Pokémon detail: ${pokemonDetailResponse.statusCode}');
          pokemonTypes.add([" "] as String);
        }
      }
    } else {
      log('Request failed with status: ${response.statusCode}');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: pokemonNames.length,
      itemBuilder: (context, index) {
        Color? backgroundColor = defineColorByType(pokemonTypes[index]); // Cor de fundo do Card
        Color textColor = backgroundColor == Colors.black ? Colors.white : Colors.black; // Cor do texto

        return Card(
          color: backgroundColor,
          child: ListTile(
            title: Text(
              pokemonNames[index],
              style: TextStyle(color: textColor), // Define a cor do texto
            ),
            leading: Image.network(pokemonImages[index]),
            trailing: Text(
              pokemonTypes[index],
              style: TextStyle(color: textColor), // Define a cor do texto
            ),
          ),
        );
      },
    ),
  );
}

  Color? defineColorByType(String pokemonType) {
    if (pokemonType.contains('grass')) {
      return Colors.green[200];
    } else if (pokemonType.contains('fire')) {
      return Colors.red[200];
    } else if (pokemonType.contains('water')) {
      return Colors.blue[200];
    } else if (pokemonType.contains('poison')){
      return Colors.purple[200];
    } else if (pokemonType.contains('bug')){
      return Colors.brown[200];
    } else if (pokemonType.contains('normal')){
      return Colors.white;
    } else if (pokemonType.contains('electric')){
      return Colors.yellow[200];
    } else if (pokemonType.contains('fairy')){
      return Colors.pink[200];
    } else if (pokemonType.contains('ground')){
      return Colors.brown[200];
    } else if (pokemonType.contains('psychic')){
      return Colors.purple[200];
    } else if (pokemonType.contains('rock')){
      return Colors.brown[200];
    } else if (pokemonType.contains('steel')){
      return Colors.blueGrey[200];
    } else if (pokemonType.contains('ice')) {
      return Colors.blue[200];
    } else if (pokemonType.contains('fighting')) {
      return Colors.brown[400];
    } else if (pokemonType.contains('dark') || pokemonType.contains('ghost')) {
      return Colors.black;
    }else {
      return const Color.fromARGB(255, 78, 78, 78); // Cor padrão para tipos desconhecidos
    }
  }
}
