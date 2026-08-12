import 'dart:math';

import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/cart/presentation/cubit/post_invoices/post_invoices_cubit.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/helpers/preferences_manager.dart';
import '../../../../core/helpers/snakbar_manager.dart';
import '../../../../core/helpers/whatsapp_launcher.dart';
import '../../../../core/services/firebase_analytics_service.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/data/models/requests/get_packages_from_backage_bundel.dart';
import '../../../home/data/models/responses/get_all_services_by_web_id_response.dart';
import '../../../home/data/models/responses/get_services_list_of_packages_with_fav_response.dart';
import '../../../home/presentation/cubits/get_packages_from_package_bundle/get_packages_from_package_bundle_cubit.dart';
import '../../data/models/requests/post_invoices_with_confirm_request.dart';
import '../cubit/cart/cart_cubit.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartCubit cartCubit = sl<CartCubit>();
  final uuid = const Uuid();
  final FirebaseAnalyticsService _analytics = FirebaseAnalyticsService.instance;

  @override
  void initState() {
    super.initState();
    cartCubit.loadCart();
  }

  void processPayment({
    required num totalPrice,
    Package? package,
    List<ServiceItem>? services,
  }) async {
    // Track payment initiation event
    await _analytics.logBeginCheckout(
      value: totalPrice.toDouble(),
      currency: 'SAR',
      items: [
        if (package != null)
          AnalyticsEventItem(
            itemId: package.packageId.toString(),
            itemName: package.packageName ?? 'Package',
            itemCategory: 'Package',
            price: (package.priceDetails?.cost ?? 0).toDouble(),
            quantity: 1,
          ),
        if (services != null)
          ...services.map(
            (service) => AnalyticsEventItem(
              itemId: service.service?.autoId.toString() ?? '0',
              itemName: service.service?.pkgName ?? 'Service',
              itemCategory: 'Service',
              price: (service.subProductPrices?.first.price?.toDouble() ?? 0),
              quantity: service.quantity,
            ),
          ),
      ],
    );

    if (!context.mounted) return;

    final order = EdfaPgSaleOrder(
      id: const Uuid().v4(),
      description: "Order Payment",
      currency: "SAR",
      amount: totalPrice.abs(),
    );

    final payer = EdfaPgPayer(
      firstName: "First Name",
      lastName: "Last Name",
      email: "support@edapay.com",
      address: "EdfaPay Payment Gateway",
      country: "SA",
      city: "Riyadh",
      zip: "123768",
      phone: kSupportPhoneE164,
      ip: "66.249.64.248",
    );

    EdfaCardPay edfaCardPay = EdfaCardPay()
        .setRecurring(true)
        .setOrder(order)
        .setPayer(payer)
        .setDesignType(EdfaPayDesignType.one)
        .setLanguage(EdfaPayLanguage.ar)
        .onTransactionSuccess((response) async {
          final random = Random();
          final randomFourDigits = 1000 + random.nextInt(9000);

          final request = PostInvoicesWithConfirmRequest(
            clientAccountNo: "11111",
            invoiceCode: "OSI102636$randomFourDigits",
            invoiceType: 0,
            salesmanId: 2336,
            invoicesStatus: 8,
            packageBundleId: package?.packageId,
            businessName: '',
            taxNumber: '',
            commercialRegister: '',
            createdDate: DateTime.now().toUtc().toIso8601String(),
            deliveryTime: DateTime.now().add(const Duration(days: 2)).toUtc().toIso8601String(),
            inventoryId: 36,
            invoiceDetails: "",
            shippingStatus: 0,
            paymentType: 4,
            shippingPackageId: 0,
            shippingPrice: 2.0,
            userId: 2336,
            websiteId: int.parse(
              TpPreferencesManager.retrieveString(TpPreferencesManager.websiteId) ?? "0",
            ),
            clientName: TpPreferencesManager.retrieveString(TpPreferencesManager.clientName) ?? " ",
            clientPhone:
                TpPreferencesManager.retrieveString(TpPreferencesManager.clientPhone) ?? " ",
            clientEmail:
                TpPreferencesManager.retrieveString(TpPreferencesManager.clientEmail) ?? " ",
            clientAddress:
                TpPreferencesManager.retrieveString(TpPreferencesManager.clientAddress) ?? " ",
            recievedInvoiceServices: [],
            clientCode: "33333",
            priceCode: "",
            shiftId: null,
            supplierNumber: null,
            recievedInvoiceProducts: [],
            recievedInvoiceSummary: [],
            recievedInvoicePaymentType: [
              RecievedInvoicePaymentType(
                paymentType: 1,
                amount: totalPrice.toDouble(),
                details: "Paid via Credit Card",
              ),
            ],
            recievedInvoiceTax: [],
          );

          // Package selling
          if (package != null) {
            final getPackagesCubit = sl<GetPackagesFromPackageBundleCubit>();
            await getPackagesCubit.getPackagesFromPackageBundle(
              GetPackagesFromPackageBundleRequest(
                bundleId: package.packageId.toString(),
                invoiceId: "",
              ),
            );
            final currentState = getPackagesCubit.state;

            if (currentState is GetPackagesFromPackageBundleLoaded) {
              for (final item in currentState.response.result!) {
                request.recievedInvoiceProducts?.add(
                  RecievedInvoiceProduct(
                    productId: item.packageId ?? 0,
                    qnt: item.quantity!.toInt(),
                    productPrice: item.cost?.toDouble() ?? 0.0,
                    totalPrice: item.totalPrice?.toDouble() ?? 0.0,
                    details: item.packageName ?? '',
                    productDiscount: item.discount?.toDouble() ?? 0.0,
                    productTax: item.taxRate?.toDouble() ?? 0.0,
                    sn: "SN${item.packageId ?? 0}",
                    id: item.packageId ?? 0,
                    excutionPeriod: item.executionTime,
                  ),
                );
                request.packageBundleId = package.packageId;
              }
            } else if (currentState is GetPackagesFromPackageBundleError) {
              AppSnackBar.error("فشل في تحميل محتوى الباقة");
            }
          }

          // Free service selling
          if (services != null && services.isNotEmpty) {
            for (final service in services) {
              request.recievedInvoiceProducts?.add(
                RecievedInvoiceProduct(
                  productId: service.service?.autoId ?? 0,
                  qnt: service.quantity,
                  productPrice: service.subProductPrices?.first.price?.toDouble() ?? 0.0,
                  totalPrice:
                      (service.subProductPrices?.first.price?.toDouble() ?? 0) * service.quantity,
                  details: service.service?.details ?? '',
                  productDiscount: 0,
                  productTax: 0.0,
                  excutionPeriod: 12,
                  sn: "SN${service.service?.autoId ?? 0}",
                  id: service.service?.autoId ?? 0,
                ),
              );
            }
          }

          await sl<PostInvoicesCubit>().postInvoices(postInvoicesWithConfirmRequest: request).then((
            success,
          ) async {
            if (success) {
              // Track successful payment event
              await _analytics.logPurchase(
                value: totalPrice.toDouble(),
                currency: 'SAR',
                transactionId: request.invoiceCode ?? '',
                items: [
                  if (package != null)
                    AnalyticsEventItem(
                      itemId: package.packageId.toString(),
                      itemName: package.packageName ?? 'Package',
                      itemCategory: 'Package',
                      price: (package.priceDetails?.cost ?? 0).toDouble(),
                      quantity: 1,
                    ),
                  if (services != null)
                    ...services.map(
                      (service) => AnalyticsEventItem(
                        itemId: service.service?.autoId.toString() ?? '0',
                        itemName: service.service?.pkgName ?? 'Service',
                        itemCategory: 'Service',
                        price: (service.subProductPrices?.first.price?.toDouble() ?? 0),
                        quantity: service.quantity,
                      ),
                    ),
                ],
              );

              sl<CartCubit>().emptyCart();
              AppSnackBar.success("تمت عملية الدفع بنجاح!");
            } else {
              // Track payment failure event
              await _analytics.logPaymentFailed(
                value: totalPrice.toDouble(),
                currency: 'SAR',
                reason: 'invoice_upload_failed',
              );
              AppSnackBar.error("حدثت مشكلة في رفع الفاتورة");
            }
          });
        })
        .onTransactionFailure((response) async {
          // Track payment failure event
          await _analytics.logPaymentFailed(
            value: totalPrice.toDouble(),
            currency: 'SAR',
            reason: 'transaction_failed',
          );
          AppSnackBar.error("فشلت عملية الدفع، حاول مرة أخرى");
        })
        .onError((error) async {
          // Track payment error event
          await _analytics.logPaymentError(
            value: totalPrice.toDouble(),
            currency: 'SAR',
            error: error.toString(),
          );
          AppSnackBar.error("حدث خطأ أثناء الدفع", position: SnackPosition.TOP);
        });
    if (!mounted) return;
    edfaCardPay.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          children: [
            SubAppBar(
              title: "سلة التسوق",
              widget: BlocBuilder<CartCubit, CartState>(
                bloc: cartCubit,
                builder: (context, state) {
                  if (state is CartLoaded &&
                      (state.cartPackage != null || (state.cartServices.isNotEmpty))) {
                    return GestureDetector(
                      onTap: () {
                        cartCubit.emptyCart();
                        AppSnackBar.success("تمت إفراغ السلة بنجاح");
                      },
                      child: Row(
                        children: [
                          const CustomImage(imagePath: CustomAssetsManager.trash, height: 20),
                          const SizedBox(width: 5),
                          CustomText(
                            "افراغ السلة",
                            style: CustomStyleManger.normalText.copyWith(
                              color: CustomColorsManager.appRed,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: BlocBuilder<CartCubit, CartState>(
                  bloc: cartCubit,
                  builder: (context, state) {
                    if (state is CartEmpty) {
                      return _buildEmptyCart();
                    } else if (state is CartLoaded) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            if (state.cartPackage != null)
                              _buildPackageSummary(
                                state.cartPackage!,
                                cartCubit.totalPrice,
                                cartCubit.yearlyPrice,
                              )
                            else if (state.cartServices.isNotEmpty)
                              _buildServicesSummary(state.cartServices, cartCubit.totalPrice),
                            const SizedBox(height: 100),
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            BlocBuilder<CartCubit, CartState>(
              bloc: cartCubit,
              builder: (context, state) {
                if (state is CartLoaded &&
                    (state.cartPackage != null || (state.cartServices.isNotEmpty))) {
                  return Container(
                    color: CustomColorsManager.white,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: SafeArea(
                      top: false,
                      child: CustomButton(
                        text: "الدفع",
                        textColor: CustomColorsManager.white,
                        onPressed: () async {
                          // Track payment button press event
                          await _analytics.logPaymentButtonPressed(
                            value: cartCubit.totalPrice.toDouble(),
                            currency: 'SAR',
                            hasPackage: state.cartPackage != null,
                            servicesCount: state.cartServices.length,
                          );

                          processPayment(
                            totalPrice: cartCubit.totalPrice,
                            package: state.cartPackage,
                            services: state.cartServices,
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return SingleChildScrollView(
      child: Container(
        color: CustomColorsManager.white,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart, size: 60, color: Colors.grey),
              const SizedBox(height: 20),
              CustomText(
                "سلة التسوق فارغة",
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CustomColorsManager.mainTextColor,
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                "ابدأ بإضافة منتجات للاستمرار في عملية الدفع",
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 16,
                  color: CustomColorsManager.mainTextColor.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageSummary(Package cartItem, num totalPrice, num yearlyPrice) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColorsManager.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("ملخص الباقة", style: CustomStyleManger.heading1.copyWith(fontSize: 20)),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(cartItem.packageName ?? "اسم غير متاح"),
                CustomText("${cartItem.priceDetails?.cost ?? 0} ر.س"),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [CustomText("الإجمالي السنوي"), CustomText("$yearlyPrice ر.س")],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSummary(List<ServiceItem> services, num totalPrice) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColorsManager.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "الخدمات المختارة",
              style: CustomStyleManger.heading1.copyWith(fontSize: 20),
            ),
            const Divider(height: 30),
            ...services.map(
              (service) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "x${service.quantity} ",
                      style: CustomStyleManger.normalText.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: CustomText(
                        service.service?.pkgName ?? "اسم غير متاح",
                        textAlign: TextAlign.start,
                        style: CustomStyleManger.normalText.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomText(
                      "${service.subProductPrices?.first.price ?? 0} ر.س",
                      style: CustomStyleManger.normalText.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  "الإجمالي",
                  textAlign: TextAlign.start,
                  style: CustomStyleManger.normalText.copyWith(fontWeight: FontWeight.w600),
                ),
                CustomText("$totalPrice ر.س", style: CustomStyleManger.normalText),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
