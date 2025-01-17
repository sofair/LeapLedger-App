part of '../transaction_edit.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  late EditBloc _bloc;
  @override
  void initState() {
    _bloc = BlocProvider.of<EditBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditBloc, EditState>(
      listener: (context, state) {
        if (state is AccountChanged) {
          setState(() {});
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildCard(),
          AmountKeyboard(onRefresh: onRefreshKeyborad, onComplete: onComplete, openAgain: _bloc.canAgain),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
        decoration: ConstantDecoration.cardDecoration,
        margin: EdgeInsets.symmetric(horizontal: Constant.margin),
        padding: EdgeInsets.all(Constant.smallPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildButtonGroup(),
            AmountText.sameHeight(
              _bloc.transInfo.amount,
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
              dollarSign: true,
            ),
            const Divider(),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      keyboradHistory,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: ConstantFontSize.bodySmall),
                    ),
                    SizedBox(width: Constant.margin / 4),
                    Text(
                      keyboradInput,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: ConstantFontSize.headline),
                    )
                  ],
                ))
          ],
        ));
  }

  Widget _buildButtonGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: _bloc.mode != TransactionEditMode.popTrans,
          child: GestureDetector(
            onTap: () async {
              var page = AccountRoutes.userConfig(context, accoount: _bloc.account);
              await page.showDialog();
            },
            child: const Icon(Icons.more_vert_outlined),
          ),
        ),
        Visibility(
          visible: _bloc.mode != TransactionEditMode.popTrans,
          child: _buildButton(
              onPressed: () async {
                var page = TransactionRoutes.timingNavigator(context, account: _bloc.account, trans: _bloc.transInfo);
                Navigator.pop(context);
                await page.push();
              },
              name: "定时",
              icon: Icons.timer_outlined),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 日期
            _buildDateButton(),
            // 账本
            _buildButton(
                onPressed: () async {
                  if (_bloc.mode == TransactionEditMode.popTrans) return;
                  var page = AccountRoutes.list(context, selectedAccount: _bloc.account);
                  await page.showModalBottomSheet(onlyCanEdit: true);
                  AccountDetailModel? resule = page.retrunAccount;
                  if (resule == null) {
                    return;
                  }
                  _bloc.add(AccountChange(resule));
                },
                name: _bloc.account.name),
            _buildButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CommonDialog.editOne<String>(
                          context,
                          fieldName: "备注",
                          onSave: (String? value) => _bloc.transInfo.remark = value ?? "",
                          initValue: _bloc.transInfo.remark,
                        );
                      });
                },
                name: "备注"),
          ],
        )
      ],
    );
  }

  Widget _buildDateButton() {
    var tradeTime = _bloc.getTZDateTime(_bloc.transInfo.tradeTime);
    var nowTime = _bloc.nowTime;
    String buttonName = DateFormat('yyyy-MM-dd').format(tradeTime);
    if (Time.isSameDayComparison(tradeTime, DateTime.now())) {
      buttonName += " 今天";
    }
    return _buildButton(
        onPressed: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: _bloc.account.getTZDateTime(tradeTime),
            currentDate: nowTime,
            firstDate: Constant.minDateTime,
            lastDate: Constant.maxDateTime,
          );
          if (picked == null) {
            return;
          }
          onChangeTradeTime(Tz.getNewByDate(picked, _bloc.location));
        },
        name: buttonName,
        icon: Icons.access_time_outlined);
  }

  Widget _buildButton({required Function onPressed, required String name, IconData? icon}) {
    return Padding(
      padding: EdgeInsets.only(left: Constant.smallPadding),
      child: GestureDetector(
          onTap: () => onPressed(),
          child: Chip(
              padding: const EdgeInsets.all(2),
              side: BorderSide.none,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(48)),
              ),
              backgroundColor: ConstantColor.secondaryColor,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Icon(
                        icon,
                        color: ConstantColor.primaryColor,
                        size: ConstantFontSize.bodySmall,
                      ),
                    ),
                  Text(
                    name,
                    style: TextStyle(color: ConstantColor.primaryColor, fontSize: ConstantFontSize.bodySmall),
                  )
                ],
              ))),
    );
  }

  String keyboradInput = "", keyboradHistory = "";

  /* event */
  void onComplete(bool isAgain, int? amount) => _bloc.add(TransactionSave(isAgain, amount: amount));

  void onRefreshKeyborad(int amount, String input, String history) {
    setState(() {
      _bloc.transInfo.amount = amount;
      keyboradInput = input;
      keyboradHistory = history;
    });
  }

  void onChangeTradeTime(DateTime time) {
    if (false == Time.isSameDayComparison(_bloc.transInfo.tradeTime, time)) {
      setState(() {
        _bloc.transInfo.tradeTime = time;
      });
    }
  }
}
