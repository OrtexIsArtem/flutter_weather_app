import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';

class AppSvg extends StatelessWidget {
  const AppSvg({
    super.key,
    required this.path,
    this.color = AppColors.primaryIcon,
  });

  final String path;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
