import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salonapp/screens/booking/booking.dart';
import 'package:salonapp/screens/home/home.dart';
import 'package:salonapp/screens/profile/cubit/profile_cubit.dart';
import 'package:salonapp/screens/profile/presentation/profile.dart';
import 'package:salonapp/screens/search/search.dart';
import 'package:salonapp/screens/shell/model/bottom_app_bar_icons.dart';
import 'package:salonapp/screens/store/store.dart';
import 'package:salonapp/services/cubit_service.dart';
import 'package:salonapp/utils/app_color.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int tabIndex = 0;
  final PageController _pageController = PageController(keepPage: true);
  List<BottomAppBarIcons> iconList = [
    BottomAppBarIcons(Icons.home, "Home"),
    BottomAppBarIcons(Icons.search, "Search"),
    BottomAppBarIcons(Icons.store, "Store"),
    BottomAppBarIcons(Icons.history, "History"),
    BottomAppBarIcons(Icons.person, "Person"),
  ];

  @override
  void initState() {
    super.initState();
     CubitService.profileCubit.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: tabIndex == 3
      //     ? null
      //     : PreferredSize(
      //         preferredSize: const Size.fromHeight(55),
      //         child: SafeArea(
      //           child: Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 12),
      //             height: 60,
      //             decoration: BoxDecoration(
      //               color: Colors.white,
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.grey.withOpacity(0.1),
      //                   offset: const Offset(
      //                     0,
      //                     2.0,
      //                   ),
      //                 ), //BoxShadow
      //                 //BoxShadow
      //               ],
      //             ),
      //             child: Row(
      //               children: [
      //                 CachedNetworkImage(
      //                   height: 40,
      //                   width: 40,
      //                   imageUrl:
      //                       'https://logowik.com/content/uploads/images/hair-salon5704.logowik.com.webp',
      //                   fit: BoxFit.cover,
      //                 ),
      //                 const SizedBox(
      //                   width: 4,
      //                 ),
      //                 const Text(
      //                   'Salon App',
      //                   style: TextStyle(
      //                       fontSize: 20, fontWeight: FontWeight.bold),
      //                 ),
      //                 Spacer(),
      //                 Icon(
      //                   Icons.search,
      //                 )
      //               ],
      //             ),
      //           ),
      //         )),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const Home(),
            const Search(),
            const Store(),
            const Booking(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          height: 60,
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            // height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                iconList.length,
                (index) => GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(index);
                    tabIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.white,
                    // width: (MediaQuery.of(context).size.width - 32) / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconList[index].icon,
                          size: 28,
                          color: tabIndex == index
                              ? const Color(0xff0F0F0F)
                              : const Color(0xff0F0F0F).withOpacity(0.5),
                        ),
                        Text(
                          iconList[index].label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: tabIndex == index
                                ? const Color(0xff0F0F0F)
                                : const Color(0xff0F0F0F).withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
