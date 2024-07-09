import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonapp/common_cubit/cubit/user_detail_cubit.dart';
import 'package:salonapp/screens/address/cubit/address_cubit.dart';
import 'package:salonapp/screens/auth_page/presentation/auth_page.dart';
import 'package:salonapp/screens/cart/cubit/cart_cubit.dart';
import 'package:salonapp/screens/profile/cubit/profile_cubit.dart';
import 'package:salonapp/screens/profile/presentation/profile.dart';
import 'package:salonapp/screens/shell/shell.dart';
import 'package:salonapp/screens/store/cubit/store_data_cubit.dart';
import 'package:salonapp/services/shared_preference_service.dart';
import 'package:salonapp/services/user_detail.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  @override
  void initState() {
    isLoggedIn = SharedPreferenceService.getBool('isLoggedIn');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddressCubit(),
        ),
        BlocProvider(
          create: (context) => StoreDataCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => UserDetailCubit(),
        )
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Salon App',
        theme: ThemeData(),
        home: isLoggedIn ? Shell() : OnBoardingScreen(),
      ),
    );
  }
}

void updateValueGlobally(UserDetail newValue) {
  final context = navigatorKey.currentContext!;
  context.read<UserDetailCubit>().updateValue(newValue);
}
