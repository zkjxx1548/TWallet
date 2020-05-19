import 'package:flutter/material.dart';
import 'package:tw_wallet_ui/global/common/theme/color.dart';
import 'package:tw_wallet_ui/global/common/theme/index.dart';
import 'package:tw_wallet_ui/global/widgets/page_title.dart';

class NewCommonLayout extends StatelessWidget {
  final Widget child;
  final bool withBottomBtn;
  final String btnText;
  final Function btnOnPressed;
  final String title;
  final String bodyBackColor;
  final BackIcon backIcon;

  NewCommonLayout({
    this.child,
    this.withBottomBtn = false,
    this.btnText = '完成',
    this.btnOnPressed,
    this.title,
    this.bodyBackColor = WalletColor.primary,
    this.backIcon = BackIcon.CLOSE,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: WalletTheme.rgbColor(bodyBackColor),
      appBar: AppBar(
        backgroundColor: WalletTheme.rgbColor(WalletColor.primary),
        brightness: Brightness.dark,
        title: PageTitleWidget(title: title, backIcon: backIcon),
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
            decorationColor: Colors.black),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0.0,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context),
        child: Container(
          color: WalletTheme.rgbColor(WalletColor.white),
          height: 30
        )
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              children: <Widget>[
                Expanded(child: child),
                if (withBottomBtn) Container(
                  color: WalletTheme.rgbColor(WalletColor.white),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                  child: WalletTheme.button(
                    text: btnText, onPressed: btnOnPressed
                  )
                )
              ],
            ),
        )
      ),
    );
  }
}