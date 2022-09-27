import 'dart:async';

import 'package:flutter/material.dart';

import '../models/price.dart';

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
    if (currentlyPlaying == false) {
      currentlyPlaying = true;
      _animationController.forward();
    } else {
      currentlyPlaying = false;
      _animationController.reverse();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _iconTapped,
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: _animationController,
        size: 30,
      ),
    );
  }
}
