import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/dimens.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    super.key,
    required this.imageUrl,
    this.size,
    this.borderRadius,
  });

  final String imageUrl;
  final BorderRadiusGeometry? borderRadius;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(Dimens.spacing4),
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
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
      ),
    );
  }
}
