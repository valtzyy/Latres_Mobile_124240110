import 'dart:convert';
import 'package:http/http.dart' as http;

/// Fetch & parse data API dipisah dari UI.
class TvMazeService {
  static const _base = 'https://api.tvmaze.com';

  /// Daftar shows -> list of Map (tanpa model).
  static Future<List<Map<String, dynamic>>> fetchShows() async {
    final res = await http.get(Uri.parse('$_base/shows'));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat data (${res.statusCode})');
    }
    final list = jsonDecode(res.body) as List;
    return list.map((e) => _parse(e as Map<String, dynamic>)).toList();
  }

  /// Detail show berdasarkan id.
  static Future<Map<String, dynamic>> fetchShowDetail(int id) async {
    final res = await http.get(Uri.parse('$_base/shows/$id'));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat detail (${res.statusCode})');
    }
    return _parse(jsonDecode(res.body) as Map<String, dynamic>);
  }

  static Map<String, dynamic> _parse(Map<String, dynamic> j) {
    final img = j['image'] as Map<String, dynamic>?;
    String? fix(String? u) => u?.replaceFirst('http://', 'https://');
    return {
      'id': j['id'],
      'name': j['name'] ?? '-',
      'image': fix(img?['medium'] as String?),
      'imageLarge': fix(img?['original'] as String?),
      'rating': (j['rating']?['average'] as num?)?.toDouble(),
      'genres': List<String>.from(j['genres'] ?? const []),
      'summary': _stripHtml(j['summary'] as String?),
    };
  }

  static String _stripHtml(String? s) {
    if (s == null || s.isEmpty) return 'Tidak ada ringkasan.';
    return s.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}
