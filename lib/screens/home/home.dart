import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonapp/common_ui/background_video_player.dart';
import 'package:salonapp/screens/home/cubit/home_service_cubit.dart';
import 'package:salonapp/screens/home/widgets/horizontal_product_service_card_section.dart';
import 'package:salonapp/utils/app_color.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _homeServiceCubit = HomeServiceCubit();
  Timer? _timer;
  String hintText = '';
  int index = 0;
  List<String> searchSuggestionList = [
    'Spa',
    'Waxing',
    'Facial',
    'Clean-Up',
    'Threading'
  ];
  final TextEditingController _controller = TextEditingController();

  int lengthOfText = 0;
  int currentIndexOfText = 0;
  @override
  void initState() {
    super.initState();

    _homeServiceCubit.getServiceByType();
    // _startTypewriterAnimation(0);
  }

  // void _startTypewriterAnimation(indexOfSuggestion) async {
  //   try {
  //     for (int i = 0; i <= searchSuggestionList[index].length; i++) {
  //       await Future.delayed(const Duration(milliseconds: 200));
  //       hintText = searchSuggestionList[index].substring(0, i);
  //       setState(() {});
  //       if (i == searchSuggestionList[index].length) {
  //         Future.delayed(const Duration(seconds: 3), () {
  //           hintText = '';
  //           if (index == searchSuggestionList.length - 1) {
  //             index = 0;
  //           } else {
  //             index++;
  //           }
  //           setState(() {});
  //           _startTypewriterAnimation(index);
  //         });
  //       }
  //     }
  //   } catch (e) {}
  // }

  // start() {
  //   _timer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
  //     if (lengthOfText == currentIndexOfText) {
  //       Future.delayed(const Duration(seconds: 3), () {
  //         updateHintText();
  //       });
  //     } else {
  //       updateHintText();
  //     }
  //   });
  // }

  // updateHintText() {
  //   if (currentIndexOfText < lengthOfText) {
  //     hintText = hintText + searchSuggestionList[index][currentIndexOfText];
  //     currentIndexOfText++;
  //   } else {
  //     hintText = '';
  //     if (index == searchSuggestionList.length - 1) {
  //       index = 0;
  //     } else {
  //       index++;
  //     }
  //     lengthOfText = searchSuggestionList[index].length;
  //     currentIndexOfText = 0;
  //   }
  //   setState(() {});
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                // carouselController: _carouselController,
                items: [
                  'https://www.beautyisland.in/wp-content/uploads/2022/02/Beauty-island-Salon.jpg',
                  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/salon-offer-template-design-aa25107cd6cd3de28b2f016eba6ca5f3_screen.jpg?ts=1650818942',
                  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/hair-salon-special-offer-discount-banner-design-template-34f3aee8ea279d7493751dddc0042a33_screen.jpg?ts=1561539354',
                  'https://d168jcr2cillca.cloudfront.net/uploadimages/coupons/10745-GSBeautyStudio_640x320_Banner.jpg'
                ]
                    .map((e) => CachedNetworkImage(
                          imageUrl: e,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    aspectRatio: 1,
                    height: 200)),
            BlocBuilder<HomeServiceCubit, HomeServiceState>(
                bloc: _homeServiceCubit,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case HomeServiceDataFetched:
                      final successState = state as HomeServiceDataFetched;
                      return HorizontalProductserviceCardSection(
                        headerText: 'Trending Services',
                        data: successState.trending,
                      );
                    default:
                      return SizedBox();
                  }
                }),
            BlocBuilder<HomeServiceCubit, HomeServiceState>(
                bloc: _homeServiceCubit,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case HomeServiceDataFetched:
                      final successState = state as HomeServiceDataFetched;
                      return HorizontalProductserviceCardSection(
                        headerText: 'Popular Services',
                        data: successState.popular,
                      );
                    default:
                      return SizedBox();
                  }
                }),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: BackgroundVideoPlayer(
                        videoUrl:
                            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // color: Colors.black45.withOpacity(0.35),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [
                              Colors.black.withOpacity(0.78),
                              Colors.black.withOpacity(0)
                            ])),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LED PHOTO FACIAL',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Illuminate Your\nSkin's Natural\nLuminosty",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text(
                            'Explore',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<HomeServiceCubit, HomeServiceState>(
                bloc: _homeServiceCubit,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case HomeServiceDataFetched:
                      final successState = state as HomeServiceDataFetched;
                      return HorizontalProductserviceCardSection(
                        headerText: 'Recommended Services',
                        data: successState.recommended,
                      );
                    default:
                      return SizedBox();
                  }
                }),
            CachedNetworkImage(
              width: double.infinity,
              height: 180,
              imageUrl:
                  'https://marketplace.canva.com/EAE-huAz88k/1/0/1600w/canva-modern-green-fashion-sale-%28banner-%28landscape%29%29-Ye_HTOWPMMQ.jpg',
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
