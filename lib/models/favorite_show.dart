import 'package:hive/hive.dart';

class FavoriteShow {
  final int id;
  final String name;
  final String? image;
  final double? rating;

  FavoriteShow({
    required this.id,
    required this.name,
    this.image,
    this.rating,
  });
}

/// TypeAdapter manual (setara hasil hive_generator, tanpa build_runner).
class FavoriteShowAdapter extends TypeAdapter<FavoriteShow> {
  @override
  final int typeId = 0;

  @override
  FavoriteShow read(BinaryReader reader) {
    final n = reader.readByte();
    final f = <int, dynamic>{
      for (var i = 0; i < n; i++) reader.readByte(): reader.read(),
    };
    return FavoriteShow(
      id: f[0] as int,
      name: f[1] as String,
      image: f[2] as String?,
      rating: f[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteShow obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.rating);
  }
}
