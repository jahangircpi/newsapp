import 'package:flutter/material.dart';

networkImagescall({required src, textofnoimage}) {
  return Image.network(
    src,
    fit: BoxFit.cover,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
    errorBuilder: (context, exception, stackTrace) {
      return const Center(
        child: Text('No image found...'),
      );
    },
  );
}
