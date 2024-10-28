import 'package:cardreader/mainBloc/Model.dart';
import 'package:flutter/cupertino.dart';

class CardState {}

class InitState extends CardState {}

class LoadingState extends CardState {}

class Cards extends CardState {
  late List<CardModel> data;
  Cards({required this.data});
}
class ScanResulte extends CardState {
  late bool res;
  ScanResulte({required this.res});
}
