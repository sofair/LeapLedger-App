part of 'enter.dart';

sealed class TransImportTabEvent {}

final class TransImportTabLoadedEvent extends TransImportTabEvent {}

final class TransactionImportUploadBillEvent extends TransImportTabEvent {
  final ProductModel product;
  final String filePath;
  TransactionImportUploadBillEvent(this.product, this.filePath);
}
