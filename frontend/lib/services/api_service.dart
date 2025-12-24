import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person.dart';

class ApiService {
  // Use 10.0.2.2 for Android emulator to access host machine
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Récupérer toutes les personnes
  static Future<List<Person>> getPersons() async {
    final response = await http.get(Uri.parse('$baseUrl/personnes'));
    
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Person.fromJson(item)).toList();
    } else {
      throw Exception('Erreur lors du chargement des personnes');
    }
  }

  // Rechercher des personnes
  static Future<List<Person>> searchPersons(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/personnes/search/$query'));
    
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Person.fromJson(item)).toList();
    } else {
      throw Exception('Erreur lors de la recherche');
    }
  }



  // Récupérer une personne par ID
  static Future<Person> getPerson(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/personnes/$id'));
    
    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Personne non trouvée');
    }
  }



  // Ajouter une personne
  static Future<Person> addPerson(Person person) async {
    final response = await http.post(
      Uri.parse('$baseUrl/personnes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(person.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors de l\'ajout de la personne');
    }
  }


  // Mettre à jour une personne
  static Future<Person> updatePerson(int id, Person person) async {
    final response = await http.put(
      Uri.parse('$baseUrl/personnes/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(person.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors de la mise à jour de la personne');
    }
  }




  // Supprimer une personne
  static Future<void> deletePerson(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/personnes/$id'));
    
    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la suppression de la personne');
    }
  }
}
