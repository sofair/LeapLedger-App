import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leap_ledger_app/bloc/account/account_bloc.dart';
import 'package:leap_ledger_app/bloc/category/category_bloc.dart';
import 'package:leap_ledger_app/bloc/transaction/transaction_bloc.dart';
import 'package:leap_ledger_app/bloc/user/user_bloc.dart';

import 'package:leap_ledger_app/common/global.dart';
import 'package:leap_ledger_app/view/home/bloc/home_bloc.dart';
import 'package:leap_ledger_app/view/home/widget/enter.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc _bloc = HomeBloc(account: UserBloc.currentAccount);
  @override
  void initState() {
    _bloc.add(HomeFetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listenWhen: (_, state) => state is CurrentAccountChanged,
            listener: (_, state) => _bloc.add(HomeAccountChangeEvent(account: UserBloc.currentAccount)),
          ),
          BlocListener<AccountBloc, AccountState>(
            listenWhen: (_, state) => state is AccountTransCategoryInitSuccess,
            listener: (context, state) {
              if (state is AccountTransCategoryInitSuccess) _bloc.add(HomeFetchCategoryAmountRankDataEvent());
            },
          ),
          BlocListener<CategoryBloc, CategoryState>(
            listenWhen: (_, state) => state is CategoryUpdatedState && state.account.id == _bloc.account.id,
            listener: (context, state) {
              if (state is CategoryUpdatedState && state.account.id == _bloc.account.id)
                _bloc.add(HomeFetchCategoryAmountRankDataEvent());
            },
          ),
          BlocListener<TransactionBloc, TransactionState>(
            listenWhen: (_, state) => state is TransactionStatisticUpdate,
            listener: (context, state) {
              if (state is TransactionStatisticUpdate) {
                _bloc.add(HomeStatisticUpdateEvent(state.oldTrans, state.newTrans));
              }
            },
          ),
        ],
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return DecoratedBox(
      decoration: BoxDecoration(color: ConstantColor.greyBackground),
      child: RefreshIndicator(
          onRefresh: () async => _bloc.add(HomeFetchDataEvent()),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constant.padding, vertical: 0),
                child: SafeArea(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (_, state) => state is HomeHeaderLoaded,
                    builder: (context, state) {
                      if (_bloc.homeData.headerCard != null) {
                        return HeaderCard(data: _bloc.homeData.headerCard);
                      }
                      return HeaderCard();
                    },
                  ),
                ),
              ),
              SizedBox(height: Constant.margin / 2),
              BlocBuilder<UserBloc, UserState>(
                buildWhen: (_, state) => state is CurrentAccountChanged,
                builder: (context, state) {
                  return HomeNavigation(account: UserBloc.currentAccount);
                },
              ),
              SizedBox(height: Constant.margin / 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constant.padding, vertical: 0),
                child: BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (_, state) => state is HomeTimePeriodStatisticsLoaded,
                  builder: (context, state) {
                    if (_bloc.homeData.timePeriodStatistics != null) {
                      return TimePeriodStatistics(
                        data: _bloc.homeData.timePeriodStatistics,
                      );
                    }
                    return TimePeriodStatistics();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constant.padding, vertical: 0),
                child: BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (_, state) => state is HomeStatisticsLineChart,
                  builder: (context, state) {
                    if (_bloc.dayStatistic.isNotEmpty) {
                      return StatisticsLineChart(data: _bloc.dayStatistic);
                    }
                    return StatisticsLineChart(data: []);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constant.padding, vertical: 0),
                child: BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (_, state) => state is HomeCategoryAmountRank,
                  builder: (context, state) {
                    if (_bloc.rankingList.isNotEmpty) {
                      return CategoryAmountRank(data: _bloc.rankingList);
                    }
                    return CategoryAmountRank(data: []);
                  },
                ),
              ),
              SizedBox(height: Constant.iconlargeSize)
            ],
          )),
    );
  }
}
