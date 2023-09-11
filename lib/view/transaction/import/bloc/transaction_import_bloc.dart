import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/model/product/model.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';

part 'transaction_import_event.dart';
part 'transaction_import_state.dart';

class TransactionImportBloc extends Bloc<TransactionImportEvent, TransactionImportState> {
  final String uniqueKey;
  List<ProductTransactionCategoryModel> list = [];
  List<ProductTransactionCategoryModel> unmapped = [];
  Map<int, List<ProductTransactionCategoryModel>> relation = {};
  TransactionImportBloc(this.uniqueKey) : super(TransactionImportInitial()) {
    on<TransactionImportLoadEvent>(load);
    on<TransactionImportMappingEvent>(mapping);
  }

  load(TransactionImportLoadEvent event, Emitter<TransactionImportState> emit) async {
    ResponseBody responseBody = await ProductApi.getTransactionCategory(uniqueKey);
    ResponseBody treeResponse = await ProductApi.getCategorymappingTree(uniqueKey);
    if (responseBody.isSuccess && treeResponse.isSuccess) {
      Map<int, ProductTransactionCategoryModel> unmappedMap = {};
      list = [];
      for (Map<String, dynamic> data in responseBody.data['List']) {
        ProductTransactionCategoryModel model = ProductTransactionCategoryModel.fromJson(data);
        list.add(model);
        unmappedMap[model.id] = model;
      }
      relation = {};
      List<ProductTransactionCategoryModel> child;
      if (treeResponse.data['Tree'] != null) {
        for (Map<String, dynamic> data in treeResponse.data['Tree']) {
          child = [];
          if (data['Children'] != null) {
            for (int childId in data['Children']) {
              if (unmappedMap[childId] != null) {
                child.add(unmappedMap[childId]!);
                unmappedMap.remove(childId);
              }
            }
          }
          relation[data['FatherId']] = child;
        }
      }
      unmapped = unmappedMap.values.toList();
      emit(TransactionImportLoadedState(unmapped, relation));
    }
  }

  mapping(TransactionImportMappingEvent event, Emitter<TransactionImportState> emit) async {
    ResponseBody responseBody =
        await ProductApi.mappingTransactionCategory(event.transactionCategory, event.productTransactionCategory);
    if (responseBody.isSuccess) {
      if (relation[event.transactionCategory.id] != null) {
        relation[event.transactionCategory.id]?.add(event.productTransactionCategory);
      } else {
        relation[event.transactionCategory.id] = [event.productTransactionCategory];
      }
      unmapped.removeWhere((element) => event.productTransactionCategory.id == element.id);

      emit(TransactionImportLoadedState(unmapped, relation));
    }
  }

  deleteMapping(TransactionImportMappingEvent event, Emitter<TransactionImportState> emit) async {
    ResponseBody responseBody =
        await ProductApi.deleteTransactionCategoryMapping(event.transactionCategory, event.productTransactionCategory);
    if (responseBody.isSuccess) {
      if (relation[event.transactionCategory.id] != null) {
        relation[event.transactionCategory.id]
            ?.removeWhere((element) => event.productTransactionCategory.id == element.id);
      } else {
        relation[event.transactionCategory.id] = [event.productTransactionCategory];
      }
      unmapped.add(event.productTransactionCategory);
      emit(TransactionImportLoadedState(unmapped, relation));
    }
  }

  uploadFile(TransactionImportUploadBillEvent event, Emitter<TransactionImportState> emit) async {
    ResponseBody responseBody = await ProductApi.uploadBill(uniqueKey, event.filePath);
    if (responseBody.isSuccess) {}
  }
}
