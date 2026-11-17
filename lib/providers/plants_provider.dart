import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/plant.dart';

class PlantsProvider extends ChangeNotifier {
  final String _baseUrl = 'perenual.com';
  final String _apiKey = 'sk-perenual-key'; // Reemplazar con tu API Key personal

  List<Plant> onDisplayPlants = [];
  List<Plant> popularPlants = [];
  bool isLoading = true;

  PlantsProvider() {
    getOnDisplayPlants();
  }

  Future<void> getOnDisplayPlants() async {
    try {
      final url = Uri.https(_baseUrl, '/api/v2/species-list', {
        'key': _apiKey,
        'page': '1',
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final plantResponse = PlantResponse.fromJson(response.body);
        onDisplayPlants = plantResponse.data;
        popularPlants = List.from(plantResponse.data.reversed);
        isLoading = false;
        notifyListeners();
      } else {
        print('Error status code: ' + response.statusCode.toString());
        isLoading = false;
        notifyListeners();
      }
    } catch (e, stackTrace) {
      print('Exception en PlantsProvider: ' + e.toString());
      print(stackTrace);
      isLoading = false;
      notifyListeners();
    }
  }
}