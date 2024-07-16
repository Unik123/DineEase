import 'package:dineease/model/profile/profile.dart';
import 'package:dineease/style/components/cards.dart';
import 'package:dineease/style/header/section_header.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view/home/item_detail_screen.dart';
import 'package:dineease/view/widgets/banner.dart';
import 'package:dineease/view/widgets/no_data_widget.dart';
import 'package:dineease/view_model/profile/about_us_vm.dart';
import 'package:dineease/view_model/profile/employee_vm.dart';
import 'package:dineease/view_model/profile/our_team_vm.dart';
import 'package:dineease/view_model/profile/privacy_vm.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:dineease/view_model/restro/banner_vm.dart';
import 'package:dineease/view_model/restro/dashboard_vm.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:dineease/view_model/restro/order_vm.dart';
import 'package:dineease/view_model/restro/payment_vm.dart';
import 'package:dineease/view_model/restro/table_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemViewModel>(context, listen: false).fetchItems();
      Provider.of<EmployeeViewModel>(context, listen: false).fetchEmployee();
      Provider.of<PrivacyViewModel>(context, listen: false).fetchItems();
      Provider.of<TableViewModel>(context, listen: false).fetchTables();
      Provider.of<BannerViewModel>(context, listen: false).fetchBanners();
      Provider.of<AboutUsViewModel>(context, listen: false).fetchInfo();
      Provider.of<OrderViewModel>(context, listen: false).fetchOrders();
      Provider.of<ProfileViewModel>(context, listen: false).fetchProfile();
      Provider.of<OurTeamViewModel>(context, listen: false).fetchTeams();
      Provider.of<PaymentViewModel>(context, listen: false).fetchPayments();
      Provider.of<DashboardViewModel>(context, listen: false).fetchDashboardData();
    });

    searchController.addListener(() {
      setState(() {
        isSearchMode = searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsVM = Provider.of<ItemViewModel>(context);
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);

    final Profile user = profileVM.user;
    final items = itemsVM.items;

    final filteredItems = items
        .where((element) =>
            (selectedDepartment == null ||
                element.department == selectedDepartment) &&
            element.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
        .toList();

    final department = [
      {
        'icon': Icons.food_bank,
        'label': 'food',
      },
      {
        'icon': Icons.local_drink,
        'label': 'drink',
      },
      {
        'icon': Icons.local_bar,
        'label': 'bar',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back,",
              style: MyTextStyle.subtitle,
            ),
            Text(
              '${user.firstName ?? 'Dine'} ${user.lastName ?? 'Ease'}',
              style: MyTextStyle.title,
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.screenPadding),
            child: DateTime.now().hour < 18
                ? const Icon(Icons.sunny)
                : const Icon(Icons.nightlight_round),
          )
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstants.spaceHeight),

              //!               Search Bar
              TextFormField(
                controller: searchController,
                keyboardType: TextInputType.text,
                style: MyTextStyle.body,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: AppConstants.bannerPadding),
                  hintText: "Search Here",
                  hintStyle: MyTextStyle.subtitle,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spaceHeight * 1.5),

              //!               Banner
              const MyBanner(),
              //!               Department
              const SizedBox(height: AppConstants.spaceHeight * 1.5),
              const SectionHeader(title: "Department"),
              const SizedBox(height: AppConstants.spaceHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: department.map((dept) {
                  final isSelected = selectedDepartment == dept['label'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDepartment =
                            isSelected ? null : dept['label'] as String?;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            dept['icon'] as IconData,
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.grey,
                            size: 45,
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            (dept['label'] as String).toUpperCase(),
                            style: isSelected
                                ? MyTextStyle.body
                                    .copyWith(color: AppColors.primaryColor)
                                : MyTextStyle.body,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppConstants.spaceHeight),

              const SectionHeader(title: "Items"),
              if ((selectedDepartment != null
                  ? selectedDepartment!.isNotEmpty
                  : false))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Department:    ${selectedDepartment!.toUpperCase()}',
                      style: MyTextStyle.body
                          .copyWith(color: AppColors.secondaryColor),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedDepartment = null;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),

              if ((isSearchMode && filteredItems.isEmpty) ||
                  ((selectedDepartment != null
                          ? selectedDepartment!.isNotEmpty
                          : false) &&
                      filteredItems.isEmpty))
                const NoData(
                  title: 'No Result',
                  subtitle: "No food item found",
                  icon: Icons.search_off,
                ),

              if ((items.isEmpty && filteredItems.isEmpty))
                const NoData(
                  title: 'No Food',
                  subtitle: "There's no food item",
                  icon: Icons.ramen_dining_outlined,
                ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailScreen(item: item),
                        ),
                      );
                    },
                    child: MyCards.productContainer(
                      item.name,
                      item.department,
                      'Rs ${item.price}',
                      item.image,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppConstants.spaceHeight),

              const SizedBox(height: AppConstants.spaceHeight),
              Container(
                height: 300,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://us.123rf.com/450wm/svetlanakutsin/svetlanakutsin1905/svetlanakutsin190500035/122759598-healthy-food-lettering-for-banner-design-organic-nutrition-eco-product-vector.jpg'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
