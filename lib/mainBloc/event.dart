import 'package:equatable/equatable.dart';

class CardEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetCards extends CardEvent {}

class Scan extends CardEvent {}

class DeleteCard extends CardEvent {
  late int index;
  DeleteCard({required this.index});
}
