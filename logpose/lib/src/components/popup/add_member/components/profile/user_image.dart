import 'package:flutter/cupertino.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageUrl.startsWith('http')
              ? NetworkImage(imageUrl)
              : AssetImage(imageUrl) as ImageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
