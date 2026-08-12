import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/preferences_manager.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, this.fromCompleteAccount = false});

  final bool fromCompleteAccount;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String clientFirstName = "غير متوفر";
  String clientLastName = "غير متوفر";
  String clientEmail = "غير متوفر";
  String clientPhone = "غير متوفر";

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  void _loadPrefs() async {
    final cName = TpPreferencesManager.retrieveString(TpPreferencesManager.clientName);
    final cEmail = TpPreferencesManager.retrieveString(TpPreferencesManager.clientEmail);
    final cPhone = TpPreferencesManager.retrieveString(TpPreferencesManager.clientPhone);

    final parts = (cName ?? "").trim().split(" ");
    final firstName = parts.isNotEmpty ? parts.first : "غير متوفر";
    final lastName = parts.length > 1 ? parts.sublist(1).join(" ") : "غير متوفر";

    setState(() {
      clientFirstName = firstName;
      clientLastName = lastName;
      clientEmail = cEmail ?? "غير متوفر";
      clientPhone = cPhone ?? "غير متوفر";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubAppBar(
                title: widget.fromCompleteAccount ? "استكمال الملف الشخصي" : "الملف الشخصي",
              ),
              const SizedBox(height: 10),
              Container(
                color: CustomColorsManager.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const ProfileImage(),
                      const SizedBox(height: 15),
                      ProfileItem(title: "الاسم", data: clientFirstName),
                      const SizedBox(height: 15),
                      ProfileItem(title: "اسم العائلة", data: clientLastName),
                      const SizedBox(height: 15),
                      ProfileItem(title: "رقم الهاتف", data: clientPhone),
                      const SizedBox(height: 15),
                      ProfileItem(title: "البريد الالكتروني", data: clientEmail),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Profile Picture
        Center(
          child: Container(
            height: screenWidth * 0.4, // Responsive size
            width: screenWidth * 0.4, // Responsive size
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(CustomAssetsManager.person),
              ),
            ),
          ),
        ),

        // Camera Icon
        Positioned(
          bottom: screenWidth * 0.04, // Responsive offset
          right: screenWidth * 0.5 + screenWidth * 0.15 - 40, // Adjust position dynamically
          child: Container(
            decoration: BoxDecoration(
              color: CustomColorsManager.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
              child: CustomImage(
                imagePath: CustomAssetsManager.camera,
                height: screenWidth * 0.06, // Responsive icon size
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CustomColorsManager.profileBGColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 20,
                    color: CustomColorsManager.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                CustomText(
                  data,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  style: CustomStyleManger.normalText.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
