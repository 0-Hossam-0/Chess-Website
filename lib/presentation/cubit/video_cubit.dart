import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoPlayerController? _controller;

  VideoCubit() : super(VideoInitial());

  Future<void> initializeVideo(String assetPath) async {
    try {
      emit(VideoLoading());

      _controller = VideoPlayerController.asset(assetPath);

      // Use a small delay or ensure this runs after the frame is built
      await Future.delayed(Duration(milliseconds: 100));

      await _controller!.initialize();
      await _controller!.setLooping(true);
      await _controller!.setVolume(0); // Muting often speeds up initial loading
      _controller!.play();

      emit(VideoLoaded(_controller!));
    } catch (e) {
      emit(VideoError("Error: $e"));
    }
  }

  void togglePlay() {
    if (state is VideoLoaded) {
      final controller = (state as VideoLoaded).controller;
      controller.value.isPlaying ? controller.pause() : controller.play();
      emit(VideoLoaded(controller)); // Re-emit to trigger UI update if needed
    }
  }

  @override
  Future<void> close() {
    _controller?.dispose(); // Clean up resources
    return super.close();
  }
}
