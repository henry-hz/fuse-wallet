import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/splash.dart';
import 'package:fusecash/widgets/on_boarding_pages.dart';
import 'package:redux/redux.dart';
import 'dots_indicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController = new PageController();
  static const _kDuration = const Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;
  bool isOpen = false;
  PageController _slideController;
  ValueNotifier<double> notifier;
  int _previousPage;
  final _controller = new PageController();

  void _onScroll() {
    if (_pageController.page.toInt() == _pageController.page) {
      _previousPage = _pageController.page.toInt();
    }
    notifier?.value = _pageController.page - _previousPage;

    _slideController.animateToPage(_pageController.page.toInt(),
        duration: null, curve: null);
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);

    notifier = ValueNotifier<double>(0);

    _previousPage = _pageController.initialPage;
    super.initState();
  }

  void gotoPage(page) {
    _pageController.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, SplashViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          return SplashViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          var drawer = Drawer();
          List pages = getPages(context);
          return Scaffold(
              drawer: drawer,
              body: new StoreBuilder(onInitialBuild: (store) {
                if (viewModel.privateKey != '' &&
                    viewModel.jwtToken != '' &&
                    !viewModel.isLoggedOut) {
                  viewModel.initWeb3(viewModel.privateKey);
                  if (Navigator.canPop(context)) {
                    Navigator.popUntil(context, ModalRoute.withName('/Cash'));
                  } else {
                    Navigator.pushReplacementNamed(context, '/Cash');
                  }
                }
              }, builder: (BuildContext context, Store<AppState> store) {
                return Container(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 20,
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          Expanded(
                            child: new Stack(
                              children: <Widget>[
                                new PageView.builder(
                                  physics: new AlwaysScrollableScrollPhysics(),
                                  controller: _controller,
                                  itemCount: pages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return pages[index % pages.length];
                                  },
                                ),
                                new Positioned(
                                  bottom: 15.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: new Container(
                                    padding: const EdgeInsets.all(20.0),
                                    child: new Center(
                                      child: new DotsIndicator(
                                        controller: _controller,
                                        itemCount: pages.length,
                                        onPageSelected: (int page) {
                                          gotoPage(page);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ),
                  ],
                ));
              }));
        });
  }
}
