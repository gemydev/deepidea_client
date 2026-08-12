import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/preferences_manager.dart';
import '../../../../../core/helpers/snakbar_manager.dart';
import '../../../../home/data/models/responses/get_all_services_by_web_id_response.dart';
import '../../../../home/data/models/responses/get_services_list_of_packages_with_fav_response.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Package? cartPackage;
  List<ServiceItem> cartServices = [];

  num totalPrice = 0;
  num yearlyPrice = 0;

  static const String cartKey = "user_cart";

  // =========================
  // 📦 ADD PACKAGE
  // =========================
  void addPackage(Package package) async {
    // Only replace if different
    if (cartPackage == null || cartPackage!.packageId != package.packageId) {
      cartPackage = package;

      totalPrice =
          _calculateServicesTotal() + (package.priceDetails?.cost ?? 0);
      yearlyPrice = totalPrice * 12;

      await _saveCart();
      AppSnackBar.success("تمت إضافة الباقة بنجاح");
      _emitLoaded();
    } else {
      AppSnackBar.info("الباقة موجودة بالفعل في السلة");
    }
  }

  // =========================
  // 🧩 ADD OR UPDATE SERVICE
  // =========================
  void addService(ServiceItem service) async {
    final index = cartServices.indexWhere(
      (s) => s.service?.autoId == service.service?.autoId,
    );

    if (index == -1) {
      cartServices.add(
        service.copyWith(quantity: service.quantity > 0 ? service.quantity : 1),
      );
      AppSnackBar.success("تمت إضافة العنصر بنجاح");
    } else {
      final existing = cartServices[index];
      cartServices[index] = existing.copyWith(
        quantity: existing.quantity + service.quantity,
      );
    }

    totalPrice =
        _calculateServicesTotal() + (cartPackage?.priceDetails?.cost ?? 0);
    yearlyPrice = totalPrice * 12;

    await _saveCart();
    _emitLoaded();
  }

  // =========================
  // ❌ REMOVE SERVICE
  // =========================
  void removeService(ServiceItem service) async {
    cartServices.removeWhere(
      (s) => s.service?.autoId == service.service?.autoId,
    );

    totalPrice =
        _calculateServicesTotal() + (cartPackage?.priceDetails?.cost ?? 0);
    yearlyPrice = totalPrice * 12;

    await _saveCart();
    AppSnackBar.success("تم حذف العنصر من السلة");
    _emitLoaded();
  }

  // =========================
  // 🗑️ EMPTY CART
  // =========================
  void emptyCart() async {
    cartPackage = null;
    cartServices.clear();
    totalPrice = 0;
    yearlyPrice = 0;

    await TpPreferencesManager.removeData(cartKey);
    emit(CartEmpty());
  }

  // =========================
  // 🔁 EMIT LOADED
  // =========================
  void _emitLoaded() {
    int count = 0;

    if (cartPackage != null) {
      count += 1;
    }

    for (var action in cartServices) {
      count += action.quantity;
    }

    emit(
      CartLoaded(
        cartPackage: cartPackage,
        cartServices: List<ServiceItem>.from(cartServices),
        itemCount: count,
      ),
    );
  }

  // =========================
  // 🧾 LOAD CART
  // =========================
  void loadCart() async {
    final savedCart = TpPreferencesManager.retrieveString(cartKey);

    if (savedCart == null || savedCart.isEmpty) {
      emit(CartEmpty());
      return;
    }

    try {
      final decoded = jsonDecode(savedCart);

      final packages = decoded['packages'] as List? ?? [];
      final services = decoded['services'] as List? ?? [];

      cartPackage = packages.isNotEmpty
          ? Package.fromJson(packages.first)
          : null;
      cartServices = services.map((e) => ServiceItem.fromJson(e)).toList();

      totalPrice =
          _calculateServicesTotal() + (cartPackage?.priceDetails?.cost ?? 0);
      yearlyPrice = totalPrice * 12;

      _emitLoaded();
      log("Cart loaded successfully");
    } catch (e) {
      log("Cart decode error: $e");
      emit(CartEmpty());
    }
  }

  // =========================
  // 💾 SAVE CART
  // =========================
  Future<void> _saveCart() async {
    final jsonString = jsonEncode({
      "packages": cartPackage != null ? [cartPackage!.toJson()] : [],
      "services": cartServices.map((e) => e.toJson()).toList(),
    });

    await TpPreferencesManager.saveString(cartKey, jsonString);
  }

  // =========================
  // 💰 CALCULATE TOTAL
  // =========================
  num _calculateServicesTotal() {
    return cartServices.fold<num>(
      0,
      (sum, item) =>
          sum +
          ((item.subProductPrices?.first.price?.toDouble() ?? 0) *
              item.quantity),
    );
  }
}
