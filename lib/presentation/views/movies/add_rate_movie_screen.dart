import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/presentation/view_models/movies/movie_reviews_provider.dart';
import 'package:movies/presentation/widgets/custom_snackbar.dart';
import 'package:movies/presentation/widgets/image_picker.dart';
import 'package:movies/presentation/widgets/text.dart';

class AddRateMovieScreen extends ConsumerStatefulWidget {
  final String movieId;
  final String movieTitle;

  const AddRateMovieScreen({
    super.key,
    required this.movieId,
    required this.movieTitle,
  });

  @override
  ConsumerState<AddRateMovieScreen> createState() => _AddRateMovieScreenState();
}

class _AddRateMovieScreenState extends ConsumerState<AddRateMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  String? imageFilePath;
  double _rating = 3.0;
  bool _isSubmitting = false;

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText(
                "Rate ${widget.movieTitle}",
                kind: TextKind.heading,
                fontSize: 22,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _submitReview() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      if (imageFilePath == null || imageFilePath!.isEmpty) {
        CustomSnackbar.show(context, "Please select an image for your review.");
        setState(() {
          _isSubmitting = false;
        });
        return;
      }

      try {
        await ref
            .read(movieReviewsProvider.notifier)
            .addReview(
              movieId: widget.movieId,
              userName: _nameController.text,
              comment: _reviewController.text,
              rating: _rating,
              imageFilePath: imageFilePath!,
            );

        if (mounted) {
          CustomSnackbar.show(context, 'Review added successfully!');

          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          CustomSnackbar.show(context, 'Error adding review: ${e.toString()}');
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Star rating
                        AppText(
                          'Your Rating',
                          kind: TextKind.heading,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => IconButton(
                              icon: Icon(
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 36,
                              ),
                              onPressed: () {
                                setState(() {
                                  _rating = index + 1;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Name input
                        AppText(
                          'Your Name',
                          kind: TextKind.heading,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Review input
                        AppText(
                          'Your Review',
                          kind: TextKind.heading,
                          fontSize: 18,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _reviewController,
                          decoration: InputDecoration(
                            hintText: 'What did you think about the movie?',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your review';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        Imagepicker(
                          initialImage: imageFilePath,
                          onImageChanged: (imgFile) {
                            imageFilePath = imgFile;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _submitReview,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: _isSubmitting
                                ? const CircularProgressIndicator()
                                : const Text('Submit Review'),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
