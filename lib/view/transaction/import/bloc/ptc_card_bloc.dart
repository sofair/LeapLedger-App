part of 'enter.dart';

class PtcCardBloc extends Bloc<PtcCardEvent, PtcCardState> {
  final ProductModel product;
  PtcCardBloc(this.product) : super(PtcCardInitial()) {
    on<FetchPtcList>(_load);
  }
  _load(FetchPtcList event, Emitter<PtcCardState> emit) async {
    ResponseBody responseBody = await ProductApi.getTransactionCategory(product.uniqueKey);
    List<ProductTransactionCategoryModel> ptcList = [];
    for (Map<String, dynamic> data in responseBody.data['List']) {
      ProductTransactionCategoryModel model = ProductTransactionCategoryModel.fromJson(data);
      ptcList.add(model);
    }
    emit(PtcCardLoad(ptcList));
  }
}
