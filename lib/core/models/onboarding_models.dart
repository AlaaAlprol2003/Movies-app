import '../resources/assets_manager.dart';

class OnboardingModel {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String buttonText;

  OnboardingModel({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  static List<OnboardingModel> onboardings = [
    OnboardingModel(
      imageAsset: BoardingConstants.boarding1,
      title: 'Find Your Next Favorite Movie Here',
      subtitle:
          'Get access to a huge library of movies \n to suit all tastes. You will surely like it.',
      buttonText: 'Explore Now',
    ),
    OnboardingModel(
      imageAsset: BoardingConstants.boarding2,
      title: 'Discover Movies',
      subtitle:
          'Explore a vast collection of movies in all \n qualities and genres. Find your next \n favorite film with ease.',
      buttonText: 'Next',
    ),
    OnboardingModel(
      imageAsset: BoardingConstants.boarding3,
      title: 'Explore All Genres',
      subtitle:
          'Discover movies from every genre, in all \n available qualities. Find something new \n and exciting to watch every day.',
      buttonText: 'Next',
    ),
    OnboardingModel(
      imageAsset: BoardingConstants.boarding4,
      title: 'Create Watchlists',
      subtitle:
          'Save movies to your watchlist to keep \n track of what you want to watch next.\n Enjoy films in various qualities and \n genres.',
      buttonText: 'Next',
    ),
    OnboardingModel(
      imageAsset: BoardingConstants.boarding5,
      title: 'Rate, Review, and Learn',
      subtitle:
          'Share your thoughts on the movies \n you ve watched. Dive deep into film \n details and help others discover great \n movies with your reviews.',
      buttonText: 'Next',
    ),
    OnboardingModel(
      imageAsset: BoardingConstants.boarding6,
      title: 'Start Watching Now',
      subtitle: '',
      buttonText: 'Finish',
    ),
  ];
}
