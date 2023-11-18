part of 'account_template_list_bloc.dart';

sealed class AccountTemplateListState {}

final class AccountTemplateListInitial extends AccountTemplateListState {}

final class AccountTemplateListLoading extends AccountTemplateListState {}

final class AccountTemplateListLoaded extends AccountTemplateListState {
  final List<AccountTemplateModel> list;
  AccountTemplateListLoaded(this.list);
}

final class AddAccountSuccess extends AccountTemplateListState {
  final AccountModel account;
  AddAccountSuccess(this.account);
}
