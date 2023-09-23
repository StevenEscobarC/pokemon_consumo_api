import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_consumo_api/models/pokemon_model.dart';

class ServicioPokemon {
  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['pokemon'];
      return data.map((json) => Pokemon.fromJson(json)).toList();
    } else {
      throw Exception('falló');
    }
  }
}
