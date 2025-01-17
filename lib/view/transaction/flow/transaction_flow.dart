import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leap_ledger_app/bloc/transaction/transaction_bloc.dart';
import 'package:leap_ledger_app/common/global.dart';
import 'package:leap_ledger_app/model/account/model.dart';
import 'package:leap_ledger_app/model/common/model.dart';
import 'package:leap_ledger_app/model/transaction/model.dart';
import 'package:leap_ledger_app/routes/routes.dart';
import 'package:leap_ledger_app/util/enter.dart';
import 'package:leap_ledger_app/view/transaction/flow/bloc/enter.dart';
import 'package:leap_ledger_app/view/transaction/flow/widget/enter.dart';
import 'package:leap_ledger_app/widget/amount/enter.dart';
import 'package:shimmer/shimmer.dart';

class TransactionFlow extends StatefulWidget {
  final TransactionQueryCondModel? condition;
  final AccountDetailModel account;
  const TransactionFlow({this.condition, required this.account, super.key});

  @override
  State<TransactionFlow> createState() => _TransactionFlowState();
}

enum PageStatus { loading, loaded, refreshing, moreDataFetching, noMoreData }

class _TransactionFlowState extends State<TransactionFlow> {
  late final FlowConditionCubit _conditionCubit;
  late final FlowListBloc _flowListBloc;
  PageStatus currentState = PageStatus.loading;

  late final ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _conditionCubit = FlowConditionCubit(condition: widget.condition, account: widget.account)..fetchCategoryData();
    _flowListBloc = FlowListBloc(initCondition: _conditionCubit.condition);

    _flowListBloc.add(FlowListDataFetchEvent(account: _conditionCubit.account));
    super.initState();
    _scrollController = ScrollController();
    data = shimmerData;
  }

  void dispose() {
    _flowListBloc.close();
    _conditionCubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onFetchMoreData() {
    if (currentState != PageStatus.noMoreData) {
      _flowListBloc.add(FlowListMoreDataFetchEvent());
      currentState = PageStatus.moreDataFetching;
    }
  }

  Map<InExStatisticWithTimeModel, List<TransactionModel>> data = {};

  Widget listener(Widget child) {
    // 条件bloc
    child = BlocListener<FlowConditionCubit, FlowConditionState>(
      listener: (context, state) {
        if (state is FlowConditionChanged) {
          _flowListBloc.add(FlowListDataFetchEvent(condition: state.condition, account: _conditionCubit.account));
        }
      },
      child: child,
    );
    // 交易bloc
    child = BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionAddSuccess) {
          _flowListBloc.add(FlowListTransactionAddEvent(state.trans));
        } else if (state is TransactionUpdateSuccess) {
          _flowListBloc.add(FlowListTransactionUpdateEvent(state.oldTrans, state.newTrans));
        } else if (state is TransactionDeleteSuccess) {
          _flowListBloc.add(FlowListTransactionDeleteEvent(state.delTrans));
        }
      },
      child: child,
    );
    return child;
  }

  double lastDy = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FlowListBloc>.value(value: _flowListBloc),
          BlocProvider<FlowConditionCubit>.value(value: _conditionCubit),
        ],
        child: listener(
          Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text("流水"),
              actions: _buildActions(),
            ),
            backgroundColor: ConstantColor.greyBackground,
            bottomNavigationBar: BlocBuilder<FlowListBloc, FlowListState>(
              builder: (context, state) {
                if (state is FlowLisMoreDataFetchingEvent) {
                  return Container(
                    height: 64,
                    alignment: Alignment.center,
                    child: const CupertinoActivityIndicator(),
                  );
                }
                return const SizedBox();
              },
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Constant.padding),
              child: RefreshIndicator(
                onRefresh: () async => _flowListBloc.add(FlowListDataFetchEvent(account: _conditionCubit.account)),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
                      _onFetchMoreData();
                    }
                    return false;
                  },
                  child: _buildCustomScrollView(),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildCustomScrollView() {
    return BlocBuilder<FlowListBloc, FlowListState>(
        buildWhen: (_, state) =>
            state is FlowListLoading || state is FlowListLoaded || state is FlowListMoreDataFetched,
        builder: (context, state) {
          if (state is FlowListLoading) {
            if (data.isEmpty) data = shimmerData;
            currentState = PageStatus.loading;
          } else if (state is FlowListLoaded || state is FlowListMoreDataFetched) {
            data = _flowListBloc.list;
            if (false == _flowListBloc.hasMore) {
              currentState = PageStatus.noMoreData;
            } else {
              currentState = PageStatus.loaded;
            }
          }
          Widget headerCard = const HeaderCard();
          if (currentState != PageStatus.loading && currentState != PageStatus.refreshing) {
            _buildOneTransactionFunc = _buildListTile;
            _buildDateFunc = _buildDate;
          } else {
            _buildOneTransactionFunc = (TransactionModel model) => _buildShimmer(_buildListTile(model));
            _buildDateFunc =
                (TransactionModel trans, TransactionModel? lastTrans) => _buildShimmer(_buildDate(trans, lastTrans));
            headerCard = headerCard;
          }
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(padding: EdgeInsets.symmetric(vertical: Constant.padding), child: headerCard),
              ),
              ...buildMonthStatisticGroupList()
            ],
          );
        });
  }

  List<Widget> _buildActions() {
    return [
      TextButton(
        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
        onPressed: () async {
          var page = AccountRoutes.list(context, selectedAccount: _conditionCubit.account);
          await page.showModalBottomSheet();
          if (page.retrunAccount != null) {
            _conditionCubit.updateAccount(page.retrunAccount!);
          }
        },
        child: BlocBuilder<FlowConditionCubit, FlowConditionState>(
          buildWhen: (_, state) => state is FlowCurrentAccountChanged,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_conditionCubit.account.icon, size: Constant.iconSize),Text(_conditionCubit.account.name)
              ],
            );
          },
        ),
      ),
      IconButton(
        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
        onPressed: () => TransactionRoutes.chartNavigator(
          context,
          account: _conditionCubit.account,
          startDate: _conditionCubit.condition.startTime,
          endDate: _conditionCubit.condition.endTime,
        ).push(),
        icon: Icon(Icons.pie_chart_outline_outlined, color: ConstantColor.primaryColor, size: Constant.iconSize),
      ),
      Builder(builder: (context) {
        return IconButton(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                transitionAnimationController: AnimationController(
                  animationBehavior: AnimationBehavior.preserve,
                  vsync: Scaffold.of(context),
                  duration: Duration(milliseconds: 600),
                )..drive(CurveTween(curve: Curves.easeInOut)),
                builder: (BuildContext context) {
                  return BlocProvider.value(
                    value: _conditionCubit,
                    child: const ConditionBottomSheet(),
                  );
                });
          },
          icon: const Icon(
            Icons.filter_alt_outlined,
            color: ConstantColor.primaryColor,
          ),
        );
      })
    ];
  }

  List<Widget> buildMonthStatisticGroupList() {
    List<SliverMainAxisGroup> result = [];
    data.forEach((key, value) {
      if (value.isNotEmpty) {
        result.add(buildMonthStatisticGroup(key, value));
      }
    });

    if (result.isEmpty) {
      return [
        const SliverToBoxAdapter(
          child: SizedBox(height: 200, child: Center(child: Text("没有收支记录"))),
        ),
      ];
    }
    return result;
  }

  /// 月统计和交易列表
  SliverMainAxisGroup buildMonthStatisticGroup(InExStatisticWithTimeModel apiModel, List<TransactionModel> list) {
    return SliverMainAxisGroup(slivers: [
      SliverPersistentHeader(
        pinned: true,
        delegate: MonthStatisticHeaderDelegate(apiModel),
      ),
      _buildSliverList(list),
    ]);
  }

  TransactionModel? lastTrans;

  /// 交易列表
  Widget _buildSliverList(List<TransactionModel> list) {
    List<Widget> widgetlist = [];
    for (var i = 0; i < list.length; i++) {
      widgetlist.addAll([_buildDateFunc(list[i], i == 0 ? null : list[i - 1]), _buildOneTransactionFunc(list[i])]);
    }
    return SliverPadding(
      padding: EdgeInsets.only(bottom: Constant.margin),
      sliver: DecoratedSliver(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Constant.radius),
            bottomRight: Radius.circular(Constant.radius),
          ),
        ),
        sliver: SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgetlist)),
      ),
    );
  }

  bool get isShareAccount => _conditionCubit.account.isShare;

  /// 单条交易
  late Widget Function(TransactionModel model) _buildOneTransactionFunc;
  late Widget Function(TransactionModel currentTrans, TransactionModel? lastTrans) _buildDateFunc;
  Widget _buildListTile(TransactionModel model) {
    String subtitleStr = model.categoryFatherName;
    if (isShareAccount) subtitleStr += "  ${model.userName}";
    return ListTile(
      dense: true,
      onTap: () => TransactionRoutes.detailNavigator(
        context,
        account: _conditionCubit.account,
        transaction: model,
      ).showModalBottomSheet(),
      titleAlignment: ListTileTitleAlignment.center,
      leading: Icon(model.categoryIcon, color: ConstantColor.primaryColor),
      title: Text(
        model.categoryName,
      ),
      subtitle: Text(
        subtitleStr,
      ),
      trailing: AmountText.sameHeight(
        model.amount,
        textStyle: TextStyle(fontSize: ConstantFontSize.headline, fontWeight: FontWeight.normal),
        incomeExpense: model.incomeExpense,
        displayModel: IncomeExpenseDisplayModel.symbols,
      ),
    );
  }

  /// 列表分割线
  Widget _buildDate(TransactionModel currentTrans, TransactionModel? lastTrans) {
    if (lastTrans != null && Time.isSameDayComparison(currentTrans.tradeTime, lastTrans.tradeTime)) {
      return ConstantWidget.divider.indented;
    } else {
      return Padding(
        padding: EdgeInsets.only(left: Constant.padding),
        child: Text(
          DateFormat.d().format(widget.account.getTZDateTime(currentTrans.tradeTime)),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: ConstantFontSize.body),
        ),
      );
    }
  }

  /// Shimmer
  final Map<InExStatisticWithTimeModel, List<TransactionModel>> shimmerData = {
    InExStatisticWithTimeModel(startTime: Time.getFirstSecondOfMonth(), endTime: Time.getLastSecondOfMonth()): [
      TransactionModel.prototypeData(),
      TransactionModel.prototypeData(),
      TransactionModel.prototypeData(),
      TransactionModel.prototypeData()
    ],
    InExStatisticWithTimeModel(
      startTime: Time.getFirstSecondOfPreviousMonths(numberOfMonths: 1),
      endTime: Time.getFirstSecondOfPreviousMonths(numberOfMonths: 1),
    ): [
      TransactionModel.prototypeData(),
      TransactionModel.prototypeData(),
      TransactionModel.prototypeData(),
      TransactionModel.prototypeData()
    ]
  };
  Widget _buildShimmer(Widget child) {
    return Shimmer.fromColors(
      baseColor: ConstantColor.shimmerBaseColor,
      highlightColor: ConstantColor.shimmerHighlightColor,
      child: child,
    );
  }
}
