part of '../home_page.dart';

class _WeatherInfo extends StatelessWidget {
  const _WeatherInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Montreal',
          style: context.textTheme.bodyLarge,
        ),
        Text(
          '19°',
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
          '10 km/h',
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
