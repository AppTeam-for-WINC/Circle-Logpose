import 'package:flutter/cupertino.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imagePath.startsWith('http')
              ? NetworkImage(imagePath)
              : AssetImage(imagePath) as ImageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
