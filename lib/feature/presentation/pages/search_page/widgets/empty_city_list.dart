part of '../search_page.dart';

/// because it's not used anywhere else
const Color _kPlaceholderColor = Color(0xFFc8c9d1);

class _EmptyCityList extends StatelessWidget {
  const _EmptyCityList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.7,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PlaceholderLine(),
            _PlaceholderLine(),
            _PlaceholderLine(),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderLine extends StatelessWidget {
  const _PlaceholderLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: _kPlaceholderColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 35,
              decoration: BoxDecoration(
                color: _kPlaceholderColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
