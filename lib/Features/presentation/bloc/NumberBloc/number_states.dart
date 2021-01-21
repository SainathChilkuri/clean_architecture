import 'package:clean_architecture/Features/domain/enitites/number_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NumberStates extends Equatable{
  @override
  List<Object> get props=>[];
}
class NumberInitialState extends NumberStates{}
class NumberLoadingState extends NumberStates{}
class NumberLoadedState extends NumberStates{
  final Number number;
  NumberLoadedState({
    @required this.number
 }):assert(number!=null);
  @override
  List<Object> get props => [number];
}
class NumberLoadFailState extends NumberStates{}