part of 'search_page.dart';

class _BlocListenersWrapper extends StatelessWidget {
  const _BlocListenersWrapper({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CityBloc, CityState>(
          listener: (context, state) {
            context.read<WeatherBloc>().add(GetCityWeatherEvent(
                  latitude: state.selectedCity!.lat,
                  longitude: state.selectedCity!.lng,
                ));
            Navigator.pop(context);
          },
          listenWhen: (prev, current) =>
              prev.selectedCity != current.selectedCity &&
              current.selectedCity != null,
        ),
        BlocListener<CityBloc, CityState>(
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error!.message),
            ));
          },
          listenWhen: (previous, current) =>
              previous.error != current.error && current.error != null,
        ),
      ],
      child: child,
    );
  }
}
