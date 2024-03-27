part of '../home_page.dart';

class _WeatherInfo extends StatelessWidget {
  const _WeatherInfo();

  @override
  Widget build(BuildContext context) {
    final weather =
        context.select((WeatherBloc bloc) => bloc.state.currentWeather);
    final selectedCity =
        context.select((CityBloc bloc) => bloc.state.selectedCity);
    final isLoading =
        context.select((WeatherBloc bloc) => bloc.state.isLoading);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          selectedCity?.city ?? AppBaseData.noData,
          style: context.textTheme.bodyLarge,
        ),
        isLoading
            ? const Padding(
                padding: EdgeInsets.only(top: 10),
                child: AppLoader(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${weather?.temperature ?? AppBaseData.noData}°',
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
                    '${weather?.windSpeed ?? AppBaseData.noData} ${weather?.speedUnit ?? ''}',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
      ],
    );
  }
}
