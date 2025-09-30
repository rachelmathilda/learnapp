import 'package:flutter/material.dart';
import 'login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "illustration": "images/bookbiteonboarding1.png",
      "title": "Listen to Our Tutor",
      "desc":
          "We provide a tutor audio version that can be play with your pace",
    },
    {
      "illustration": "images/bookbiteonboarding2.png",
      "title": "Summaries and Quiz",
      "desc":
          "We provide summaries and quiz to understand each chapter of your book better",
    },
    {
      "illustration": "images/bookbiteonboarding3.png",
      "title": "Ask Timi",
      "desc": "You can ask our chatbot about concept you don’t understand yet",
    },
  ];

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  Widget _buildPage(Map<String, String> data) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.2,
          left: 0,
          right: 0,
          child: SizedBox(
            height: screenHeight * 0.4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ClipRect(
                    child: SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.4,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          FractionalTranslation(
                            translation: Offset(-_currentIndex.toDouble(), 0),
                            child: SizedBox(
                              width: screenWidth * 3,
                              child: Image.asset(
                                'images/bg_onboarding_bookbite.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/shadow.png',
                            fit: BoxFit.contain,
                            width: 260,
                          ),
                          Image.asset(
                            data["illustration"]!,
                            fit: BoxFit.contain,
                            width: 400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.3 + screenHeight * 0.4 - 38),
                Column(
                  children: [
                    Text(
                      data["title"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data["desc"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_onboardingData.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index
                                ? const Color(0xFF1A1B1F)
                                : const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1B1F),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(365, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    _currentIndex == _onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _controller,
        itemCount: _onboardingData.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemBuilder: (context, index) {
          return _buildPage(_onboardingData[index]);
        },
      ),
    );
  }
}
