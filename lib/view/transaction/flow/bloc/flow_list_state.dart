part of 'enter.dart';

@immutable
sealed class FlowListState {}

final class FlowListLoading extends FlowListState {}

final class FlowListLoaded extends FlowListState {
  final Map<IncomeExpenseStatisticApiModel, List<TransactionModel>> data;
  final bool hasMore;
  FlowListLoaded(this.data, this.hasMore);
}

final class FlowListMoreDataFetched extends FlowListState {
  final Map<IncomeExpenseStatisticApiModel, List<TransactionModel>> data;
  final bool hasMore;
  FlowListMoreDataFetched(this.data, this.hasMore);
}

final class FlowListTotalDataFetched extends FlowListState {
  final IncomeExpenseStatisticApiModel data;
  FlowListTotalDataFetched(this.data);
}
