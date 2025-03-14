import 'dart:convert';

import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../helpers/klog.dart';

class OnesignalNotificationController extends GetxController {
  final enableConsentButton = RxBool(false);
  final notificationEnable = RxBool(false);
  final requireConsent = RxBool(false);
  final debugLabelString = RxString('');

  final notificationData = RxList([]);
  final debugLabelString2 = RxString('');
  final apiKey = RxString(
      'os_v2_app_yatxzec6efevhl2c3u7dmq4jb7byta3ag2uetsfwdpdxhwaay4futlmzfwbwnsx6dsts5dsdyagjuzgad2bkefzsz4pwxceaxsxavui');
  final appId = RxString('c0277c90-5e21-4953-af42-dd3e3643890f');

  handlePromptForPushPermission() {
    OneSignal.Notifications.requestPermission(true);
  }

  Future<void> initOnesignal() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.consentRequired(requireConsent.value);

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    OneSignal.initialize(appId.value);
    await OneSignal.LiveActivities.setupDefault();
    await OneSignal.Notifications.clearAll();

    // OneSignal.login('123456');
    // // Pass in email provided by customer
    // OneSignal.User.addEmail("customer@company.com");

    // // Pass in phone number provided by customer
    // OneSignal.User.addSms("+11234567890");
    klog('OneSignal initialize');
    OneSignal.User.addObserver((state) {
      var userState = state.jsonRepresentation();
      klog('OneSignal user changed: $userState');
    });

    await OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.addPermissionObserver((state) {
      klog("Has permission $state");
    });

    OneSignal.Notifications.addClickListener((event) {
      // klog(event.notification.jsonRepresentation());

      //Add notification to list
      addNotification(event.notification.jsonRepresentation());

      klog(
          'NOTIFICATION CLICK LISTENER CALLED WITH EVENT: ${event.notification.jsonRepresentation()}');

      debugLabelString.value =
          "Clicked notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      //Add notification to list
      // addNotification(event.notification.jsonRepresentation());
      klog(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();

      debugLabelString.value =
          "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    });

    OneSignal.InAppMessages.addClickListener((event) {
      debugLabelString.value =
          "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}";
    });

    OneSignal.InAppMessages.addWillDisplayListener((event) {
      klog("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });

    OneSignal.InAppMessages.addDidDisplayListener((event) {
      klog("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });

    OneSignal.InAppMessages.addWillDismissListener((event) {
      klog("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
    });

    OneSignal.InAppMessages.addDidDismissListener((event) {
      klog("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
    });

    enableConsentButton.value = requireConsent.value;

    // Some examples of how to use In App Messaging public methods with OneSignal SDK
    oneSignalInAppMessagingTriggerExamples();

    // Some examples of how to use Outcome Events public methods with OneSignal SDK
    oneSignalOutcomeExamples();
    // handlePromptForPushPermission();
    // OneSignal.InAppMessages.paused(true);
  }

  oneSignalInAppMessagingTriggerExamples() async {
    /// Example addTrigger call for IAM
    /// This will add 1 trigger so if there are any IAM satisfying it, it
    /// will be shown to the user
    OneSignal.InAppMessages.addTrigger("trigger_1", "one");

    /// Example addTriggers call for IAM
    /// This will add 2 triggers so if there are any IAM satisfying these, they
    /// will be shown to the user
    Map<String, String> triggers = new Map<String, String>();
    triggers["trigger_2"] = "two";
    triggers["trigger_3"] = "three";
    OneSignal.InAppMessages.addTriggers(triggers);

    // Removes a trigger by its key so if any future IAM are pulled with
    // these triggers they will not be shown until the trigger is added back
    OneSignal.InAppMessages.removeTrigger("trigger_2");

    // Create a list and bulk remove triggers based on keys supplied
    List<String> keys = ["trigger_1", "trigger_3"];
    OneSignal.InAppMessages.removeTriggers(keys);

    // Toggle pausing (displaying or not) of IAMs
    OneSignal.InAppMessages.paused(true);
    var arePaused = await OneSignal.InAppMessages.arePaused();
    klog('Notifications paused $arePaused');
  }

  oneSignalOutcomeExamples() async {
    OneSignal.Session.addOutcome("normal_1");
    OneSignal.Session.addOutcome("normal_2");

    OneSignal.Session.addUniqueOutcome("unique_1");
    OneSignal.Session.addUniqueOutcome("unique_2");

    OneSignal.Session.addOutcomeWithValue("value_1", 3.2);
    OneSignal.Session.addOutcomeWithValue("value_2", 3.9);
  }

  void getPlayerId() async {
    final deviceState = await OneSignal.User.getOnesignalId();

    if (deviceState != null) {
      String playerId = deviceState;
      klog("OneSignal Player ID: $playerId");
    } else {
      klog("Player ID not found");
    }
  }

  //
  addNotification(event) async {
    var str = event
        .toString()
        .replaceAll("${"\"{"}", "{")
        .replaceAll("${"}\""}", "}");
    var data = json.decode(str);
    notificationData.add(data);
    // klog('Habib2: ${data}');
  }
}
