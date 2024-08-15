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

  List<String> bannersList = [
    'assets/banner_image.png',
    'assets/banner_image.png',
  ];

  List<Color> bannerBgColorList = [
    Color(0xFF77401C),
    Color(0xFF1A1D42),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                        hintText: "Search for beauty services",
                        border: InputBorder.none),
                  ),
                )),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      itemCount: bannersList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final banner = bannersList[index];
                        return Container(
                          margin: EdgeInsets.only(
                              right: 16, left: index == 0 ? 16 : 0),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                width: MediaQuery.of(context).size.width * 0.85,
                                decoration: BoxDecoration(
                                    color: bannerBgColorList[index],
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 120,
                                  // width: 100,
                                  child: Image.asset(
                                    banner,
                                    // width: 60,
                                    height: 60,
                                    fit: BoxFit.fitHeight,
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                width: 190,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pamper Your\nHands & Feet',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Meni-Pedi',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Book Now',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Our services',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 140 * ((11 / 3) + 1),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 148,
                        crossAxisCount: 3, // 3 images per row
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: 11,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          // width: 100,

                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  'assets/service.png',
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                width: 70,
                                child: Text(
                                  'Hair Treatment',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 10,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Most Booked Services',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 180,
                          margin: EdgeInsets.only(
                              right: 12, left: index == 0 ? 16 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 180,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/service.png',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Complete Rica (White Chocolate) Waxing',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          size: 14,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          '45 min',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\u{20B9}999',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          '\u{20B9}2457',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.black54,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 10,
                  ),
                  SizedBox(
                    height: 100,
                  ),

                  // BlocBuilder<HomeServiceCubit, HomeServiceState>(
                  //     bloc: _homeServiceCubit,
                  //     builder: (context, state) {
                  //       switch (state.runtimeType) {
                  //         case HomeServiceDataFetched:
                  //           final successState =
                  //               state as HomeServiceDataFetched;
                  //           return successState.trending.isNotEmpty
                  //               ? HorizontalProductserviceCardSection(
                  //                   headerText: 'Trending Services',
                  //                   data: successState.trending,
                  //                 )
                  //               : SizedBox();
                  //         default:
                  //           return SizedBox();
                  //       }
                  //     }),
                  // SizedBox(
                  //   height: 12,
                  // ),
                  // BlocBuilder<HomeServiceCubit, HomeServiceState>(
                  //     bloc: _homeServiceCubit,
                  //     builder: (context, state) {
                  //       switch (state.runtimeType) {
                  //         case HomeServiceDataFetched:
                  //           final successState =
                  //               state as HomeServiceDataFetched;
                  //           return successState.popular.isNotEmpty
                  //               ? HorizontalProductserviceCardSection(
                  //                   headerText: 'Popular Services',
                  //                   data: successState.popular,
                  //                 )
                  //               : SizedBox();
                  //         default:
                  //           return SizedBox();
                  //       }
                  //     }),
                  // SizedBox(
                  //   height: 42,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 16,
                  //   ),
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //         height: 250,
                  //         width: double.infinity,
                  //         child: BackgroundVideoPlayer(
                  //             videoUrl:
                  //                 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
                  //       ),
                  //       Container(
                  //         height: 250,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             // color: Colors.black45.withOpacity(0.35),
                  //             gradient: LinearGradient(
                  //                 begin: Alignment.topLeft,
                  //                 colors: [
                  //                   Colors.black.withOpacity(0.78),
                  //                   Colors.black.withOpacity(0)
                  //                 ])),
                  //         width: double.infinity,
                  //         padding: const EdgeInsets.all(16.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             const Text(
                  //               'LED PHOTO FACIAL',
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //             const SizedBox(
                  //               height: 16,
                  //             ),
                  //             const Text(
                  //               "Illuminate Your\nSkin's Natural\nLuminosty",
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 20,
                  //                   fontWeight: FontWeight.w600),
                  //             ),
                  //             const Spacer(),
                  //             Container(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 16, vertical: 6),
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(8)),
                  //               child: const Text(
                  //                 'Explore',
                  //                 style: TextStyle(
                  //                     fontSize: 12,
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 12,
                  // ),
                  // BlocBuilder<HomeServiceCubit, HomeServiceState>(
                  //     bloc: _homeServiceCubit,
                  //     builder: (context, state) {
                  //       switch (state.runtimeType) {
                  //         case HomeServiceDataFetched:
                  //           final successState =
                  //               state as HomeServiceDataFetched;
                  //           return successState.recommended.isNotEmpty
                  //               ? HorizontalProductserviceCardSection(
                  //                   headerText: 'Recommended Services',
                  //                   data: successState.recommended,
                  //                 )
                  //               : SizedBox();
                  //         default:
                  //           return SizedBox();
                  //       }
                  //     }),
                  // SizedBox(
                  //   height: 32,
                  // ),
                  // CachedNetworkImage(
                  //   width: double.infinity,
                  //   height: 180,
                  //   imageUrl:
                  //       'https://marketplace.canva.com/EAE-huAz88k/1/0/1600w/canva-modern-green-fashion-sale-%28banner-%28landscape%29%29-Ye_HTOWPMMQ.jpg',
                  //   fit: BoxFit.cover,
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
