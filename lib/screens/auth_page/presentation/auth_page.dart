import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salonapp/common_ui/custom_feild.dart';
import 'package:salonapp/screens/auth_page/cubit/auth_cubit.dart';
import 'package:salonapp/screens/profile/cubit/profile_cubit.dart';
import 'package:salonapp/screens/profile/presentation/edit_profile.dart';
import 'package:salonapp/screens/shell/shell.dart';
import 'package:salonapp/services/cubit_service.dart';
import 'package:salonapp/utils/app_color.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _authCubit = AuthCubit();
  final _mobileNumberController = TextEditingController();

  final _otpController = TextEditingController();
  int currentIndex = 0;
  bool isOtpScreen = false;
  bool isLoading = false;
  final data = [
    {
      "img":
          "https://img.freepik.com/free-photo/woman-getting-treatment-hairdresser-shop_23-2149230937.jpg?t=st=1717690686~exp=1717694286~hmac=fee97294a02b559107cb66b13b943d0b4074316df42f6c0a1dc19ef309e70ee8&w=740",
      'title': 'Look Good, Feel Good',
      'desc':
          'Elevate your confidence by investing in your appearance, unlocking a positive ripple effect on your well-being.'
    },
    {
      'img':
          "https://img.freepik.com/free-photo/woman-getting-treatment-hairdresser-shop_23-2149229777.jpg?t=st=1717691083~exp=1717694683~hmac=d5dd36da45a76744f9fa3663546114915c6fc301b673304afc01ad123be260be&w=740",
      'title': 'Discover Your Style Haven',
      'desc':
          "Embark on a personalized fashion journey with 'Discover Your Style Haven.' Uncover outfits that resonate with your unique taste, making every day a runway for your individuality."
    },
    {
      'img':
          'https://img.freepik.com/free-photo/prepare-hairdresser-makeup-artist-before-party_329181-1949.jpg?t=st=1717691297~exp=1717694897~hmac=3695b250e143fe774b0ad62d59017f03721c066bcd7a5fff7f20ca5f2754dac1&w=740',
      'title': 'Wardrobe Wonders Unleashed',
      'desc':
          "Navigate the world of 'Wardrobe Wonders Unleashed,' where finding your perfect outfits is an adventure. Explore curated styles that mirror your personality and elevate your self-expression."
    }
  ];

  final _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isOtpScreen,
      onPopInvoked: (isPop) {
        if (isOtpScreen) {
          isOtpScreen = false;
          setState(() {});
        }
      },
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              CarouselSlider(
                  carouselController: _carouselController,
                  items: data
                      .map((e) => CachedNetworkImage(
                            imageUrl: e['img']!,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      aspectRatio: 1,
                      height: MediaQuery.of(context).size.height * 0.7)),
              Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        isOtpScreen
                            ? Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        isOtpScreen = false;
                                        setState(() {});
                                      },
                                      child: Icon(Icons.arrow_back_rounded))
                                ],
                              )
                            : SizedBox(),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Icon(
                        //       Icons.brightness_1,
                        //       color: currentIndex == 0
                        //           ? Colors.deepPurple
                        //           : Colors.deepPurple.withOpacity(0.5),
                        //       size: currentIndex == 0 ? 16 : 8,
                        //     ),
                        //     const SizedBox(
                        //       width: 4,
                        //     ),
                        //     Icon(
                        //       Icons.brightness_1,
                        //       color: currentIndex == 1
                        //           ? Colors.deepPurple
                        //           : Colors.deepPurple.withOpacity(0.5),
                        //       size: currentIndex == 1 ? 16 : 8,
                        //     ),
                        //     const SizedBox(
                        //       width: 4,
                        //     ),
                        //     Icon(
                        //       Icons.brightness_1,
                        //       color: currentIndex == 2
                        //           ? Colors.deepPurple
                        //           : Colors.deepPurple.withOpacity(0.5),
                        //       size: currentIndex == 2 ? 16 : 8,
                        //     )
                        //   ],
                        // ),

                        const Text(
                          'Salon App',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          data[currentIndex]['title']!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        isOtpScreen
                            ? OtpTextField(
                                numberOfFields: 5,
                                // borderColor: Color(0xFF512DA8),
                                disabledBorderColor: const Color(0xFFE7E7E7),
                                enabledBorderColor: const Color(0xFFE7E7E7),
                                borderColor: const Color(0xFFE7E7E7),
                                focusedBorderColor: const Color(0xFF4F44FF),
                                // Set to true to show as box or false to show as underlined
                                showFieldAsBox: true,

                                borderWidth: 1.5,
                                fieldWidth:
                                    50.0, // Adjust the width of the field
                                fieldHeight: 50,

                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 12),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                // Runs when every textfield is filled
                                onSubmit: (String verificationCode) {
                                  // Handle the submission of the OTP
                                  // print("OTP Submitted: $verificationCode");
                                  _otpController.text = verificationCode;
                                },
                              )
                            : SizedBox(),

                        isOtpScreen
                            ? SizedBox()
                            : CustomField(
                                controller: _mobileNumberController,
                                inputType: TextInputType.number,
                                lableText: "Mobile Number",
                              ),

                        const SizedBox(
                          height: 32,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!isLoading) {
                              if (_mobileNumberController.text.isEmpty ||
                                  _mobileNumberController.text.length < 10) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        showCloseIcon: true,
                                        backgroundColor: AppColor.dangerButton,
                                        content: Container(
                                          child: Text(
                                            'Please enter valid mobile number',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )));
                                return;
                              }

                              if (isOtpScreen &&
                                  (_otpController.text.isEmpty ||
                                      _otpController.text.length < 5)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        showCloseIcon: true,
                                        backgroundColor: AppColor.dangerButton,
                                        content: Container(
                                          child: Text(
                                            'Please enter valid otp number',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )));
                                return;
                              }
                              isLoading = true;
                              setState(() {});

                              Future.delayed(Duration(seconds: 2), () {
                                if (isOtpScreen) {
                                  _authCubit
                                      .verifyOtp(_mobileNumberController.text,
                                          _otpController.text)
                                      .then((value) => {
                                            if (value)
                                              {
                                                CubitService.profileCubit
                                                    .getProfile()
                                                    .then((value) {
                                                  if (value ==
                                                      'register-profile') {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    EditProfile(
                                                                      isFromRegister:
                                                                          true,
                                                                    )));
                                                  } else {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Shell()));
                                                  }
                                                })
                                              }
                                          });
                                } else {
                                  _authCubit
                                      .login(_mobileNumberController.text)
                                      .then((value) {
                                    isOtpScreen = !isOtpScreen;
                                    isLoading = false;

                                    setState(() {});
                                  });
                                }
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple),
                            child: isLoading
                                ? Center(
                                    child: LoadingAnimationWidget.waveDots(
                                    color: Colors.white,
                                    size: 24,
                                  ))
                                : Text(
                                    isOtpScreen ? 'VERIFY OTP' : 'GET OTP',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
