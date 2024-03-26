import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/constants/app_colors.dart';
import 'package:flutter_weather_app/feature/presentation/city_bloc/city_bloc.dart';
import 'package:flutter_weather_app/feature/presentation/pages/search_page/widgets/city_tile.dart';
import 'package:flutter_weather_app/feature/presentation/widgets/widgets.dart';
import 'package:flutter_weather_app/utils/app_icons.dart';

part 'background_page_wrapper.dart';

part 'widgets/search_widget.dart';

part 'widgets/city_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _BackgroundPageWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {},
              icon: const AppSvg(path: AppIcons.back),
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SearchWidget(),
                  SizedBox(height: 12),
                  Expanded(
                    child: _CityList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
