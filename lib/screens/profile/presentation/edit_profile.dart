import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salonapp/common_ui/custom_feild.dart';
import 'package:salonapp/screens/profile/cubit/profile_cubit.dart';
import 'package:salonapp/screens/shell/shell.dart';
import 'package:salonapp/services/cubit_service.dart';
import 'package:salonapp/utils/app_color.dart';

class EditProfile extends StatefulWidget {
  final bool isFromRegister;
  const EditProfile({super.key, this.isFromRegister = false});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _dobController = TextEditingController();

  final _genderController = TextEditingController();
  List<String> genders = ['Male', 'Female', 'Other'];

  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    isEdit = widget.isFromRegister;

    if (!widget.isFromRegister) {
      CubitService.profileCubit.getProfile().then((value) {
        // _firstNameController.text = "Pravin";
        // _lastNameController.text = "Choudhary";
        // _dobController.text = "23-08-2000";
        // _mobileNumberController.text = "7738814494";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: true
          ? AppBar(
              leading: GestureDetector(
                  onTap: () {
                    if (widget.isFromRegister) {
                      print("fefdfd");
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child:
                      GestureDetector(child: Icon(Icons.arrow_back_rounded))),
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                widget.isFromRegister ? 'Create Profile' : 'My Profile',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(55),
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: const Offset(
                          0,
                          2.0,
                        ),
                      ), //BoxShadow
                      //BoxShadow
                    ],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_rounded)),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        'My Profile',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      !isEdit
                          ? GestureDetector(
                              onTap: () {
                                isEdit = true;

                                setState(() {});
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primaryButton),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              )),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        bloc: CubitService.profileCubit,
        listener: (context, state) {
          if (state is ProfileInLoadedState) {
            _firstNameController.text = state.user.firstName;
            _lastNameController.text = state.user.lastName;
            _dobController.text = state.user.dob;
            _genderController.text = state.user.gender;
            // _mobileNumberController.text = "7738814494";
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: AppColor.primaryButton.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _firstNameController.text.isNotEmpty
                                  ? _firstNameController.text
                                      .substring(0, 1)
                                      .toUpperCase()
                                  : "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        !isEdit
                            ? GestureDetector(
                                onTap: () {
                                  isEdit = true;

                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFF0F0F0)),
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                              //   child: Text(
                              //     "First name",
                              //     style: TextStyle(
                              //         fontSize: 16, fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                              SizedBox(height: 24),
                              CustomField(
                                onChanged: (value) {
                                  setState(() {});
                                },
                                enabled: isEdit,
                                controller: _firstNameController,
                                lableText: "First name",
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                              //   child: Text(
                              //     "Last name",
                              //     style: TextStyle(
                              //         fontSize: 16, fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                              SizedBox(height: 24),
                              CustomField(
                                enabled: isEdit,
                                controller: _lastNameController,
                                lableText: "Last name",
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                              //   child: Text(
                              //     "Mobile number",
                              //     style: TextStyle(
                              //         fontSize: 16, fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                              // SizedBox(height: 24),
                              // CustomField(
                              //   enabled: isEdit,
                              //   controller: _mobileNumberController,
                              //   lableText: "Mobile number",
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                              //   child: Text(
                              //     "Date of Birth",
                              //     style: TextStyle(
                              //         fontSize: 16, fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                              SizedBox(height: 24),
                              GestureDetector(
                                onTap: () {
                                  if (isEdit) {
                                    showDateSheet();
                                  }
                                },
                                child: CustomField(
                                  enabled: false,
                                  controller: _dobController,
                                  lableText: "Date of Birth",
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                              //   child: Text(
                              //     "Gender",
                              //     style: TextStyle(
                              //         fontSize: 16, fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                              SizedBox(height: 24),
                              GestureDetector(
                                onTap: () {
                                  if (isEdit) {
                                    _showGenderPicker();
                                  }
                                },
                                child: CustomField(
                                  enabled: false,
                                  controller: _genderController,
                                  lableText: "Gender",
                                ),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              isEdit
                  ? Positioned(
                      bottom: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey.withOpacity(0.15)))),
                        child: GestureDetector(
                          onTap: () {
                            if (!isLoading) {
                              isLoading = true;
                              setState(() {});
                              if (_firstNameController.text.isEmpty) {
                                showToast(
                                    "Please enter your first name", false);
                                isLoading = false;
                                setState(() {});
                                return;
                              }
                              if (_lastNameController.text.isEmpty) {
                                showToast("Please enter your last name", false);
                                isLoading = false;
                                setState(() {});
                                return;
                              }
                              if (_dobController.text.isEmpty) {
                                showToast(
                                    "Please select your date of birth", false);
                                isLoading = false;
                                setState(() {});
                                return;
                              }
                              if (_genderController.text.isEmpty) {
                                showToast("Please select your gender", false);
                                isLoading = false;
                                setState(() {});
                                return;
                              }
                              if (_firstNameController.text.isNotEmpty &&
                                  _lastNameController.text.isNotEmpty &&
                                  _dobController.text.isNotEmpty &&
                                  _genderController.text.isNotEmpty) {
                                Future.delayed(Duration(seconds: 0), () {
                                  CubitService.profileCubit
                                      .updateProfile(
                                          _firstNameController.text,
                                          _lastNameController.text,
                                          _dobController.text,
                                          _genderController.text.toLowerCase())
                                      .then((value) {
                                    if (value) {
                                      if (widget.isFromRegister) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => Shell()));
                                      } else {
                                        Navigator.pop(context);
                                      }

                                      isEdit = false;

                                      isLoading = false;
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              showCloseIcon: true,
                                              backgroundColor:
                                                  AppColor.successButton,
                                              content: Container(
                                                child: Text(
                                                  widget.isFromRegister
                                                      ? 'Profile created successfully.'
                                                      : 'Profile updated successfully.',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )));
                                    }
                                  });
                                });
                              } else {
                                isLoading = false;
                                setState(() {});
                              }
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
                                    widget.isFromRegister
                                        ? 'Create Profile'
                                        : 'Save',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                          ),
                        ),
                      ))
                  : SizedBox()
            ],
          );
        },
      ),
    );
  }

  showToast(String msg, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        showCloseIcon: true,
        backgroundColor:
            isSuccess ? AppColor.successButton : AppColor.dangerButton,
        content: Container(
          child: Text(
            msg,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        )));
  }

  _showGenderPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // selectedIndex = index;
                        // selectedGender = genders[index];

                        _genderController.text =
                            _genderController.text.isNotEmpty
                                ? _genderController.text
                                : genders[0];
                      });

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(
                height: 150,
                color: Colors.white,
                child: CupertinoPicker(
                  itemExtent: 46.0,
                  backgroundColor: Colors.white,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      // selectedIndex = index;
                      // selectedGender = genders[index];

                      _genderController.text = genders[index];
                    });
                  },
                  children: genders.map((String gender) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(gender),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  showDateSheet() {
    int? day, month, year;

    if (_dobController.text.isNotEmpty) {
      day = int.parse(_dobController.text.split('/')[0]);

      month = int.parse(_dobController.text.split('/')[1]);

      year = int.parse(_dobController.text.split('/')[2]);
    }
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              color: Colors.white,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          try {
                            final newDateTime = DateTime(
                                year ?? DateTime.now().year - 16,
                                month ?? DateTime.now().month,
                                day ?? DateTime.now().day);
                            _dobController.text =
                                '${newDateTime.day.toString().padLeft(2, '0')}/${newDateTime.month.toString().padLeft(2, '0')}/${newDateTime.year}';
                            print(_dobController.text);
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      maximumYear: DateTime.now().year - 16,
                      minimumDate: DateTime(DateTime.now().year - 100,
                          DateTime.now().month, DateTime.now().day),
                      maximumDate: DateTime(DateTime.now().year - 16,
                          DateTime.now().month, DateTime.now().day),
                      initialDateTime: DateTime(
                          year ?? DateTime.now().year - 16,
                          month ?? DateTime.now().month,
                          day ?? DateTime.now().day),
                      onDateTimeChanged: (DateTime newDateTime) {
                        // Do something

                        print(newDateTime);

                        _dobController.text =
                            '${newDateTime.day.toString().padLeft(2, '0')}/${newDateTime.month.toString().padLeft(2, '0')}/${newDateTime.year}';
                      },
                    ),
                  )
                ],
              ));
        });
  }
}
