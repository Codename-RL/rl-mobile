import 'package:get/get.dart';

class TabControllerX extends GetxController {
  final index = 0.obs;           // 0: Journal, 1: People, 2: Reminder
  void setTab(int i) => index.value = i;
}
