import 'package:dineease/style/components/dialogs.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/restro/table_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TableViewModel>(context, listen: false).fetchTables();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tableVM = Provider.of<TableViewModel>(context);
    final tables = tableVM.tables;

    final tableNoController = TextEditingController();
    final seatsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tables",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tables.length,
          itemBuilder: (context, index) {
            final table = tables[index];
            return GestureDetector(
              onTap: () {
                tableNoController.text = table.number;
                seatsController.text = table.seats;
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: tableNoController,
                            style: MyTextStyle.body,
                            decoration: InputDecoration(
                              hintText: 'Table Number',
                              errorStyle: MyTextStyle.thin,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: seatsController,
                            style: MyTextStyle.body,
                            decoration: InputDecoration(
                              hintText: 'No. of Seats',
                              errorStyle: MyTextStyle.thin,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
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
                                    borderRadius: BorderRadius.circular(10),
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
                                  tableVM.editTable(
                                    table.id.toString(),
                                    tableNoController.text,
                                    seatsController.text,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
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
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.table_chart_rounded,
                        size: 45,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Table Number: ${table.number}",
                              style: MyTextStyle.body,
                            ),
                            Text(
                              'No. of Seats: ${table.seats}',
                              style: MyTextStyle.subtitle,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: AppConstants.widthPadding),
                      GestureDetector(
                        onTap: () {
                          AppDialogs.showMyDialog(
                            'Are you sure you want to delete this table?',
                            context,
                            () {
                              tableVM.deleteTable(table.id.toString());
                            },
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          tableNoController.clear();
          seatsController.clear();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: tableNoController,
                      style: MyTextStyle.body,
                      decoration: InputDecoration(
                        hintText: 'Table Number',
                        errorStyle: MyTextStyle.thin,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: seatsController,
                      style: MyTextStyle.body,
                      decoration: InputDecoration(
                        hintText: 'No. of Seats',
                        errorStyle: MyTextStyle.thin,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                              borderRadius: BorderRadius.circular(10),
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
                            tableVM.addTable(
                              tableNoController.text,
                              seatsController.text,
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
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
              ),
            ),
          );
        },
        icon: const Icon(Icons.table_bar),
        label: const Text(
          'Add Table',
          style: MyTextStyle.body,
        ),
      ),
    );
  }
}
