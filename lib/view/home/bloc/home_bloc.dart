import 'package:bloc/bloc.dart';
import 'package:keepaccount_app/api/api_server.dart';
import 'package:keepaccount_app/api/model/model.dart';
import 'package:keepaccount_app/bloc/user/user_bloc.dart';
import 'package:keepaccount_app/common/global.dart';
import 'package:keepaccount_app/util/enter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeFetchDataEvent>(_fetchData);
  }

  late UserHomeApiModel data;
  static final startTime = Time.getFirstSecondOfMonth(date: DateTime.now()),
      endTime = Time.getLastSecondOfMonth(date: DateTime.now());
  _fetchData(HomeFetchDataEvent event, emit) async {
    await Future.wait([
      Future(() async {
        data = await UserApi.getHome(accountId: UserBloc.currentAccount.id);
        if (data.headerCard != null) {
          emit(HomeHeaderLoaded(data.headerCard!));
        }
        if (data.timePeriodStatistics != null) {
          emit(HomeTimePeriodStatisticsLoaded(data.timePeriodStatistics!));
        }
      }),
      Future(() => _fetchDayStatistic(event, emit)),
      Future(() => _fetchTransactionCategoryAmountRank(event, emit))
    ]);
  }

  _fetchDayStatistic(HomeFetchDataEvent event, emit) async {
    var dayStatistic = await TransactionApi.getDayStatistic(
        accountId: UserBloc.currentAccount.id, startTime: startTime, endTime: endTime);
    if (dayStatistic.isNotEmpty) {
      emit(HomeStatisticsLineChart(dayStatistic));
    }
  }

  _fetchTransactionCategoryAmountRank(HomeFetchDataEvent event, emit) async {
    var rankingList = await TransactionApi.getCategoryAmountRank(
      accountId: UserBloc.currentAccount.id,
      ie: IncomeExpense.expense,
      limit: 9,
      startTime: startTime,
      endTime: endTime,
    );
    emit(HomeCategoryAmountRank(rankingList));
  }
}
