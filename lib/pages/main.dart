import 'package:api_app/services/fill_pokemon_info.dart';
import 'package:api_app/pages/poke_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  String? errorMessage;

  var pokemonFillInstance = FillPokemonInformations();

  submitForm(int sizeTeam) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonInformationPage(quantity: sizeTeam)));
  }

  @override
  void initState() {
    pokemonFillInstance.fillPokemonInformations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Sort'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                child: TextFormField(
                  key: const Key('text_form_field'),
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true), // Define o teclado para números decimais
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\d*$')), // Permite apenas números
                  ],
                  decoration: InputDecoration(
                    icon: const Icon(Icons.stay_current_landscape_rounded),
                    hintText: 'How many Pokemons do you want to get?',
                    labelText: 'Pokémon Team Size',
                    errorText: errorMessage,
                  ),
                ),
              ),
              const SizedBox(height: 6.0),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      final sizeTeam = int.tryParse(controller.text);
                      List<Pokemon> pokemons = Pokemon.pokemons.values.toList();
        
                      if (sizeTeam == null || sizeTeam <= 0) {
                        setState(() {
                          errorMessage = 'The number must be greater than zero.';
                        });
                      } else if (sizeTeam > pokemons.length) {
                        String limit = (pokemons.length+1).toString();
                        setState(() {
                          errorMessage = 'The number must be lower than $limit or try again later. (limit of list: 1302)';
                        });
                      } else {
                        setState(() {
                          errorMessage = null;
                        });
                        submitForm(sizeTeam);
                      }
                    },
                    child: const Text('Generate Team'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
