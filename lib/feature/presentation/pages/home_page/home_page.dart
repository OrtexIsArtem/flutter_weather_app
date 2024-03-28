import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/constants/app_base_data.dart';
import 'package:flutter_weather_app/core/constants/app_colors.dart';
import 'package:flutter_weather_app/feature/presentation/city_bloc/city_bloc.dart';
import 'package:flutter_weather_app/feature/presentation/pages/search_page/search_page.dart';
import 'package:flutter_weather_app/feature/presentation/weather_bloc/weather_bloc.dart';
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
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error!.message),
        ));
      },
      listenWhen: (previous, current) =>
          previous.error != current.error && current.error != null,
      child: Scaffold(
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
      ),
    );
  }
}
