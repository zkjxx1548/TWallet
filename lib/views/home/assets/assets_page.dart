import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:optional/optional_internal.dart';
import 'package:provider/provider.dart';
import 'package:tw_wallet_ui/global/common/application.dart';
import 'package:tw_wallet_ui/global/common/get_it.dart';
import 'package:tw_wallet_ui/global/common/theme.dart';
import 'package:tw_wallet_ui/global/store/identity_store.dart';
import 'package:tw_wallet_ui/models/identity.dart';
import 'package:tw_wallet_ui/views/home/assets/point_tab.dart';
import 'package:tw_wallet_ui/views/home/assets/token_tab.dart';
import 'package:tw_wallet_ui/views/home/home.dart';
import 'package:tw_wallet_ui/views/home/home_store.dart';
import 'package:tw_wallet_ui/widgets/button.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage();

  @override
  State<StatefulWidget> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage>
    with SingleTickerProviderStateMixin {
  final IdentityStore _store = getIt<IdentityStore>();
  final Map<AssetsType, String> _tabs = {
    AssetsType.point: '积分',
    AssetsType.token: '资产'
  };

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    if (_store.identities.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _showAddIdentityDialog();
      });
    }
  }

  _showAddIdentityDialog() async {
    await showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => new SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
        children: <Widget>[
          Center(
              child: Text(
            '您还没有添加身份，请前往\"身份\"页面添加身份',
            style: TextStyle(
              fontSize: 15,
              height: 1.82,
            ),
            textAlign: TextAlign.center,
          )),
          Container(
              margin: EdgeInsets.only(top: 48),
              child: Button(
                width: 100,
                height: 40,
                text: '确定',
                onPressed: () {
                  Application.router.pop(context);
                  Provider.of<HomeStore>(context, listen: false)
                      .changePage(HomeState.identityIndex);
                },
              ))
        ],
      ),
    );
  }

  Widget buildHeader(
      {@required Optional<Identity> selectedIdentity,
      @required List<Identity> identities}) {
    List<Widget> children = <Widget>[
      Container(
        padding: EdgeInsets.all(15),
        child: selectedIdentity.isPresent
            ? CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'))
            : Container(),
      ),
      SizedBox(width: 10),
      Text(selectedIdentity.map((identity) => identity.name).orElse('')),
      Expanded(child: Container()),
    ];

    if (identities.length > 1) {
      children.add(
        PopupMenuButton(
          icon: Icon(Icons.apps),
          itemBuilder: (BuildContext context) {
            return identities
                .where((identity) =>
                    identity.name !=
                    selectedIdentity
                        .map((identity) => identity.name)
                        .orElse(''))
                .map((identity) => PopupMenuItem(
                    child: Text(identity.name), value: identity.name))
                .toList();
          },
          onSelected: (String value) {
            _store.selectIdentity(name: value);
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (context) {
        return Container(
            color: WalletTheme.titleBgColor,
            child: Column(children: <Widget>[
              buildHeader(
                  selectedIdentity: _store.selectedIdentity,
                  identities: _store.identities),
              TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  tabs: _tabs.values.map((t) => Tab(text: t)).toList()),
              Expanded(
                  child: Container(
                      color: WalletTheme.mainBgColor,
                      child: TabBarView(
                        controller: _tabController,
                        children: [PointTab(), TokenTab()],
                      ))),
            ]));
      });
}