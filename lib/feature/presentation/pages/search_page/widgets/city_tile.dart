import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';

class CityTile extends StatelessWidget {
  const CityTile({
    super.key,
    required this.cityName,
    required this.onTap,
  });

  final String cityName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cityTileBg,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 11,
          ),
          child: Text(
            cityName,
            style: const TextStyle(
              fontFamily: 'SFCompact',
              fontSize: 24,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
