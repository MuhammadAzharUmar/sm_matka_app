import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class CustomSliderWidget extends StatelessWidget {
  const CustomSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(borderRadius: kLargeBorderRadius),
      child: Container(
        height: 150,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: kWhiteColor,
        ),
        child: Stack(
          children: [
            CarouselSlider(
              items: [
                "https://i.pinimg.com/736x/86/42/90/8642904161bc3964032f66d569e3937f.jpg",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThIJj70HduRKpnhBfxLMyD1gt7Wp558EP8uLy-ERieJtDvpN6mVcJgQ85QU5Vj-fAxXEM&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC6EzCemijWUzMhioIQ8B-S-vMTagfJmyF0g&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLpHwNzDsyZ0p2K1I-W3j1dQkulD2qwuek4w&usqp=CAU",
                "https://c4.wallpaperflare.com/wallpaper/739/262/425/movies-hollywood-movies-wallpaper-preview.jpg",
              ].map((img) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.maxFinite,
                      height: 150,
                      // margin:const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        image: DecorationImage(
                            image: NetworkImage(
                              img,
                            ),
                            fit: BoxFit.cover),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: kBlue1Color.withOpacity(.3),
                height: 32,
                alignment: Alignment.bottomCenter,
                // color: k2ndColor,
                child: Marquee(
                  text: "Welcome to SM MATKA...\t\t  \t \t",
                  style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
                  scrollAxis: Axis.horizontal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
