import 'package:dineease/model/restro/item.dart';
import 'package:dineease/style/components/cards.dart';
import 'package:dineease/style/header/section_header.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item item;

  const ItemDetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final itemVM = Provider.of<ItemViewModel>(context);
    final items = itemVM.items
        .where((element) => element.department == item.department)
        .toList();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      item.image,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: AppConstants.verticalpadding * 2),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalpadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: MyTextStyle.title.copyWith(fontSize: 22),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.crop_square_rounded,
                        color: Colors.green,
                      ),
                      Text(
                        item.department,
                        style: MyTextStyle.thin.copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.verticalpadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalpadding),
                  child: Text(
                    "Rs. ${item.price} /-",
                    style: MyTextStyle.title.copyWith(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalpadding * 1.3),
                  child: Text(
                    "inclusive of all taxes",
                    style: MyTextStyle.thin
                        .copyWith(color: Colors.green, fontSize: 11),
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: AppConstants.verticalpadding),
            if (item.description != null)
              const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalpadding),
                  child: SectionHeader(title: 'Description')),
            const SizedBox(height: AppConstants.verticalpadding),
            if (item.description != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalpadding),
                child: Text(
                  item.description!,
                  style: MyTextStyle.subtitle.copyWith(fontSize: 14),
                ),
              ),
            const SizedBox(height: AppConstants.verticalpadding * 2),
            const Divider(),
            const SizedBox(height: AppConstants.verticalpadding * 2),
            if (items.isNotEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalpadding),
                child: SectionHeader(title: 'Similar Products'),
              ),
            const SizedBox(height: AppConstants.verticalpadding * 2),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                childAspectRatio: 0.65,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
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
          ],
        ),
      ),
    );
  }
}
