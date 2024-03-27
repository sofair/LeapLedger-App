part of 'enter.dart';

@immutable
sealed class FlowConditionEvent {}

class FlowConditionCategoryDataFetchEvent extends FlowConditionEvent {
  final int? accountId;
  FlowConditionCategoryDataFetchEvent({this.accountId});
}

class FlowConditionAccountDataFetchEvent extends FlowConditionEvent {
  FlowConditionAccountDataFetchEvent();
}

class FlowConditionDataUpdateEvent extends FlowConditionEvent {
  final TransactionQueryConditionApiModel condition;
  FlowConditionDataUpdateEvent(this.condition);
}

class FlowConditionAccountUpdateEvent extends FlowConditionEvent {
  final AccountDetailModel account;
  FlowConditionAccountUpdateEvent(this.account);
}

class FlowConditionTimeUpdateEvent extends FlowConditionEvent {
  final DateTime startTime, endTime;
  FlowConditionTimeUpdateEvent(this.startTime, this.endTime);
}
