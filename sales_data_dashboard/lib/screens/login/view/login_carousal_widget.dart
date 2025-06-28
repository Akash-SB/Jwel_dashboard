import 'dart:async';

import 'package:flutter/material.dart';

class LoginCarousalWidget extends StatefulWidget {
  final List<String> images;
  final List<String> titles;
  final List<String> subtitles;

  const LoginCarousalWidget({
    super.key,
    required this.images,
    required this.titles,
    required this.subtitles,
  });

  @override
  State<LoginCarousalWidget> createState() => _LoginCarousalWidgetState();
}

class _LoginCarousalWidgetState extends State<LoginCarousalWidget> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        itemBuilder: (_, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(widget.images[index], fit: BoxFit.cover),
              Container(color: Colors.black.withOpacity(0.4)),
              Positioned(
                bottom: 60,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.titles[index],
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.subtitles[index],
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
