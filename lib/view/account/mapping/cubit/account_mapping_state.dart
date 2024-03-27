part of 'account_mapping_cubit.dart';

@immutable
sealed class AccountMappingState {}

final class AccountMappingInitial extends AccountMappingState {}

final class AccountListLoad extends AccountMappingState {}

final class AccountMappingChanged extends AccountMappingState {}
