import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/favorite_show.dart';

class FavoriteController extends GetxController {
  final Box<FavoriteShow> _box = Hive.box<FavoriteShow>('favorites');
  final favorites = <FavoriteShow>[].obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  void _load() => favorites.assignAll(_box.values);

  bool isFavorite(int id) => favorites.any((e) => e.id == id);

  Future<void> toggle(Map<String, dynamic> show) async {
    final id = show['id'] as int;
    if (_box.containsKey(id)) {
      await _box.delete(id);
    } else {
      await _box.put(
        id,
        FavoriteShow(
          id: id,
          name: show['name'],
          image: show['image'],
          rating: show['rating'],
        ),
      );
    }
    _load();
  }

  Future<void> remove(int id) async {
    await _box.delete(id);
    _load();
  }
}
