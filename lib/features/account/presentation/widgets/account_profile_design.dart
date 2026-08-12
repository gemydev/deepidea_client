import 'package:flutter/material.dart';
import 'package:remotely/core/widgets/custom_image.dart';

import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../shared_widgets/app_header_with_avatar.dart';

/// Profile + personal info + current plan + sign out — matches account screen design.
class AccountProfileDesign extends StatelessWidget {
  const AccountProfileDesign({
    super.key,
    required this.clientName,
    required this.email,
    required this.phone,
    required this.address,
    required this.company,
    required this.customerIdLabel,
    required this.planName,
    required this.planStatusLabel,
    required this.subscriptionDateLabel,
    required this.renewalDateLabel,
    required this.onRenewPackage,
    required this.onLogout,
    this.isSubscriptionActive = true,
    this.showRenewButton = false,
    this.isPlanLoading = false,
    this.isLoggingOut = false,
  });

  final String clientName;
  final String email;
  final String phone;
  final String address;
  final String company;
  final String customerIdLabel;
  final String planName;
  final String planStatusLabel;
  final String subscriptionDateLabel;
  final String renewalDateLabel;
  final bool isSubscriptionActive;
  final bool showRenewButton;
  final bool isPlanLoading;
  final VoidCallback onRenewPackage;
  final VoidCallback onLogout;
  final bool isLoggingOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ProfileHeaderCard(
          clientName: clientName,
          customerIdLabel: customerIdLabel,
          address: address,
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerRight,
          child: CustomText(
            'المعلومات الشخصية',
            style: CustomStyleManger.heading1.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColorsManager.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _PersonalInfoTile(
          icon: Icons.email_outlined,
          iconBackground: CustomColorsManager.appGreen.withValues(alpha: 0.25),
          iconColor: CustomColorsManager.appGreen,
          title: 'البريد الالكتروني',
          value: email,
        ),
        const SizedBox(height: 10),
        _PersonalInfoTile(
          icon: Icons.phone_outlined,
          iconBackground: CustomColorsManager.orangeColor.withValues(alpha: 0.25),
          iconColor: CustomColorsManager.orangeColor,
          title: 'رقم الجوال',
          value: phone,
        ),
        const SizedBox(height: 10),
        _PersonalInfoTile(
          icon: Icons.business_outlined,
          iconBackground: CustomColorsManager.blueColor.withValues(alpha: 0.2),
          iconColor: CustomColorsManager.blueColor,
          title: 'الشركة',
          value: company,
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerRight,
          child: CustomText(
            'الخطة الحالية',
            style: CustomStyleManger.heading1.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CustomColorsManager.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _CurrentPlanCard(
          planName: planName,
          statusLabel: planStatusLabel,
          subscriptionDateLabel: subscriptionDateLabel,
          renewalDateLabel: renewalDateLabel,
          isSubscriptionActive: isSubscriptionActive,
          showRenewButton: showRenewButton,
          isLoading: isPlanLoading,
          onRenew: onRenewPackage,
        ),
        const SizedBox(height: 24),
        _SignOutOutlinedButton(onTap: onLogout, isLoading: isLoggingOut),
      ],
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard({
    required this.clientName,
    required this.customerIdLabel,
    required this.address,
  });

  final String clientName;
  final String customerIdLabel;
  final String address;

  @override
  Widget build(BuildContext context) {
    final initial = AppHeaderWithAvatar.getInitials(clientName);
    return Container(
      decoration: BoxDecoration(
        color: CustomColorsManager.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: CustomColorsManager.primaryColor.withValues(alpha: 0.2),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: CustomColorsManager.primaryColor,
                    child: Text(
                      initial,
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: CustomColorsManager.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomText(
                    clientName.isEmpty ? '—' : clientName,
                    style: CustomStyleManger.heading1.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CustomColorsManager.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: CustomColorsManager.unSelectedBorderColor,
            thickness: 0.8,
            endIndent: 20,
            indent: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'رقم العميل',
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 13,
                          color: CustomColorsManager.lightGrayTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        customerIdLabel,
                        style: CustomStyleManger.heading1.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: CustomColorsManager.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'العنوان',
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 13,
                          color: CustomColorsManager.lightGrayTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        address,
                        style: CustomStyleManger.heading1.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: CustomColorsManager.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalInfoTile extends StatelessWidget {
  const _PersonalInfoTile({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: CustomColorsManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: iconBackground, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  style: CustomStyleManger.heading1.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: CustomColorsManager.black,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  value,
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 13,
                    color: CustomColorsManager.lightGrayTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentPlanCard extends StatelessWidget {
  const _CurrentPlanCard({
    required this.planName,
    required this.statusLabel,
    required this.subscriptionDateLabel,
    required this.renewalDateLabel,
    required this.isSubscriptionActive,
    required this.showRenewButton,
    required this.isLoading,
    required this.onRenew,
  });

  final String planName;
  final String statusLabel;
  final String subscriptionDateLabel;
  final String renewalDateLabel;
  final bool isSubscriptionActive;
  final bool showRenewButton;
  final bool isLoading;
  final VoidCallback onRenew;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: CustomColorsManager.primaryColor.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: CustomColorsManager.white),
      );
    }

    final statusColor = isSubscriptionActive ? CustomColorsManager.green : CustomColorsManager.red;

    return Container(
      decoration: BoxDecoration(
        color: CustomColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    planName,
                    style: CustomStyleManger.heading1.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CustomColorsManager.white,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: CustomColorsManager.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImage(imagePath: CustomAssetsManager.star),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _planRow('الحالة', statusLabel, isStatus: true, statusColor: statusColor),
            const SizedBox(height: 5),
            _planRow('تاريخ الاشتراك', subscriptionDateLabel),
            const SizedBox(height: 5),
            _planRow('تاريخ التجديد', renewalDateLabel),
            if (showRenewButton) ...[
              const SizedBox(height: 16),
              Material(
                color: CustomColorsManager.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: onRenew,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: CustomText(
                        'تجديد الباقة',
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CustomColorsManager.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _planRow(String label, String value, {bool isStatus = false, Color? statusColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label,
          style: CustomStyleManger.normalText.copyWith(
            fontSize: 14,
            color: CustomColorsManager.white.withValues(alpha: 0.9),
          ),
        ),
        if (isStatus)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: statusColor ?? CustomColorsManager.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              CustomText(
                value,
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: statusColor ?? CustomColorsManager.green,
                ),
              ),
            ],
          )
        else
          CustomText(
            value,
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: CustomColorsManager.white,
            ),
          ),
      ],
    );
  }
}

class _SignOutOutlinedButton extends StatelessWidget {
  const _SignOutOutlinedButton({required this.onTap, this.isLoading = false});

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: CustomColorsManager.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CustomColorsManager.red, width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(CustomColorsManager.red),
                ),
              )
            else ...[
              CustomImage(imagePath: CustomAssetsManager.login),
              const SizedBox(width: 10),
              CustomText(
                'تسجيل الخروج',
                style: CustomStyleManger.heading1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: CustomColorsManager.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
