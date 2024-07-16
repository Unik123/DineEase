import 'package:dineease/model/restro/item.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/constants.dart';
import 'package:flutter/material.dart';

class MyCards {
  static Container productContainer(
    String title,
    String category,
    String price,
    String image,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.bannerPadding),
      margin: const EdgeInsets.only(right: 10),
      width: 175,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 242, 242),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: MyTextStyle.body.copyWith(
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                    const Icon(
                      Icons.ramen_dining_outlined,
                      size: 20,
                      color: Colors.green,
                    )
                  ],
                ),
                Text(
                  title,
                  maxLines: 2,
                  style: MyTextStyle.pageViewText.copyWith(
                    height: 1,
                  ),
                ),
                const SizedBox(height: AppConstants.pageheight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs. $price',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins-Bold',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Container productFood() {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.bannerPadding),
      margin: const EdgeInsets.only(right: 10),
      width: 210,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 242, 242),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          image: DecorationImage(
              image: NetworkImage(
                  'https://thumbs.dreamstime.com/b/realistic-pizza-background-menu-poster-traditional-italian-food-toppings-restaurant-banner-advertising-vector-d-173434987.jpg'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  static Padding itemCard(
    Item item,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppConstants.verticalpadding,
          horizontal: AppConstants.horizontalpadding),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 85,
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
              const SizedBox(width: 5),
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(item.image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: AppConstants.horizontalpadding * 1.5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppConstants.verticalpadding * 3),
                  Text(
                    item.name,
                    style: MyTextStyle.body,
                  ),
                  Text(
                    'Price: ${item.price}',
                    style: MyTextStyle.subtitle,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
