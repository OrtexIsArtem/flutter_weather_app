import 'package:flutter/material.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/feature/presentation/pages/search_page/search_page.dart';
import 'package:flutter_weather_app/feature/presentation/widgets/widgets.dart';
import 'package:flutter_weather_app/utils/app_icons.dart';
import 'package:flutter_weather_app/utils/app_images.dart';
import 'package:flutter_weather_app/utils/context_extension.dart';

part 'widgets/background_image_widget.dart';
part 'widgets/weather_info.dart';
part 'widgets/search_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundImageWidget(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _SearchButton(),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                const _WeatherInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}