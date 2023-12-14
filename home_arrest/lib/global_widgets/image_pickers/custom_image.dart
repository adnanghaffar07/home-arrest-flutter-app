import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_arrest/constants/image_constants.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? imagePlaceHolder;
  const CustomImage({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.imagePlaceHolder});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image ?? "",
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Image.asset(imagePlaceHolder ?? ImagesConstants.userPlaceholder, height: height, width: width, fit: fit),
      errorWidget: (context, url, error) => Image.asset(imagePlaceHolder ?? ImagesConstants.userPlaceholder, height: height, width: width, fit: fit),
    );
  }
}
