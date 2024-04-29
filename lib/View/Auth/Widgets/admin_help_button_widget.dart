import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';

class AdminHelpButtonWidget extends StatelessWidget {
  const AdminHelpButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 5),
          child: Text(
            "Need Help?",
            style: kSmallTextStyle.copyWith(
              color: kBlackColor,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: BlocBuilder<AppDetailsCubit,AppDetailsModel>(
            builder: (context,appDetailsModel) {
              return ElevatedButton.icon(
                  onPressed: () async {
                    await LaunchCustomUrls.launchURL(
                      url: 'https://wa.me/${appDetailsModel.data.contactDetails.whatsappNo}',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kBlackColor.withOpacity(.7),
                      foregroundColor: kWhiteColor,
                      elevation: 0,
                      minimumSize: const Size(130, 40),
                      maximumSize: const Size(130, 40),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: k2ndColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          const EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                  icon: Image.asset(
                    "assets/General/whatsapp.png",
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                  ),
                  label: const Text("Admin"));
            }
          ),
        )
      ],
    );
  }
}
