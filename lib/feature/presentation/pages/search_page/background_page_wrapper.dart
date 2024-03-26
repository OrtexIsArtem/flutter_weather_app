part of 'search_page.dart';

class _BackgroundPageWrapper extends StatelessWidget {
  const _BackgroundPageWrapper({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.bgPrimary, AppColors.bgSecondary],
          ),
        ),
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
