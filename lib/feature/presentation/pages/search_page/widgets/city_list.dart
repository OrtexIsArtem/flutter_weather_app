part of '../search_page.dart';

class _CityList extends StatelessWidget {
  const _CityList();

  @override
  Widget build(BuildContext context) {
    final cityState = context.watch<CityBloc>().state;
    final cityBloc = context.read<CityBloc>();

    // TODO move logic to bloc?
    final vCities =
        cityState.isSearching ? cityState.searchedCities : cityState.cities;

    return ListView.builder(
      itemCount: vCities.length,
      itemBuilder: (_, index) {
        final city = vCities[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CityTile(
            cityName: '${city.city}, ${city.country}',
            onTap: () {
              cityBloc.add(SelectCityEvent(selectedCity: city));
            },
          ),
        );
      },
    );
  }
}
