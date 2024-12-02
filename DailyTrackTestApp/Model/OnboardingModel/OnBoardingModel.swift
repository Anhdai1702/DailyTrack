//
//  OnBoardingSlide.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 6/11/24.
//

import Foundation

import Foundation

struct OnboardingSlide {
  let title: String
  let description: String
  let imageName: String
}

extension OnboardingSlide {
  static let allSlides: [OnboardingSlide] = [
    OnboardingSlide(title: "Develop good habits",
                    description: "You’re taking the first step in changing your life. Let us guide you through it.",
                    imageName: "onboarding1"),
    OnboardingSlide(title: "Track your progress",
                    description: "You’re taking the first step in changing your life. Let us guide you through it.",
                    imageName: "onboarding2"),
    OnboardingSlide(title: "Break bad habits",
                    description: "Habits are fundamental part of our life. Make the most of your life!",
                    imageName: "onboarding3"),
    OnboardingSlide(title: "Challenge your friends",
                    description: "Habits are fundamental part of our life. Make the most of your life!",
                    imageName: "onboarding4")
  ]
}
