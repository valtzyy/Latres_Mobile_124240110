import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config.dart';
import '../controllers/favorite_controller.dart';
import 'detail_page.dart';
import 'widgets.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<FavoriteController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Favorit')),
      body: Obx(() {
        if (c.favorites.isEmpty) {
          return const Center(child: Text('Belum ada favorit'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: c.favorites.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final f = c.favorites[i];
            return Material(
              color: kCard,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Get.to(() => DetailPage(id: f.id)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8)),
                      child: SizedBox(
                          width: 56, height: 72, child: Poster(f.image)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          RatingText(f.rating),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: kAccent),
                      onPressed: () => c.remove(f.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
