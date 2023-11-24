part of 'enter.dart';

sealed class PtcCardState {}

final class PtcCardInitial extends PtcCardState {}

final class PtcCardLoad extends PtcCardState {
  final List<ProductTransactionCategoryModel> ptcList;
  PtcCardLoad(this.ptcList);
}
