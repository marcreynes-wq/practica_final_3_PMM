import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantSlider extends StatelessWidget {
  final List<Plant> plants;
  final String? title;

  const PlantSlider({
    Key? key,
    required this.plants,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                title!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plants.length,
              itemBuilder: (_, int index) => _PlantPoster(plant: plants[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlantPoster extends StatelessWidget {
  final Plant plant;

  const _PlantPoster({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: plant),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const NetworkImage('[suspicious link removed]'),
                image: NetworkImage(plant.fullImageUrl),
                width: 130,
                height: 170,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 130,
                    height: 170,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.eco, size: 40, color: Colors.green),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            plant.commonName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}