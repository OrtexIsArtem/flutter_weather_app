part of '../search_page.dart';

class _CityList extends StatelessWidget {
  const _CityList();

  @override
  Widget build(BuildContext context) {
    final cities = context.select((CityBloc bloc) => bloc.state.cities);
    final searchedCities = context.select((CityBloc bloc) => bloc.state.searchedCities);
    final isSearching = context.select((CityBloc bloc) => bloc.state.isSearching);

    final vCities = isSearching ? searchedCities : cities;

    return ListView.builder(
      itemCount: vCities.length,
      itemBuilder: (_, index) {
        final city = vCities[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CityTile(
            cityName: '${city.city}, ${city.country}',
            onTap: () {},
          ),
        );
      },
    );
  }
}
