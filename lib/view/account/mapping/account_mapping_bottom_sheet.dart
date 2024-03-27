import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/account/model.dart';
import 'package:keepaccount_app/view/account/mapping/cubit/account_mapping_cubit.dart';
import 'package:keepaccount_app/widget/common/common.dart';

class AccountMappingBottomSheet extends StatefulWidget {
  const AccountMappingBottomSheet({super.key, required this.mainAccount, this.mapping});
  final AccountModel mainAccount;
  final AccountMappingModel? mapping;
  @override
  State<AccountMappingBottomSheet> createState() => _AccountMappingBottomSheetState();
}

class _AccountMappingBottomSheetState extends State<AccountMappingBottomSheet> {
  late AccountMappingCubit _cubit;
  @override
  void initState() {
    _cubit = AccountMappingCubit(widget.mainAccount, mapping: widget.mapping);
    _cubit.fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountMappingCubit>.value(
      value: _cubit,
      child: Container(
        decoration: ConstantDecoration.bottomSheet,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(Constant.margin, Constant.margin, Constant.margin, 0),
                child: Text(
                  '账本关联',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: ConstantFontSize.largeHeadline),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.0,
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<AccountMappingCubit, AccountMappingState>(builder: (context, state) {
      if (state is AccountListLoad) {
        if (_cubit.list.isNotEmpty) {
          return ListView.separated(
            itemBuilder: (_, int index) {
              var account = _cubit.list[index];
              return CommonListTile.fromAccountDetailModel(
                account,
                onSelect: _cubit.mapping != null && _cubit.mapping!.relatedAccount.id == account.id,
                ontap: () {
                  _cubit.changeMapping(account);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return ConstantWidget.divider.list;
            },
            itemCount: _cubit.list.length,
          );
        } else {
          return Center(child: NoData.accountText(context));
        }
      }
      return const Center(child: ConstantWidget.activityIndicator);
    });
  }

  void onUpdateAccount(AccountModel account) {
    Navigator.pop<AccountModel>(context, account);
  }
}
