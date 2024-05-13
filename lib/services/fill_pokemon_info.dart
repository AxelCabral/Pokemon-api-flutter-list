import 'dart:convert';
import 'dart:developer';

import 'package:api_app/models/pokemon.dart';
import 'package:http/http.dart' as http;

class FillPokemonInformations {
  void fillPokemonInformations() async {
    String url = 'https://pokeapi.co/api/v2/pokemon?limit=1302';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      
      List<dynamic> pokemonList = data['results'];

      for (var pokemon in pokemonList) {
        String pokemonName = pokemon['name'].toString();
        String pokemonSpriteUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Pok%C3%A9_Ball_icon.svg/1200px-Pok%C3%A9_Ball_icon.svg.png')";
        String pokemonType = "Unknown";
      
        // Fazendo uma nova requisição para obter informações detalhadas do Pokémon
        final pokemonDetailResponse = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));

        if (pokemonDetailResponse.statusCode == 200) {
          Map<String, dynamic> pokemonDetailData = jsonDecode(pokemonDetailResponse.body);        

            // Verificando se a propriedade sprites['front_default'] não é nula antes de acessá-la
          if (pokemonDetailData['sprites'] != null && pokemonDetailData['sprites']['front_default'] != null) {
            pokemonSpriteUrl = pokemonDetailData['sprites']['front_default'];
          }
          
          //Variáveis para receber dados da API
          List<dynamic> types = pokemonDetailData['types'];
          List<String> pokemonTypeNames = [];

          //Adicionando valores em uma lista
          for (var type in types) {
            pokemonTypeNames.add(type['type']['name']);
          }

          //Transformando a lista em um valor único
          pokemonType = pokemonTypeNames.join(', ');

          Pokemon(pokemonName, pokemonSpriteUrl, pokemonType);
        } else {
          log('Failed to load Pokémon detail: ${pokemonDetailResponse.statusCode}');
        }
      }
      } else {
        log('Request failed with status: ${response.statusCode}');
      }
    }
}