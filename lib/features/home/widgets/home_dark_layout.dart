import 'dart:ui';

import 'package:flutter/material.dart';

class HomeDarkLayout extends StatelessWidget {
  const HomeDarkLayout({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: constraints.maxHeight * 0.21,
              height: constraints.maxHeight * 0.572,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.5,
                    colors: [
                      theme.scaffoldBackgroundColor.withValues(alpha: 0.1),
                      theme.scaffoldBackgroundColor.withValues(alpha: 1),
                    ],
                    stops: const [0.0005, 1.0],
                  ),
                ),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          radius: 1.5,
                          colors: [
                            theme.scaffoldBackgroundColor.withValues(
                              alpha: 0.4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
