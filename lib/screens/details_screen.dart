import 'package:flutter/material.dart';
import '../models/plant.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Plant plant = ModalRoute.of(context)!.settings.arguments as Plant;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(plant: plant),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(plant: plant),
              _Overview(plant: plant),
              _DetailsTable(plant: plant),
            ]),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Plant plant;
  const _CustomAppBar({required this.plant});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.green,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black26,
          child: Text(
            plant.commonName,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const NetworkImage('[suspicious link removed]'),
          image: NetworkImage(plant.fullImageUrl),
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child: const Icon(Icons.local_florist, size: 80, color: Colors.green),
            );
          },
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Plant plant;
  const _PosterAndTitle({required this.plant});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const NetworkImage('[suspicious link removed]'),
              image: NetworkImage(plant.fullImageUrl),
              height: 150,
              width: 110,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  width: 110,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.eco, size: 50, color: Colors.green),
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.commonName,
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  plant.scientificName.join(', '),
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.water_drop, size: 18, color: Colors.blue),
                    const SizedBox(width: 5),
                    Text(
                      'Riego: ' + (plant.watering ?? 'No especificado'),
                      style: textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Plant plant;
  const _Overview({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text(
        'Ficha técnica botánica: Nombre científico "' + plant.scientificName.join(', ') + '". Riego: "' + (plant.watering ?? 'No especificado') + '". Ciclo: ' + (plant.cycle ?? 'No especificado') + '.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _DetailsTable extends StatelessWidget {
  final Plant plant;
  const _DetailsTable({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade200),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          _DetailRow(icon: Icons.wb_sunny, label: 'Luz solar', value: plant.sunlight ?? 'No especificado'),
          const Divider(),
          _DetailRow(icon: Icons.repeat, label: 'Ciclo vital', value: plant.cycle ?? 'No especificado'),
          const Divider(),
          _DetailRow(icon: Icons.tag, label: 'ID Especie', value: '#' + plant.id.toString()),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade700, size: 22),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}