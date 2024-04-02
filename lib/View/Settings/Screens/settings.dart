import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Settings/Widgets/menu_item_list.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kBlue1Color,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "Settings",
            style: kMediumTextStyle.copyWith(
                color: kblue1color, fontWeight: FontWeight.w700),
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: MenuItem.menuItem.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              onTap: () async {
                await MenuItem.menuItem[index]['onTap'](context);
              },
              horizontalTitleGap: 0,
              leading: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  MenuItem.menuItem[index]['icon'],
                  size: 18,
                  color: kBlue1Color,
                ),
              ),
              title: Text(MenuItem.menuItem[index]['title']),
            );
          },
        ),
      ),
    );
  }
}
