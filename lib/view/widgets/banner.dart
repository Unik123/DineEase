import 'package:dineease/view_model/restro/banner_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';


class MyBanner extends StatelessWidget {
  const MyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerVM = Provider.of<BannerViewModel>(context);
    final banners = bannerVM.banners;

    return banners.isNotEmpty
        ? CarouselSlider(
            items: banners.map((banner) {
              // Use the banners from the view model
              return SizedBox(
                width: double.infinity,
                child: Image.network(
                  banner.image,
                  fit: BoxFit.fitWidth,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
              },
            ),
          )
        : const SizedBox();
  }
}
