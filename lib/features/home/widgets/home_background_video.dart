import 'package:chess_app/presentation/cubit/video_cubit.dart';
import 'package:chess_app/presentation/cubit/video_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class HomeBackgroundVideo extends StatelessWidget {
  const HomeBackgroundVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VideoCubit()..initializeVideo("assets/videos/chessboard.mp4"),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoLoaded) {
            return SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: state.controller.value.size.width,
                  height: state.controller.value.size.height,
                  child: VideoPlayer(state.controller),
                ),
              ),
            );
          } else if (state is VideoError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
