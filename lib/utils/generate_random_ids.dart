import 'dart:math';

class GenerateRandomIds {
  //Função para gerar os índices(Pokémons) aleatórios sem repetir
    List<int> generateRandomPokemonIds(int quantity, int limit){
      final random = Random();
      
      final Set<int> uniqueIds = {};

      while (uniqueIds.length < quantity){
        final randomNumber = random.nextInt(limit);
        uniqueIds.add(randomNumber);
      }

      return uniqueIds.toList();
    }
}