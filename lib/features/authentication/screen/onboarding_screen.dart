import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/app_button.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/data/dummy_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0; // Index của slider hiện tại


  void _completeOnboarding() {
    Modular.to
        .navigate("/authen/signin"); // Điều hướng đến đăng nhập
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap.mdHeight,
          Expanded(
            child: CarouselSlider.builder(
              itemCount: onboardingData.length,
              itemBuilder: (context, index, _) {
                final data = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          data["image"]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 250,
                        ),
                      ),
                      Gap.mdHeight,
                      TextHead(
                        text: data["title"].toString(),
                      ),
                      Gap.smHeight,
                      Text(
                        data["description"].toString(),
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: 500,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Gap.mdHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentIndex == index ? 12 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Gap.mdHeight,
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppButton(
              text: "Go to sign in",
              onPressed: _completeOnboarding,
            ),
          ),
          Gap.lgHeight,
        ],
      ),
    );
  }
}
