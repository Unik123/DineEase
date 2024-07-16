import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/profile/employee_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeViewModel>(context, listen: false).fetchEmployee();
    });
  }

  @override
  Widget build(BuildContext context) {
    final employeeVM = Provider.of<EmployeeViewModel>(context);
    final employees = employeeVM.employees;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Employees",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
        child: RefreshIndicator(
          onRefresh: () async {
            await employeeVM.fetchEmployee();
          },
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return InkWell(
                onTap: () {
                  String? selectedDepartment = employee.role;
                  bool? isActive = employee.isActive;

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                    height: AppConstants.verticalpadding),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    employee.profilePic ??
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWUem1ykMgZrm7P2GNRhID1fnipTWf1kQ1dA&s",
                                  ),
                                ),
                                const SizedBox(
                                    height: AppConstants.verticalpadding * 3),
                                Text(
                                  "${employee.firstName!} ${employee.lastName!}",
                                  maxLines: 1,
                                  style:
                                      MyTextStyle.body.copyWith(fontSize: 15),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  employee.username!,
                                  maxLines: 1,
                                  style:
                                      MyTextStyle.thin.copyWith(fontSize: 12),
                                ),
                                const SizedBox(
                                    height: AppConstants.verticalpadding * 5),
                                DropdownButtonHideUnderline(
                                  child: Container(
                                    height: 40,
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedDepartment,
                                      icon: const Icon(Icons.arrow_drop_down,
                                          color: Colors.black),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedDepartment = newValue;
                                        });
                                      },
                                      dropdownColor: Colors.white,
                                      items: <String>[
                                        'waiter',
                                        'cashier',
                                        'cook',
                                        'admin',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: MyTextStyle.subtitle
                                                .copyWith(fontSize: 13),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height: AppConstants.verticalpadding * 2.5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 95,
                                      child: Text(
                                        "Joined Date",
                                        style: MyTextStyle.subtitle
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": ${employee.dateJoined!.toString().substring(0, 10)}",
                                        style: MyTextStyle.thin
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height: AppConstants.verticalpadding * 2),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 95,
                                      child: Text(
                                        "Contact No",
                                        style: MyTextStyle.subtitle
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": ${employee.contact ?? 'N/A'}",
                                        style: MyTextStyle.thin
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height: AppConstants.verticalpadding * 2),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 95,
                                      child: Text(
                                        "Is active",
                                        style: MyTextStyle.subtitle
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      ':',
                                      style: MyTextStyle.thin
                                          .copyWith(fontSize: 12),
                                    ),
                                    Checkbox(
                                      value: isActive,
                                      onChanged: (value) {
                                        setState(() {
                                          isActive = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height: AppConstants.verticalpadding * 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Poppins-Medium',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      onTap: () {
                                        if (selectedDepartment !=
                                            employee.role || isActive != employee.isActive) {
                                          employeeVM.changeRole(
                                            employee.id!.toString(),
                                            selectedDepartment!,
                                            isActive!,
                                          );
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Poppins-Medium',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.horizontalpadding),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(employee.profilePic ??
                                "https://image.winudf.com/v2/image/Y29tLmJhbGVmb290Lk1vbmtleURMdWZmeVdhbGxwYXBlcl9zY3JlZW5fMF8xNTI0NTE5MTEwXzAyOA/screen-0.webp?h=200&fakeurl=1&type=.webp"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(
                          width: AppConstants.horizontalpadding * 1.5),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${employee.firstName} ${employee.lastName}",
                              maxLines: 1,
                              style: MyTextStyle.body.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              'Role: ${employee.role ?? 'N/A'}',
                              maxLines: 1,
                              style: MyTextStyle.caption,
                            ),
                            Text(
                              'Contact: ${employee.contact ?? 'N/A'}',
                              maxLines: 1,
                              style: MyTextStyle.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
