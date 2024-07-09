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

  final scrollController = ScrollController();
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

  bool showAppBarMode = false;
  @override
  void initState() {
    super.initState();

    _homeServiceCubit.getServiceByType();

    scrollController.addListener(() {
      if (scrollController.offset > 200) {
        setState(() {
          showAppBarMode = true;
        });
        print("hello");
      } else {
        if (showAppBarMode) {
          setState(() {
            showAppBarMode = false;
          });
        }
      }
    });
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
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: const Size(double.infinity, 60),
      //     child: Container(
      //       // height: 40,
      //       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //       decoration: BoxDecoration(
      //           color: Colors.grey.shade200,
      //           borderRadius: BorderRadius.circular(8)),
      //       child: TextFormField(
      //         decoration: InputDecoration(
      //             prefixIcon: Icon(Icons.search_rounded),
      //             hintText: "Search for service",
      //             border: InputBorder.none),
      //       ),
      //     )),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      // carouselController: _carouselController,
                      items: [
                        'https://www.shutterstock.com/image-photo/young-woman-visit-beauty-salon-600nw-1551548927.jpg',
                        'https://cdn.create.vista.com/api/media/small/660916710/stock-photo-hairstylist-spraying-hair-female-client-hairdresser-braids-holding-spray-bottle',
                        'https://www.mbmmakeupstudio.com/wp-content/uploads/2021/01/engagement-makeup-services-in-Delhi-1024x682.png',
                        'https://img.freepik.com/free-photo/woman-hairdresser-salon_144627-8812.jpg'
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
                          height: 300)),
                  SizedBox(
                    height: 12,
                  ),
                  BlocBuilder<HomeServiceCubit, HomeServiceState>(
                      bloc: _homeServiceCubit,
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case HomeServiceDataFetched:
                            final successState =
                                state as HomeServiceDataFetched;
                            return successState.trending.isNotEmpty
                                ? HorizontalProductserviceCardSection(
                                    headerText: 'Trending Services',
                                    data: successState.trending,
                                  )
                                : SizedBox();
                          default:
                            return SizedBox();
                        }
                      }),
                  SizedBox(
                    height: 12,
                  ),
                  BlocBuilder<HomeServiceCubit, HomeServiceState>(
                      bloc: _homeServiceCubit,
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case HomeServiceDataFetched:
                            final successState =
                                state as HomeServiceDataFetched;
                            return successState.popular.isNotEmpty
                                ? HorizontalProductserviceCardSection(
                                    headerText: 'Popular Services',
                                    data: successState.popular,
                                  )
                                : SizedBox();
                          default:
                            return SizedBox();
                        }
                      }),
                  SizedBox(
                    height: 42,
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  BlocBuilder<HomeServiceCubit, HomeServiceState>(
                      bloc: _homeServiceCubit,
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case HomeServiceDataFetched:
                            final successState =
                                state as HomeServiceDataFetched;
                            return successState.recommended.isNotEmpty
                                ? HorizontalProductserviceCardSection(
                                    headerText: 'Recommended Services',
                                    data: successState.recommended,
                                  )
                                : SizedBox();
                          default:
                            return SizedBox();
                        }
                      }),
                  SizedBox(
                    height: 32,
                  ),
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
          ),
          Positioned(
            child: Container(
                color: showAppBarMode ? Colors.white : null,
                width: double.infinity,
                height: 60,
                child: Container(
                  // height: 40,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: "Search for service",
                        border: InputBorder.none),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
