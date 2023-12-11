part of 'enter.dart';

class FlowListBloc extends Bloc<FlowListEvent, FlowListState> {
  FlowListBloc() : super(FlowListLoading()) {
    on<FlowListDataFetchEvent>(_fetchData);
    on<FlowListMoreDataFetchEvent>(_fetchMoreData);
  }
  List<IncomeExpenseStatisticApiModel> monthStatistic = [];
  Map<IncomeExpenseStatisticApiModel, List<TransactionModel>> list = {};

  IncomeExpenseStatisticApiModel total = IncomeExpenseStatisticApiModel();
  TransactionQueryConditionApiModel condition = TransactionQueryConditionApiModel(
      accountId: UserBloc.currentAccount.id,
      startTime: DateTime(DateTime.now().year, DateTime.now().month - 6),
      endTime: DateTime.now());

  int offset = 0, limit = 10;
  _initList() {
    list = {};
    for (var element in monthStatistic) {
      list[element] = [];
    }
  }

  _fetchData(FlowListDataFetchEvent event, emit) async {
    emit(FlowListLoading());
    condition = event.condition;
    offset = 0;
    List<TransactionModel> result = [];
    await Future.wait([
      Future(() async {
        monthStatistic = await TransactionApi.getMonthStatistic(condition);
      }),
      Future(() async {
        result = await TransactionApi.getList(condition, limit, offset);
      })
    ]);
    // 处理列表数据
    offset = result.length;
    _initList();
    for (var element in result) {
      _setListData(element);
    }
    bool hasMore = list.isNotEmpty;
    emit(FlowListLoaded(list, hasMore));
    // 处理合计数据
    total = IncomeExpenseStatisticApiModel();
    if (monthStatistic.isNotEmpty) {
      for (var element in monthStatistic) {
        total.income.add(element.income);
        total.expense.add(element.expense);
      }
    }
    emit(FlowListTotalDataFetched(total));
  }

  _setListData(TransactionModel data) {
    var key = list.keys.firstWhere((element) {
      bool notInThisMonth = data.tradeTime.isBefore(element.startTime!) || element.endTime!.isBefore(data.tradeTime);
      return false == notInThisMonth;
    });

    list[key]!.add(data);
  }

  _fetchMoreData(FlowListMoreDataFetchEvent event, emit) async {
    var result = await TransactionApi.getList(condition, limit, offset);
    offset += result.length;
    final bool hasMore = result.isNotEmpty;
    for (var element in result) {
      _setListData(element);
    }
    emit(FlowListMoreDataFetched(list, hasMore));
  }
}
