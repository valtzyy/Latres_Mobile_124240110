import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config.dart';
import '../controllers/favorite_controller.dart';
import '../services/tvmaze_service.dart';
import 'widgets.dart';

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final fav = Get.find<FavoriteController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: TvMazeService.fetchShowDetail(id),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator(color: kAccent));
          }
          if (snap.hasError) {
            return Center(child: Text('${snap.error}'));
          }
          final s = snap.data!;
          final genres = s['genres'] as List;
          return ListView(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Poster(s['imageLarge']),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(s['name'],
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                        Obx(() {
                          final isFav = fav.isFavorite(id);
                          return IconButton.filledTonal(
                            onPressed: () => fav.toggle(s),
                            icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? kAccent : null),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 6),
                    RatingText(s['rating'], size: 14),
                    const SizedBox(height: 6),
                    Text(
                      genres.isEmpty ? '-' : genres.join(', '),
                      style: const TextStyle(color: Colors.white60),
                    ),
                    const SizedBox(height: 18),
                    const Text('Overview',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(s['summary'], style: const TextStyle(height: 1.4)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
