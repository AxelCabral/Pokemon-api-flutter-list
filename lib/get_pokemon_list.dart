import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class GetPokemonList {
  Future<List> getPokemonList() async {
    String url = 'https://pokeapi.co/api/v2/pokemon?limit=1302';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      
      List<dynamic> pokemonList = data['results'];

      return pokemonList;
    } else {
      log('Request failed with status: ${response.statusCode}');
    }

    return [];
  }
}