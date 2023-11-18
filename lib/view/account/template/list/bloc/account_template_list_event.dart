part of 'account_template_list_bloc.dart';

sealed class AccountTemplateListEvent {}

class GetListEvent extends AccountTemplateListEvent {}

class UseAccountTemplate extends AccountTemplateListEvent {
  final AccountTemplateModel template;
  UseAccountTemplate(this.template);
}
