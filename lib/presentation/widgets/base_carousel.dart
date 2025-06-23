import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BaseCarousel extends StatelessWidget {
  final List<Widget> items;
  final CarouselSliderController? controller;
  final CarouselOptions? options;

  const BaseCarousel({
    super.key,
    required this.items,
    this.controller,
    this.options,
  });

  @override
  Widget build(BuildContext context) {
    final defaultOptions = CarouselOptions(
      height: 400,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 4),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      pauseAutoPlayOnTouch: true,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      enableInfiniteScroll: true,
    );

    final effectiveOptions = mergeOptions(defaultOptions, options);

    return CarouselSlider(
      carouselController: controller,
      options: effectiveOptions,
      items: items,
    );
  }
}

CarouselOptions mergeOptions(
  CarouselOptions defaults,
  CarouselOptions? overrides,
) {
  if (overrides == null) return defaults;

  return defaults.copyWith(
    height: overrides.height,
    enlargeCenterPage: overrides.enlargeCenterPage,
    enlargeFactor: overrides.enlargeFactor,
    autoPlay: overrides.autoPlay,
    autoPlayInterval: overrides.autoPlayInterval,
    autoPlayAnimationDuration: overrides.autoPlayAnimationDuration,
    pauseAutoPlayOnTouch: overrides.pauseAutoPlayOnTouch,
    aspectRatio: overrides.aspectRatio,
    viewportFraction: overrides.viewportFraction,
    enableInfiniteScroll: overrides.enableInfiniteScroll,
    initialPage: overrides.initialPage,
    reverse: overrides.reverse,
    autoPlayCurve: overrides.autoPlayCurve,
    onPageChanged: overrides.onPageChanged,
    onScrolled: overrides.onScrolled,
    scrollDirection: overrides.scrollDirection,
    pauseAutoPlayOnManualNavigate: overrides.pauseAutoPlayOnManualNavigate,
    pauseAutoPlayInFiniteScroll: overrides.pauseAutoPlayInFiniteScroll,
    pageSnapping: overrides.pageSnapping,
    scrollPhysics: overrides.scrollPhysics,
    padEnds: overrides.padEnds,
    clipBehavior: overrides.clipBehavior,
    disableCenter: overrides.disableCenter,
  );
}
