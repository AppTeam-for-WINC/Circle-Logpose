import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
  });
  final String imagePath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (context, url) => const SizedBox.shrink(),
      errorWidget: (context, url, error) => const Icon(
        CupertinoIcons.exclamationmark_circle_fill,
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
