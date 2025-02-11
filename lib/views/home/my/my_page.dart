import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:tw_wallet_ui/common/application.dart';
import 'package:tw_wallet_ui/common/dapp_list.dart';
import 'package:tw_wallet_ui/common/secure_storage.dart';
import 'package:tw_wallet_ui/common/theme/color.dart';
import 'package:tw_wallet_ui/common/theme/font.dart';
import 'package:tw_wallet_ui/generated/l10n.dart';
import 'package:tw_wallet_ui/router/routers.dart';
import 'package:tw_wallet_ui/service/progress_dialog.dart';
import 'package:tw_wallet_ui/store/dcep/dcep_store.dart';
import 'package:tw_wallet_ui/store/health_certification_store.dart';
import 'package:tw_wallet_ui/store/identity_store.dart';
import 'package:tw_wallet_ui/views/backup_mnemonics/widgets/tips.dart';
import 'package:tw_wallet_ui/views/ble_payment/home.dart';
import 'package:tw_wallet_ui/views/home/home_store.dart';

Future<void> _cleanPrivateData(BuildContext context) async {
  final ProgressDialog dialog = Get.find();
  dialog.show();
  return Get.find<IdentityStore>()
      .clear()
      .then((_) => Get.find<DcepStore>().clear())
      .then((_) => Get.find<HealthCertificationStore>().clear())
      .then((_) => Get.find<SecureStorage>().clearAll())
      .then((_) => clearAllDappStorage(FlutterWebviewPlugin()))
      .then(
        (_) => Future.delayed(const Duration(seconds: 1)).then((_) {
          dialog.dismiss();
          Application.router
              .navigateTo(context, Routes.inputPin, clearStack: true);
        }),
      );
}

Future<void> clearAllDappStorage(
  FlutterWebviewPlugin flutterWebviewPlugin,
) async {
  // ignore: avoid_function_literals_in_foreach_calls
  dappList.forEach((dapp) async {
    await flutterWebviewPlugin.launch(dapp.url, hidden: true);
    await flutterWebviewPlugin.clearCache();
    await flutterWebviewPlugin.close();
  });
}

class MyPage extends StatelessWidget {
  final HomeStore homeStore;

  const MyPage(this.homeStore);

  Widget _buildButton(String text, VoidCallback onTap) {
    final screenUtil = ScreenUtil();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: screenUtil.setWidth(15)),
        height: screenUtil.setWidth(90),
        decoration: BoxDecoration(
          color: WalletColor.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0f000000),
              offset: Offset(0, 4),
              blurRadius: 12,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenUtil.setWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(text, style: WalletFont.font_18()),
                SvgPicture.asset('assets/icons/right-arrow.svg')
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();

    return Column(
      children: <Widget>[
        Container(
          height: screenUtil.setHeight(244),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              S.of(context).pageMeMyProfile,
              style: WalletFont.font_24(
                textStyle: TextStyle(
                  color: WalletColor.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ColoredBox(
            color: WalletColor.lightGrey,
            child: Padding(
              padding: EdgeInsets.all(screenUtil.setWidth(24)),
              child: ListView(
                children: <Widget>[
                  _buildButton(
                    S.of(context).pageMeOfflinePayment,
                    () => Get.to(BlePaymentHome(homeStore)),
                  ),
                  _buildButton(
                    S.of(context).pageMeMyChat,
                    () => {
                      Application.router.navigateTo(context, Routes.messagePage)
                    },
                  ),
                  _buildButton(
                    S.of(context).pageMeClearData,
                    () => _cleanPrivateData(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenUtil.setWidth(5),
                    ),
                    child: Tips(
                      S.of(context).pageMeWarningOnClear,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
