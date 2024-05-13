import 'package:flutter/material.dart';

class BackgroundPokemonTypeDefinition {
  static final Map<String, Color?> _typeColorMap = {
    'grass': Colors.green[300],
    'fire': Colors.red[500],
    'water': Colors.blue[300],
    'poison': Colors.purple[300],
    'bug': Colors.brown[300],
    'normal': Colors.white,
    'electric': Colors.yellow[300],
    'fairy': Colors.pink[300],
    'dragon': Colors.orange[300],
    'ground': Colors.brown[500],
    'psychic': Colors.purple[300],
    'rock': Colors.brown[300],
    'steel': Colors.blueGrey[300],
    'ice': Colors.blue[300],
    'fighting': Colors.brown[400],
    'dark': Colors.black,
    'ghost': Colors.black,
  };

  Color? defineColorByType(String pokemonType) {
    for (var type in _typeColorMap.keys) {
      if (pokemonType.contains(type)) {
        return _typeColorMap[type];
      }
    }
    return const Color.fromARGB(255, 71, 70, 80); // Cor padrão para tipos desconhecidos
  }
}
