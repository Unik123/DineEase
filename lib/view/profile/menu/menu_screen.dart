import 'package:dineease/style/components/cards.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/view/profile/menu/add_item_screen.dart';
import 'package:dineease/view/profile/menu/edit_item_screen.dart';
import 'package:dineease/view/widgets/no_data_widget.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemViewModel>(context, listen: false).fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemVM = Provider.of<ItemViewModel>(context);
    final items = itemVM.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Items",
          style: MyTextStyle.title,
        ),
      ),
      body: items.isEmpty
          ? const NoData(
              title: 'No Food',
              subtitle: "There's no food item",
              icon: Icons.ramen_dining_outlined,
            )
          : RefreshIndicator(
              onRefresh: () async {
                await itemVM.fetchItems();
              },
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return MyCards.itemCard(
                    item,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditItemScreen(
                            item: item,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddItemScreen(),
            ),
          );
        },
        icon: const Icon(Icons.ramen_dining_outlined),
        label: const Text(
          'Add Item',
          style: MyTextStyle.body,
        ),
      ),
    );
  }
}
