import 'dart:math';

num floorDouble(double value, int places) {
  num mod = pow(10.0, places);
  double result = ((value * mod).floor().toDouble() / mod);
  if (result.toString().contains(".0")) {
    return result.toInt();
  } else {
    return result;
  }
}
