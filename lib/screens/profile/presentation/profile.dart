import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonapp/common_cubit/cubit/user_detail_cubit.dart';
import 'package:salonapp/screens/auth_page/presentation/auth_page.dart';
import 'package:salonapp/screens/profile/cubit/profile_cubit.dart';
import 'package:salonapp/screens/profile/presentation/edit_profile.dart';
import 'package:salonapp/screens/profile/model/menu.dart';
import 'package:salonapp/services/cubit_service.dart';
import 'package:salonapp/services/shared_preference_service.dart';
import 'package:salonapp/services/user_detail.dart';
import 'package:salonapp/utils/app_color.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Menu> menuList = [
    Menu(
        icon: Icon(
          Icons.help_outline_outlined,
          color: Colors.black45,
          size: 20,
        ),
        title: 'Help',
        id: 'help'),
    Menu(
        icon: Icon(
          Icons.file_copy_outlined,
          color: Colors.black45,
          size: 20,
        ),
        title: 'Privacy Policy',
        id: 'privacy-policy'),
    Menu(
        icon: Icon(
          Icons.info_outlined,
          color: Colors.black45,
          size: 20,
        ),
        title: 'About',
        id: 'privacy-policy'),
    Menu(
        icon: Icon(
          Icons.logout_outlined,
          size: 20,
          color: Colors.black45,
        ),
        title: 'Logout',
        id: 'logout')
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              color: AppColor.primaryButton.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/panda.png"),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    // height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<ProfileCubit, ProfileState>(
                          bloc: CubitService.profileCubit,
                          builder: (context, state) {
                            return Text(
                              state is ProfileInLoadedState
                                  ? "${state.user.firstName} ${state.user.lastName}"
                                  : "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfile()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              'My Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColor.primaryButton.withOpacity(0.6),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                  radius: 26,
                                  // backgroundColor: Color(0xFFF0F0F0),
                                  backgroundColor:
                                      AppColor.primaryButton.withOpacity(0.7),
                                  child: Icon(
                                    Icons.history,
                                    color: Colors.white,
                                    size: 26,
                                  )),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Bookings',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                  radius: 26,
                                  // backgroundColor: Color(0xFFF0F0F0),
                                  backgroundColor:
                                      AppColor.primaryButton.withOpacity(0.7),
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 26,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Address',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                  radius: 26,
                                  // backgroundColor: Color(0xFFF0F0F0),
                                  backgroundColor:
                                      AppColor.primaryButton.withOpacity(0.7),
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.white,
                                    size: 26,
                                  )),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Cart',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    ...List.generate(
                        menuList.length,
                        (index) => GestureDetector(
                              onTap: () {
                                if (menuList[index].id == "logout") {
                                  SharedPreferenceService.setBool(
                                      'isLoggedIn', false);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OnBoardingScreen()));
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            menuList[index].icon,
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              menuList[index].title,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: Colors.black45,
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                    height: 16,
                                  ),
                                ],
                              ),
                            ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
