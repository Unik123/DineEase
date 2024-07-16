import 'package:dineease/view_model/restro/table_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dineease/model/restro/item.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:dineease/view_model/restro/order_vm.dart';

class TakeOrderScreen extends StatefulWidget {
  final String tableId;
  final String tableNumber;

  const TakeOrderScreen({
    super.key,
    required this.tableId,
    required this.tableNumber,
  });

  @override
  _TakeOrderScreenState createState() => _TakeOrderScreenState();
}

class _TakeOrderScreenState extends State<TakeOrderScreen> {
  List<String> restaurantItems = [];
  List<String> filteredItems = [];
  Map<Item, int> selectedItems = {};
  bool showFilteredItems = false;

  final TextEditingController itemnameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemVM = Provider.of<ItemViewModel>(context, listen: false);
      itemVM.fetchItems().then((_) {
        setState(() {
          restaurantItems = itemVM.items.map((e) => e.name).toList();
        });
      });
    });
  }

  void filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        showFilteredItems = false;
      } else {
        showFilteredItems = true;
        filteredItems = restaurantItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderVM = Provider.of<OrderViewModel>(context);
    final itemVM = Provider.of<ItemViewModel>(context);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Take Order",
          style: MyTextStyle.title,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.widthPadding * 1.3),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: screenWidth * 0.2,
                height: screenHeight * 0.04,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor),
                child: Center(
                  child: Text(
                    "Cancel",
                    style: MyTextStyle.body.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.widthPadding * 1.3),
            child: Column(
              children: [
                const SizedBox(height: AppConstants.spaceHeight),
                Row(
                  children: [
                    const Icon(
                      Icons.table_chart_rounded,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Table Number: ${widget.tableNumber}",
                      style: MyTextStyle.body,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spaceHeight),
                SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.06,
                  child: TextFormField(
                    onChanged: (value) {
                      filterItems(value);
                    },
                    style: MyTextStyle.body,
                    controller: itemnameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Enter Items',
                      hintStyle: MyTextStyle.subtitle,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spaceHeight * 1.3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.54,
                      height: screenHeight * 0.06,
                      child: TextFormField(
                        controller: quantityController,
                        style: MyTextStyle.body,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Quantity',
                          hintStyle: MyTextStyle.subtitle,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          String itemName = itemnameController.text;
                          int quantity =
                              int.tryParse(quantityController.text) ?? 0;

                          if (!restaurantItems.contains(itemName)) {
                            MySnackBar.showSnackBar(
                                context, "Invalid Item Name");
                          } else if (itemName.isNotEmpty && quantity > 0) {
                            final myItem = itemVM.items.firstWhere(
                                (element) => element.name == itemName);
                            if (selectedItems.containsKey(myItem)) {
                              selectedItems[myItem] =
                                  selectedItems[myItem]! + quantity;
                            } else {
                              selectedItems[myItem] = quantity;
                            }
                            itemnameController.clear();
                            quantityController.clear();
                          }
                        });
                      },
                      child: Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Add',
                            style:
                                MyTextStyle.body.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spaceHeight * 2),
                Divider(),
                if (selectedItems.isEmpty)
                  Text(
                    "No Items Added",
                    style: MyTextStyle.body.copyWith(fontSize: 20),
                  ),
                if (selectedItems.isNotEmpty)
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "SN",
                          style: MyTextStyle.subtitle.copyWith(
                              fontSize: 14, color: AppColors.BillyColor),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Particular",
                          style: MyTextStyle.subtitle.copyWith(
                              fontSize: 14, color: AppColors.BillyColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "QTY",
                          style: MyTextStyle.subtitle.copyWith(
                              fontSize: 14, color: AppColors.BillyColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Cancel",
                          style: MyTextStyle.subtitle.copyWith(
                              fontSize: 14, color: AppColors.BillyColor),
                        ),
                      ),
                    ],
                  ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      final item = selectedItems.keys.elementAt(index);
                      final quantity = selectedItems[item]!;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              (index + 1).toString(),
                              style: MyTextStyle.subtitle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              item.name,
                              style: MyTextStyle.subtitle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              quantity.toString(),
                              style: MyTextStyle.subtitle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete,
                                  color: AppColors.primaryColor),
                              onPressed: () {
                                setState(() {
                                  selectedItems.remove(item);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.056,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () async {
                      final tableVM =
                          Provider.of<TableViewModel>(context, listen: false);
                      await orderVM.placeOrder(
                          int.parse(widget.tableId), selectedItems);
                      tableVM.changeTableStatus(widget.tableId, true);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Place Order',
                      style: MyTextStyle.body.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spaceHeight * 2),
              ],
            ),
          ),
          if (showFilteredItems)
            Positioned(
              top: screenHeight * 0.12,
              left: AppConstants.widthPadding * 1.3,
              right: AppConstants.widthPadding * 1.3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredItems[index],
                        style: MyTextStyle.subtitle,
                      ),
                      onTap: () {
                        setState(() {
                          itemnameController.text = filteredItems[index];
                          showFilteredItems = false;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
