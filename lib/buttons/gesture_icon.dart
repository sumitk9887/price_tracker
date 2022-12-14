
import 'package:flutter/material.dart';


class PlayPauseButton extends StatefulWidget {
  
  const PlayPauseButton({super.key});

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;

  bool currentlyPlaying = false;
  void _iconTapped() {

    //when in play mode
    if (currentlyPlaying == false) {
      currentlyPlaying = true;
      _animationController.forward();
    //when in pause mode
    } else {
      currentlyPlaying = false;
      _animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: _iconTapped,
      child: AnimatedIcon(
        color: Colors.black,
        icon: AnimatedIcons.play_pause,
        progress: _animationController,
        size: 30,
      ),
    );
  }
}
