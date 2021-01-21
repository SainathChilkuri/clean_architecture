import 'package:equatable/equatable.dart';

class Number extends Equatable {
  final String fact;
  Number({
    this.fact
  });
  @override
  List<Object> get props => [fact];
}