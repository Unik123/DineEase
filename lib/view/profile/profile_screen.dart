import 'package:dineease/model/profile/profile.dart';
import 'package:dineease/style/components/dialogs.dart';
import 'package:dineease/style/components/list_tile.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/view/auth/login_screen.dart';
import 'package:dineease/view/profile/edit_profile_screen.dart';
import 'package:dineease/view/profile/payment/payment_screen.dart';
import 'package:dineease/view/profile/dashboard/dashboard_screen.dart';
import 'package:dineease/view/profile/about_us/about_us_screen.dart';
import 'package:dineease/view/profile/menu/menu_screen.dart';
import 'package:dineease/view/profile/our_team/our_team_screen.dart';
import 'package:dineease/view/profile/employee/employee_screen.dart';
import 'package:dineease/view/profile/policy/tab_bar_screen.dart';
import 'package:dineease/view/profile/table/table_screen.dart';
import 'package:dineease/view_model/auth/auth_vm.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/constants.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    final Profile user = profileVM.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 39,
                    backgroundImage: NetworkImage(
                      user.profilePic ??
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWUem1ykMgZrm7P2GNRhID1fnipTWf1kQ1dA&s",
                    ),
                  ),
                  const SizedBox(width: AppConstants.widthPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user.firstName!} ${user.lastName}",
                          style: MyTextStyle.body.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          user.email!,
                          style: MyTextStyle.thin,
                        ),
                        Text(
                          user.address!,
                          style: MyTextStyle.thin,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfileScreen(user: user),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.bannerPadding * 3),
              const Text(
                "Settings",
                style: MyTextStyle.title,
              ),
              const SizedBox(height: AppConstants.bannerPadding * 1.1),
              if (user.role == 'admin')
                DefaultListTile(
                  title: 'Dashboard',
                  subtitle: 'View your dashboard',
                  icon: Icons.dashboard_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardScreen(),
                      ),
                    );
                  },
                ),
              if (user.role == 'admin' || user.role == 'cashier')
                DefaultListTile(
                  title: 'Payment',
                  subtitle: 'View your payment history',
                  icon: Icons.payment_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PaymentScreen(),
                      ),
                    );
                  },
                ),
              if (user.role == 'admin')
                DefaultListTile(
                  title: 'Employee',
                  subtitle: 'Manage your employees',
                  icon: Icons.people,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EmployeeScreen(),
                      ),
                    );
                  },
                ),
              if (user.role == 'admin')
                DefaultListTile(
                  title: 'Menu',
                  subtitle: 'Manage your menu items',
                  icon: Icons.chrome_reader_mode_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MenuScreen(),
                      ),
                    );
                  },
                ),
              if (user.role == 'admin')
                DefaultListTile(
                  title: 'Table & Space',
                  subtitle: 'Manage your tables and spaces',
                  icon: Icons.table_restaurant,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TableScreen(),
                      ),
                    );
                  },
                ),
              DefaultListTile(
                title: 'About Us',
                subtitle: 'Know more about us',
                icon: Icons.info_outline,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()));
                },
              ),
              DefaultListTile(
                title: 'Our Team',
                subtitle: 'Meet our team',
                icon: Icons.theater_comedy,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OurTeam(),
                    ),
                  );
                },
              ),
              DefaultListTile(
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                icon: Icons.star_purple500_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TabBarScreen(),
                    ),
                  );
                },
              ),
              DefaultListTile(
                title: 'Log Out',
                subtitle: 'Logout from the app',
                icon: Icons.logout,
                onTap: () {
                  AppDialogs.showMyDialog(
                    'Are you sure you want to logout?',
                    context,
                    () async {
                      await authVM.logout(context);
                      Navigator.pop(context);
                      authVM.isLoading
                          ? const CircularProgressIndicator()
                          : MySnackBar.showSnackBar(
                              context,
                              "Logged Out Successfully",
                            );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}