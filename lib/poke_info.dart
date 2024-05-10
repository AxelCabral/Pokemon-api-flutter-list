import 'dart:convert';
import 'dart:developer';

import 'package:api_app/type_color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokemonInformationPage extends StatefulWidget {
  const PokemonInformationPage({super.key, required this.quantity, required this.pokemonList});

  final int quantity;
  final Future<List<dynamic>> pokemonList;

  @override
  State<PokemonInformationPage> createState() => _PokemonInformationPageState();
}

class _PokemonInformationPageState extends State<PokemonInformationPage> {
  List<String> pokemonNames = [];
  List<String> pokemonImages = [];
  List<String> pokemonTypes = [];

  late int teamSize;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    teamSize = widget.quantity;

    requisition();
  }

  formatName(String name){
    return name[0].toUpperCase()+name.substring(1);
  }

  void requisition() async {

    List<dynamic> pokemonList = await widget.pokemonList;

    // Embaralhando a lista de Pokémon para obter uma seleção aleatória
    pokemonList.shuffle();

    // Selecionando os primeiros 'teamSize' Pokémon da lista aleatorizada
    List<dynamic> selectedPokemonList = pokemonList.sublist(0, teamSize);

    for (var pokemon in selectedPokemonList) {
      String pokemonName = pokemon['name'].toString();

      pokemonNames.add(formatName(pokemonName));
      
      // Fazendo uma nova requisição para obter informações detalhadas do Pokémon
      final pokemonDetailResponse = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));
      if (pokemonDetailResponse.statusCode == 200) {
      Map<String, dynamic> pokemonDetailData = jsonDecode(pokemonDetailResponse.body);
        

        // Verificando se a propriedade sprites['front_default'] não é nula antes de acessá-la
      if (pokemonDetailData['sprites'] != null && pokemonDetailData['sprites']['front_default'] != null) {
        String spriteUrl = pokemonDetailData['sprites']['front_default'];
        pokemonImages.add(spriteUrl);
      } else {
        // Adicione uma imagem padrão ou deixe em branco se a sprite não puder ser carregada
        pokemonImages.add('https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Pok%C3%A9_Ball_icon.svg/1200px-Pok%C3%A9_Ball_icon.svg.png');
      }
      
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
  

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorDefine = BackgroundPokemonTypeDefinition();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Informations'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: pokemonNames.length,
        itemBuilder: (context, index) {
          Color? backgroundColor = colorDefine.defineColorByType(pokemonTypes[index]); // Cor de fundo do Card
          Color textColor = (backgroundColor == Colors.black || backgroundColor == Colors.blueGrey || backgroundColor == Colors.brown[400]) ? Colors.white : Colors.black; // Cor do texto

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
}