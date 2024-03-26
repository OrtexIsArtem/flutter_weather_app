import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';

class AppSvg extends StatelessWidget {
  const AppSvg({
    super.key,
    required this.path,
    this.color = AppColors.primaryIcon,
    this.size,
  });

  final String path;
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      width: size,
      height: size,
    );
  }
}
