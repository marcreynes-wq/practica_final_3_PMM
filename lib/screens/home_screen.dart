import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/plants_provider.dart';
import '../widgets/card_swiper.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plantsProvider = Provider.of<PlantsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Plantas - PF3'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => plantsProvider.getOnDisplayPlants(),
          )
        ],
      ),
      body: plantsProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  CardSwiper(plants: plantsProvider.onDisplayPlants),
                  PlantSlider(
                    plants: plantsProvider.popularPlants,
                    title: 'Especies Destacadas',
                  ),
                ],
              ),
            ),
    );
  }
}