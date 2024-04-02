import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class CustomSliderWidget extends StatelessWidget {
  const CustomSliderWidget({super.key, required this.crouselImages, required this.marqueeText});
final List<String> crouselImages; 
final String marqueeText;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(borderRadius: kLargeBorderRadius),
      child: Container(
        height: 150,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: k2ndColor,
        ),
        child: Stack(
          children: [
            CarouselSlider(
              items: crouselImages.map((img) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.maxFinite,
                      height: 150,
                      // margin:const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: kblue1color,
                        image:img!=""? DecorationImage(
                            image: NetworkImage(
                              img,
                            ),
                            fit: BoxFit.cover):null,
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
                  text: "$marqueeText\t\t  \t \t",
                  style: kMediumCaptionTextStyle.copyWith(color: kblue1color),
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
