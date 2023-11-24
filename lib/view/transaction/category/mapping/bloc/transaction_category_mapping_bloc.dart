import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/model/product/model.dart';
import 'package:keepaccount_app/model/transaction/category/model.dart';

part 'transaction_category_mapping_event.dart';
part 'transaction_category_mapping_state.dart';

class TransactionCategoryMappingBloc extends Bloc<TransactionCategoryMappingEvent, TransactionCategoryMappingState> {
  final ProductModel product;
  List<ProductTransactionCategoryModel>? ptcList;
  List<ProductTransactionCategoryModel> unmapped = [];
  //交易类型id与产品交易类型关联
  Map<int, List<ProductTransactionCategoryModel>> relation = {};
  TransactionCategoryMappingBloc(this.product, {this.ptcList}) : super(TransactionCategoryMappingInitial()) {
    on<TransactionCategoryMappingLoadEvent>(load);
    on<TransactionCategoryMappingAddEvent>(mapping);
    on<TransactionCategoryMappingDeleteEvent>(deleteMapping);
  }

  load(TransactionCategoryMappingLoadEvent event, Emitter<TransactionCategoryMappingState> emit) async {
    ResponseBody treeResponse = await ProductApi.getCategorymappingTree(product.uniqueKey);
    if (ptcList == null) {
      await _getPtcList();
    }
    if (treeResponse.isSuccess) {
      Map<int, ProductTransactionCategoryModel> unmappedMap = {};
      for (ProductTransactionCategoryModel ptc in ptcList!) {
        unmappedMap[ptc.id] = ptc;
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
      _emitLoaded(emit);
    }
  }

  _getPtcList() async {
    ResponseBody responseBody = await ProductApi.getTransactionCategory(product.uniqueKey);
    ptcList = [];
    if (responseBody.isSuccess) {
      for (Map<String, dynamic> data in responseBody.data['List']) {
        ProductTransactionCategoryModel model = ProductTransactionCategoryModel.fromJson(data);
        ptcList!.add(model);
      }
    }
  }

  mapping(TransactionCategoryMappingAddEvent event, Emitter<TransactionCategoryMappingState> emit) async {
    ResponseBody responseBody =
        await ProductApi.mappingTransactionCategory(event.transactionCategory, event.productTransactionCategory);
    if (responseBody.isSuccess) {
      if (relation[event.transactionCategory.id] != null) {
        relation[event.transactionCategory.id]?.add(event.productTransactionCategory);
      } else {
        relation[event.transactionCategory.id] = [event.productTransactionCategory];
      }
      unmapped.removeWhere((element) => event.productTransactionCategory.id == element.id);

      _emitLoaded(emit, type: event.transactionCategory.incomeExpense);
    }
  }

  deleteMapping(TransactionCategoryMappingDeleteEvent event, Emitter<TransactionCategoryMappingState> emit) async {
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
      _emitLoaded(emit, type: event.transactionCategory.incomeExpense);
    }
  }

  uploadFile(TransactionCategoryMappingUploadBillEvent event, Emitter<TransactionCategoryMappingState> emit) async {
    ResponseBody responseBody = await ProductApi.uploadBill(product.uniqueKey, event.filePath);
    if (responseBody.isSuccess) {}
  }

  _emitLoaded(Emitter<TransactionCategoryMappingState> emit, {IncomeExpense? type}) {
    if (type == null || type == IncomeExpense.expense) {
      var emitUnmapped = unmapped.where((element) => element.incomeExpense == IncomeExpense.expense).toList();

      emit(TransactionCategoryMappingExpenseLoaded(emitUnmapped, relation));
    }
    if (type == null || type == IncomeExpense.income) {
      var emitUnmapped = unmapped.where((element) => element.incomeExpense == IncomeExpense.income).toList();

      emit(TransactionCategoryMappingIncomeLoaded(emitUnmapped, relation));
    }
  }
}
