import 'package:api_app/models/pokemon.dart';
import 'package:api_app/utils/generate_random_ids.dart';
import 'package:api_app/utils/type_color.dart';
import 'package:flutter/material.dart';

class PokemonInformationPage extends StatefulWidget {
  const PokemonInformationPage({super.key, required this.quantity});

  final int quantity;

  @override
  State<PokemonInformationPage> createState() => _PokemonInformationPageState();
}

class _PokemonInformationPageState extends State<PokemonInformationPage> {
  bool isLoading = true;

  List<Pokemon> pokemons = [];
  late final List<int> pokemonIds;

  @override
  void initState() {
    super.initState();

    pokemonIds = generatePokeTeam();
  }

  List<int> generatePokeTeam(){
    int teamSize = widget.quantity;
    pokemons = Pokemon.pokemons.values.toList();
    int limit = pokemons.length;

    var randomizeIntance = GenerateRandomIds();

    final randomIds = randomizeIntance.generateRandomPokemonIds(teamSize, limit);
  
    setState(() {
      isLoading = false;
    });

    return randomIds;
  }

  @override
  Widget build(BuildContext context) {
    var colorDefine = BackgroundPokemonTypeDefinition();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Informations'),
      ),
      body: isLoading
          ? const Padding(
            padding: EdgeInsets.all(8),
            child: Center(child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text('Carregando lista de pokémons'),
                  ),
                ],
              ),
            )),
          )
          : ListView.builder(
          itemCount: pokemonIds.length,
          itemBuilder: (context, index) {
            final pokemon = pokemons[pokemonIds[index]];
            Color? backgroundColor = colorDefine.defineColorByType(pokemon.type); // Cor de fundo do Card
            Color textColor = (backgroundColor == Colors.black || backgroundColor == Colors.blueGrey || backgroundColor == Colors.brown[500]) ? Colors.white : Colors.black; // Cor do texto

            return Card(
              color: backgroundColor,
              child: ListTile(
                title: Text(
                  pokemon.name,
                  style: TextStyle(color: textColor), // Define a cor do texto
                ),
                leading: Image.network(pokemon.imageUrl),
                trailing: Text(
                  pokemon.type,
                  style: TextStyle(color: textColor), // Define a cor do texto
                ),
              ),
            );
        },
      ),
    );
  }
}