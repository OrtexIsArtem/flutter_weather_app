part of '../home_page.dart';

class _WeatherInfo extends StatelessWidget {
  const _WeatherInfo();

  @override
  Widget build(BuildContext context) {
    final weather =
        context.select((WeatherBloc bloc) => bloc.state.currentWeather);
    final selectedCity =
        context.select((CityBloc bloc) => bloc.state.selectedCity);

    return Column(
      children: [
        Text(
          selectedCity?.city ?? '',
          style: context.textTheme.bodyLarge,
        ),
        Text(
          '${weather?.temperature}°',
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 96,
            fontWeight: FontWeight.w100,
            height: 1,
          ),
        ),
        Text(
          'Wind speed',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.grayText,
          ),
        ),
        Text(
          '${weather?.windSpeed} ${weather?.speedUnit}',
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
