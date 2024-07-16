import 'package:device_preview/device_preview.dart';
import 'package:dineease/model/auth/user.dart';
import 'package:dineease/view/auth/login_screen.dart';
import 'package:dineease/view_model/auth/auth_vm.dart';
import 'package:dineease/view_model/hive_vm.dart';
import 'package:dineease/view_model/profile/our_team_vm.dart';
import 'package:dineease/view_model/profile/privacy_vm.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:dineease/view_model/profile/terms_vm.dart';
import 'package:dineease/view_model/profile/about_us_vm.dart';
import 'package:dineease/view_model/profile/employee_vm.dart';
import 'package:dineease/view_model/restro/banner_vm.dart';
import 'package:dineease/view_model/restro/dashboard_vm.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:dineease/view_model/restro/order_vm.dart';
import 'package:dineease/view_model/restro/payment_vm.dart';
import 'package:dineease/view_model/restro/table_vm.dart';
import 'package:dineease/view_model/password_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  await Hive.initFlutter();
  await Hive.openBox('userBox');

  runApp(
    DevicePreview(
      enabled: true,
      builder: (_) => const DineEase(),
    ),
  );
}

class DineEase extends StatelessWidget {
  const DineEase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AboutUsViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => EmployeeViewModel()),
        ChangeNotifierProvider(create: (_) => HiveViewModel()),
        ChangeNotifierProvider(create: (_) => ItemViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => PrivacyViewModel()),
        ChangeNotifierProvider(create: (_) => ShowPasswordProvider()),
        ChangeNotifierProvider(create: (_) => TACViewModel()),
        ChangeNotifierProvider(create: (_) => TableViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => OurTeamViewModel()),
        ChangeNotifierProvider(create: (_) => BannerViewModel()),
        ChangeNotifierProvider(create: (_) => PaymentViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ],
      child: MaterialApp(
        title: 'Dine Ease',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home:const LoginScreen(),
      ),
    );
  }
}
