
import 'package:equatable/equatable.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailStateInitial extends DetailState {
  const DetailStateInitial();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DetailStateReadMore extends DetailState {
  const DetailStateReadMore();
  @override
  List<Object> get props => [];
}

