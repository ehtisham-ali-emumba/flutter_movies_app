/// This file serves as a centralized place for all UI text strings used in the app.
/// It makes it easier to maintain, update, and potentially localize the app in the future.

class AppStrings {
  // App general
  static const String appName = 'MOVIES HOUSE';

  // Navigation and screens
  static const String moviesTab = 'Movies';
  static const String settingsTab = 'Settings';
  static const String aboutTab = 'About';

  // Splash screen
  static const String loading = 'Loading...';
  static const String reloadApp = 'Reload App';

  // Movie tab screen
  static const String moviesHouse = 'MOVIES HOUSE';

  // Movie search
  static const String searchHint = "What'd you like to watch?";
  static const String search = "Search";
  static const String searchMoviesHint = "Search for movies...";

  // Movie details
  static const String reviews = 'Reviews';
  static const String addReview = 'Add Review';
  static const String noReviews =
      'No reviews yet. Be the first to leave a review!';
  static const String ratingHint = 'Tap to rate';
  static const String adult18Plus = '18+';

  // Movie reviews
  static const String reviewUsername = 'Username';
  static const String reviewNameRequired = 'Please enter your name';
  static const String reviewComment = 'Write your review';
  static const String reviewCommentRequired = 'Please write a review';
  static const String reviewAddImage = 'Add Image (Optional)';
  static const String reviewSubmit = 'Submit Review';
  static const String reviewSubmitting = 'Submitting...';
  static const String reviewSuccess = 'Review submitted successfully!';
  static const String reviewFailed = 'Failed to submit review';

  // Rate movie screen
  static const String rateMoviePrefix = 'Rate ';
  static const String yourRating = 'Your Rating';
  static const String yourReview = 'Your Review';
  static const String yourName = 'Your Name';
  static const String enterYourName = 'Enter your name';
  static const String enterYourThoughts = 'What did you think about the movie?';

  // Favorite movies
  static const String favoriteMovies = 'Favorite Movies';
  static const String noFavoriteMovies = 'No favorite movies added yet';
  static const String startAddingFavorites =
      'Start adding some movies to your favorites';

  // Error messages
  static const String errorGeneric = 'Something went wrong';
  static const String noResults = 'No results found';
  static const String tryAgain = 'Try Again';
  static const String failedToLoadMovies = 'Failed to load movies';

  // Actions
  static const String cancel = 'Cancel';
  static const String ok = 'OK';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';

  static const String tvDrama = 'TV Drama';
  static const String starCast = 'Star Cast';
  static const String selectThemeColor = 'Select Theme Color';
  static const String deleteReview = 'Delete Review';
  static const String reviewDeleted = 'Review Deleted';
  static const String reviewAddedSuccessfully = 'Review added successfully!';
  static const String selectAnImage = "Please select an image.";
  static const String changeThemeColor = 'Change theme color';
  static const String actionMovies = "Action Movies";
  static const String topRatedMovies = "Top Rated Movies";
  static const String areYouSureToDelete =
      'Are you sure you want to delete this review?';
}
