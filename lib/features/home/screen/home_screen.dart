import 'package:chess_app/features/home/widgets/home_background_video.dart';
import 'package:chess_app/features/home/widgets/home_dark_layout.dart';
import 'package:chess_app/presentation/widgets/chess_logo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const double videoAspectRatio = 9 / 16;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: videoAspectRatio,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const HomeBackgroundVideo(),
                const HomeDarkLayout(),
                SafeArea(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            CustomPaint(
                              size: const Size(100, 100),
                              painter: ChessLogo(color: colorScheme.primary),
                            ),
                            Text("Chessly", style: TextStyle(fontSize: 40)),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3.5,
                            children: [
                              _buildMenuButton("Play Online"),
                              _buildMenuButton("Puzzles"),
                              _buildMenuButton("Computer"),
                              _buildMenuButton("Learn"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        foregroundColor: Colors.white,
        elevation: 0,
        side: const BorderSide(color: Colors.white24),
      ),
      child: Text(label),
    );
  }
}
