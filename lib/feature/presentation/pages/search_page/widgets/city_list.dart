part of '../search_page.dart';

class _CityList extends StatelessWidget {
  const _CityList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CityTile(
            cityName: '$index',
            onTap: () {},
          ),
        );
      },
    );
  }
}
