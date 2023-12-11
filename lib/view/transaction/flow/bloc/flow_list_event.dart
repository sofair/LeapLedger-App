part of 'enter.dart';

@immutable
sealed class FlowListEvent {}

class FlowListDataFetchEvent extends FlowListEvent {
  final TransactionQueryConditionApiModel condition;
  FlowListDataFetchEvent(this.condition);
}

class FlowListMoreDataFetchEvent extends FlowListEvent {
  FlowListMoreDataFetchEvent();
}

class FlowListUpdateConditionEvent extends FlowListEvent {
  FlowListUpdateConditionEvent();
}
