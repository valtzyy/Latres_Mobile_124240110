import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  const Poster(this.url, {super.key, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: Colors.grey.shade900,
      child: const Center(child: Icon(Icons.movie, color: Colors.white24)),
    );
    if (url == null) return placeholder;
    return Image.network(
      url!,
      fit: fit,
      errorBuilder: (_, __, ___) => placeholder,
      loadingBuilder: (c, child, p) => p == null ? child : placeholder,
    );
  }
}

class RatingText extends StatelessWidget {
  final double? rating;
  final double size;
  const RatingText(this.rating, {super.key, this.size = 12});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.amber, size: size + 2),
          const SizedBox(width: 3),
          Text(rating?.toString() ?? '-', style: TextStyle(fontSize: size)),
        ],
      );
}
