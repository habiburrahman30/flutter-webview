import 'package:get/route_manager.dart';

void push<T>(T page) => Get.to<void>(() => page);

void offAll<T>(T page) => Get.offAll<void>(() => page);

void toNamed<String>(String name) => Get.toNamed("$name");

void back() => Get.back<void>();
