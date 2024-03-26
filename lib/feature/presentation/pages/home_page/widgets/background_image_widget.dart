part of '../home_page.dart';

class _BackgroundImageWidget extends StatelessWidget {
  const _BackgroundImageWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppImages.background,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Image.asset(
            AppImages.house,
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
