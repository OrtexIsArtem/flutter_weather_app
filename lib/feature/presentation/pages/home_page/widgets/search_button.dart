part of '../home_page.dart';

class _SearchButton extends StatelessWidget {
  const _SearchButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const SearchPage()));
        },
        icon: const AppSvg(
          path: AppIcons.search,
        ),
      ),
    );
  }
}
