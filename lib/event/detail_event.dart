import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable{
  const DetailEvent();
}

class ReadMore extends DetailEvent {
  ReadMore();
  @override
  List<Object?> get props => [];
}