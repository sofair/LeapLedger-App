part of 'enter.dart';

class AccountListBottomSheet extends StatefulWidget {
  const AccountListBottomSheet({super.key});

  @override
  State<AccountListBottomSheet> createState() => _AccountListBottomSheetState();
}

class _AccountListBottomSheetState extends State<AccountListBottomSheet> {
  @override
  void initState() {
    bloc = BlocProvider.of<FlowConditionBloc>(context);
    bloc.add(FlowConditionAccountDataFetchEvent());
    currentAccount = bloc.currentAccount;
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  late AccountDetailModel currentAccount;
  late FlowConditionBloc bloc;
  List<AccountDetailModel> list = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<FlowConditionBloc, FlowConditionState>(
      listener: (context, state) {
        if (state is FlowConditionAccountLoaded) {
          setState(() {
            list = state.data;
          });
        }
      },
      child: TextButton(
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
        onPressed: () {
          _showButtomSheet();
        },
        child: Row(
          children: [
            Icon(
              currentAccount.icon,
              size: 18,
            ),
            Text(currentAccount.name)
          ],
        ),
      ),
    );
  }

  _showButtomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: ConstantDecoration.bottomSheet,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(Constant.margin, Constant.margin, Constant.margin, 0),
                    child: Text(
                      '切换账本',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: ListView.separated(
                    itemBuilder: (_, int index) {
                      var account = list[index];
                      return ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 4,
                              height: double.infinity,
                              color: account.id == currentAccount.id ? Colors.blue : Colors.white,
                            ),
                            Icon(account.icon)
                          ],
                        ),
                        title: Text(account.name),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                        onTap: () {
                          onUpdateAccount(account);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return ConstantWidget.divider.list;
                    },
                    itemCount: list.length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  void onUpdateAccount(AccountDetailModel account) {
    var bloc = BlocProvider.of<FlowConditionBloc>(context);
    bloc.add(FlowConditionAccountUpdateEvent(account));
    setState(() {
      currentAccount = account;
    });
  }
}
