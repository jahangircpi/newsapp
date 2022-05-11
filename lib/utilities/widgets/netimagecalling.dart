import 'package:flutter/material.dart';

import '../constants/colors.dart';

networkImagescall({required src, dynamic color}) {
  return Image.network(
    src,
    fit: BoxFit.cover,
    color: color,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
          color: PColors.backgrounColor,
          backgroundColor: Colors.red,
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
