import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/bottom_bar.dart';
import 'package:fusecash/screens/buy/buy.dart';
import 'package:fusecash/screens/cash_home/cash_header.dart';
import 'package:fusecash/screens/cash_home/cash_home.dart';
import 'package:fusecash/screens/send/contacts_list.dart';
import 'package:fusecash/screens/send/receive.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/widgets/bottom_bar_item.dart';
import 'package:fusecash/widgets/drawer.dart';
import 'package:fusecash/widgets/my_app_bar.dart';
import 'package:fusecash/widgets/tabs_scaffold.dart';

class CashModeScaffold extends StatefulWidget {
  final int tabIndex;
  CashModeScaffold({Key key, this.tabIndex = 0}) : super(key: key);
  @override
  _CashModeScaffoldState createState() => _CashModeScaffoldState();
}

class _CashModeScaffoldState extends State<CashModeScaffold> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tabIndex;
  }

  List<Widget> _pages(List<Contact> contacts) {
    bool hasContactsInStore = contacts.isNotEmpty;
    return [
      CashHomeScreen(),
      !hasContactsInStore
          ? SendToContactScreen()
          : ContactsList(contacts: contacts),
      BuyScreen(),
      ReceiveScreen()
    ];
  }

  _onTap(int itemIndex) {
    setState(() {
      _currentIndex = itemIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BottomBarViewModel>(
        converter: BottomBarViewModel.fromStore,
        builder: (_, vm) {
          final List<Widget> pages = _pages(vm.contacts);
          return TabsScaffold(
              header: MyAppBar(
                backgroundColor: Colors.white,
                child: CashHeader(),
              ),
              drawerEdgeDragWidth: 0,
              pages: pages,
              currentIndex: _currentIndex,
              drawer: DrawerWidget(),
              bottomNavigationBar: BottomNavigationBar(
                onTap: _onTap,
                selectedFontSize: 13,
                unselectedFontSize: 13,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                backgroundColor: Theme.of(context).bottomAppBarColor,
                showUnselectedLabels: true,
                items: [
                  bottomBarItem(I18n.of(context).home, 'home'),
                  bottomBarItem(I18n.of(context).send_button, 'send'),
                  bottomBarItem(I18n.of(context).buy, 'buy'),
                  bottomBarItem(I18n.of(context).receive, 'receive'),
                ],
              ));
        });
  }
}
