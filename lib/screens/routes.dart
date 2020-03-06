import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/backup/done_backup.dart';
import 'package:fusecash/screens/backup/show_mnemonic.dart';
import 'package:fusecash/screens/backup/verify_mnemonic.dart';
import 'package:fusecash/screens/buy/buy.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/buy/map.dart';
import 'package:fusecash/screens/cash_home/cash_home.dart';
import 'package:fusecash/screens/cash_home/dai_explained.dart';
import 'package:fusecash/screens/cash_home/prize.dart';
import 'package:fusecash/screens/cash_home/transaction_details.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';
import 'package:fusecash/screens/misc/about.dart';
import 'package:fusecash/screens/misc/settings.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/receive.dart';
import 'package:fusecash/screens/send/send_review.dart';
import 'package:fusecash/screens/send/send_success.dart';
import 'package:fusecash/screens/signup/level_selector.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/signup/username.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/screens/misc/switch_commmunity.dart';
import 'package:fusecash/screens/misc/pincode.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashScreen splashScreen;
  SignupScreen signupScreen;
  VerifyScreen verifyScreen;
  UserNameScreen userNameScreen;
  ReceiveScreen receiveScreen;
  PincodeScreen pincodeScreen;
  LevelSelectorScreen levelSelectorScreen;
  CashHomeScreen cashHomeScreen;
  TransactionDetailsScreen transactionDetailsScreen;
  SendToContactScreen sendToContactScreen;
  SendAmountScreen sendAmountScreen;
  SendReviewScreen sendReviewScreen;
  SendSuccessScreen sendSuccessScreen;
  SwitchCommunityScreen switchCommunityScreen;
  BuyScreen buyScreen;
  BusinessPage businessPage;
  RecoveryPage recoveryPage;
  ShowMnemonic showMnemonic;
  VerifyMnemonic verifyMnemonic;
  DoneBackup doneBackup;
  AboutScreen aboutScreen;
  SettingsScreen settingsScreen;
  MapScreen mapScreen;
  PrizeScreen prizeScreen;
  DaiExplainedScreen daiExplainedScreen;
  WebViewPage webViewPage;
}
