import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'cash_transactions.dart';
import 'package:fusecash/models/views/cash_wallet.dart';

void onChange(CashWalletViewModel viewModel, BuildContext context) async {
  if (!viewModel.isJobProcessingStarted) {
    viewModel.startProcessingJobs();
  }
  if (!viewModel.isListeningToBranch) {
    viewModel.listenToBranch();
  }
  if (!viewModel.isCommunityLoading &&
      viewModel.branchAddress != null &&
      viewModel.branchAddress != "" &&
      viewModel.walletAddress != '') {
    viewModel.branchCommunityUpdate();
  }
  if (!viewModel.isCommunityLoading &&
      !viewModel.isCommunityFetched &&
      viewModel.isBranchDataReceived &&
      viewModel.walletAddress != '') {
    viewModel.switchCommunity(viewModel.communityAddress);
  }
  if (viewModel.token != null) {
    if (!viewModel.isTransfersFetchingStarted) {
      viewModel.startTransfersFetching();
    }
  }
  if (viewModel.identifier == null) {
    viewModel.setIdentifier();
  }
}

class CashHomeScreen extends StatelessWidget {
  onInit(store) async {
    String walletStatus = store.state.cashWalletState.walletStatus;
    String accountAddress = store.state.userState.accountAddress;
    if (walletStatus != 'deploying' &&
        walletStatus != 'created' &&
        accountAddress != '') {
      store.dispatch(createAccountWalletCall(accountAddress));
    }
    bool isPermitted = await Contacts.checkPermissions();
    if (isPermitted) {
      List<Contact> contacts = await ContactController.getContacts();
      store.dispatch(syncContactsCall(contacts));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: CashWalletViewModel.fromStore,
        onInit: onInit,
        onInitialBuild: (viewModel) async {
          onChange(viewModel, context);
        },
        onWillChange: (prevViewModel, nextViewModel) async {
          onChange(nextViewModel, context);
        },
        builder: (_, viewModel) {
          return Scaffold(
              key: key,
              body: Column(children: <Widget>[
                Expanded(
                    child: ListView(children: <Widget>[
                  CashTransactios(viewModel: viewModel)
                ])),
              ]));
        });
  }
}
