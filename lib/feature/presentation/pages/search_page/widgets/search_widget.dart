part of '../search_page.dart';

class _SearchWidget extends StatefulWidget {
  const _SearchWidget();

  @override
  State<_SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<_SearchWidget> {
  @override
  void initState() {
    context.read<CityBloc>().add(const ClearSearchResultEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CityBloc>();
    return TextFormField(
      onChanged: (String value) {
        bloc.add(SearchCityEvent(query: value));
      },
      style: const TextStyle(
        fontSize: 17,
      ),
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search for a city',
        prefixIconConstraints: const BoxConstraints(maxWidth: 36, minWidth: 32),
        prefixIcon: AppSvg(
          path: AppIcons.search,
          color: AppColors.secondary.withOpacity(0.6),
          size: 16,
        ),
      ),
    );
  }
}
