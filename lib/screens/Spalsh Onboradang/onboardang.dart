import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = '/onBoardingScreen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "image": Assets.asstes.images.png.redScreen,
      "title": "Find Your Next Favorite Movie Here",
      "desc":
      "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      "button": "Explore Now",
    },
    {
      "image": Assets.asstes.images.png.blueScreen,
      "title": "Discover Movies",
      "desc":
      "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      "button": "Next",
    },
    {
      "image": Assets.asstes.images.png.redScreen,
      "title": "Explore All Genres",
      "desc":
      "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      "button": "Next",
    },
    {
      "image": Assets.asstes.images.png.purpleScreen,
      "title": "Create Watchlists",
      "desc":
      "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      "button": "Next",
    },
    {
      "image": Assets.asstes.images.png.darkScreen,
      "title": "Rate, Review, and Learn",
      "desc":
      "Share your thoughts on the movies you’ve watched. Dive deep into film details and help others discover great movies with your reviews.",
      "button": "Next",
    },
    {
      "image": Assets.asstes.images.png.grayScreen,
      "title": "Start Watching Now",
      "desc": "Enjoy your next favorite film anytime, anywhere.",
      "button": "Finish",
    },
  ];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          final item = onboardingData[index];

          return Stack(
            children: [
              Positioned.fill(
                child: item["image"].image(
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.black.withValues(alpha: 0.2),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                left: width * 0.06,
                right: width * 0.06,
                child: Column(
                  children: [
                    Text(
                      item["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      item["desc"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: width * 0.035,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: width * 0.9,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_currentIndex < onboardingData.length - 1) {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        },
                        child: Text(
                          item["button"],
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (_currentIndex > 0) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: width * 0.9,
                        height: 45,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.amber),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}