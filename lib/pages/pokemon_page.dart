import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pokemon_consumo_api/services/pokemon_service.dart';

import '../models/pokemon_model.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final ServicioPokemon _servicioPokemon = ServicioPokemon();
  List<Pokemon> pokemonList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _servicioPokemon.fetchPokemonList().then((value) {
      setState(() {
        pokemonList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _encabezado(size),
          Container(
            height: size.height * 0.60,
            width: size.width,
            child: pokemonList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : itemBuilder(context, pokemonList),
          )
        ],
      ),
    ));
  }

  Widget _encabezado(dynamic size) {
    return Container(
      height: size.height * 0.30,
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'PokeSoft',
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 53,
                letterSpacing: 10),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Poke universe',
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 12),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, List<Pokemon> snapshot) {
    return ListView.builder(
        itemCount: snapshot.length,
        itemBuilder: (context, index) {
          final Pokemon pokemon = snapshot[index];
          return Card(
            child: ListTile(
              leading: Image.network(pokemon.img),
              title: Text(pokemon.name),
              subtitle: Text('Tipo: ${pokemon.type.join(", ")}'),
              trailing: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Debilidades'),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: pokemon.weaknesses
                                    .map((weak) => ListTile(
                                          title: Text(weak),
                                        ))
                                    .toList()),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cerrar'))
                            ],
                          );
                        });
                  },
                  child: Text('Ver Debilidades')),
            ),
          );
        });
  }
}
