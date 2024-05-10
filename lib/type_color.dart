import 'package:flutter/material.dart';

class BackgroundPokemonTypeDefinition{
  Color? defineColorByType(String pokemonType) {
    if (pokemonType.contains('grass')) {
      return Colors.green[300];
    } else if (pokemonType.contains('fire')) {
      return Colors.red[300];
    } else if (pokemonType.contains('water')) {
      return Colors.blue[300];
    } else if (pokemonType.contains('poison')){
      return Colors.purple[300];
    } else if (pokemonType.contains('bug')){
      return Colors.brown[300];
    } else if (pokemonType.contains('normal')){
      return Colors.white;
    } else if (pokemonType.contains('electric')){
      return Colors.yellow[300];
    } else if (pokemonType.contains('fairy')){
      return Colors.pink[300];
    } else if (pokemonType.contains('dragon')){
      return Colors.orange[300];
    }else if (pokemonType.contains('ground')){
      return Colors.brown[500];
    } else if (pokemonType.contains('psychic')){
      return Colors.purple[300];
    } else if (pokemonType.contains('rock')){
      return Colors.brown[300];
    } else if (pokemonType.contains('steel')){
      return Colors.blueGrey[300];
    } else if (pokemonType.contains('ice')) {
      return Colors.blue[300];
    } else if (pokemonType.contains('fighting')) {
      return Colors.brown[400];
    } else if (pokemonType.contains('dark') || pokemonType.contains('ghost')) {
      return Colors.black;
    }else {
      return const Color.fromARGB(255, 71, 70, 80); // Cor padrão para tipos desconhecidos
    }
  }
}