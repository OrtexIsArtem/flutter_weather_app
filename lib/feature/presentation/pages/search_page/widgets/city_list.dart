part of '../search_page.dart';

class _CityList extends StatelessWidget {
  const _CityList();

  @override
  Widget build(BuildContext context) {
    final cities = context.select((CityBloc bloc) => bloc.state.cities);
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (_, index) {
        final city = cities[index];
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
