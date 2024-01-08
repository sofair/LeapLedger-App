part of '../transaction_edit.dart';

class Bottom extends StatefulWidget {
  const Bottom({
    required this.model,
    super.key,
    required this.account,
    required this.onComplete,
    required this.mode,
    required this.isAgain,
  });

  final TransactionEditModel model;

  final AccountModel account;

  final Function({required int amount, required DateTime tradeTime, required String remark, required bool isAgain})
      onComplete;

  final TransactionEditMode mode;

  final bool isAgain;
  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  late TransactionEditModel model;
  late AccountModel account;
  @override
  void initState() {
    model = widget.model;
    account = widget.account;
    model.accountId = account.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    account = BlocProvider.of<EditBloc>(context).account;
    return BlocListener<EditBloc, EditState>(
      listener: (context, state) {
        if (state is AccountChanged) {
          setState(() {
            account = state.account;
          });
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildCard(),
          AmountKeyboard(onRefresh: onRefreshKeyborad, onComplete: onComplete, openAgain: widget.isAgain),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
        decoration: ConstantDecoration.cardDecoration,
        margin: const EdgeInsets.symmetric(horizontal: Constant.margin),
        padding: const EdgeInsets.all(Constant.smallPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildButtonGroup(),
            SameHightAmountTextSpan(
              amount: model.amount,
              textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
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
                      style: const TextStyle(fontSize: ConstantFontSize.bodySmall),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      keyboradInput,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: ConstantFontSize.headline),
                    )
                  ],
                ))
          ],
        ));
  }

  Widget _buildButtonGroup() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 日期
        _buildDateButton(),
        // 账本
        _buildButton(
            onPressed: () async {
              AccountModel? resule = await AccountRoutes.showAccountListButtomSheet(context, currentAccount: account);
              if (resule == null) {
                return;
              }
              print(resule.hashCode);
              BlocProvider.of<EditBloc>(context).add(AccountChange(resule));
            },
            name: account.name),
        _buildButton(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditDialog("备注", null, model.remark, onChanegRemark);
                  });
            },
            name: "备注"),
      ],
    );
  }

  Widget _buildDateButton() {
    String buttonName = DateFormat('yyyy-MM-dd').format(model.tradeTime);
    if (Time.isSameDayComparison(model.tradeTime, DateTime.now())) {
      buttonName += " 今天";
    }
    return _buildButton(
        onPressed: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: model.tradeTime,
            firstDate: Constant.minDateTime,
            lastDate: Constant.maxDateTime,
          );
          if (picked == null) {
            return;
          }
          onChangeTradeTime(picked);
        },
        name: buttonName,
        icon: Icons.access_time_outlined);
  }

  Widget _buildButton({required Function onPressed, required String name, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: Constant.smallPadding),
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
                    style: const TextStyle(color: ConstantColor.primaryColor, fontSize: ConstantFontSize.bodySmall),
                  )
                ],
              ))),
    );
  }

  String keyboradInput = "", keyboradHistory = "";

// 事件
  void onComplete(int amount, bool isAgain) {
    widget.onComplete(amount: amount, tradeTime: model.tradeTime, remark: model.remark, isAgain: isAgain);
  }

  void onRefreshKeyborad(int amount, String input, String history) {
    setState(() {
      model.amount = amount;
      keyboradInput = input;
      keyboradHistory = history;
    });
  }

  void onChangeTradeTime(DateTime time) {
    if (false == Time.isSameDayComparison(model.tradeTime, time)) {
      setState(() {
        model.tradeTime = time;
      });
    }
  }

  void onChangeAccount(AccountModel result) {
    BlocProvider.of<EditBloc>(context).add(AccountChange(result));
  }

  void onChanegRemark(String remark) {
    model.remark = remark;
  }
}
