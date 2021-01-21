import 'package:clean_architecture/Features/domain/usecases/number_usecase.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NumberEvents extends Equatable{
  @override
  List<Object> get props => [];
}
class GetFactNumber extends NumberEvents{
  final NumberUseCaseParam param;
  GetFactNumber({
    @required this.param
  }):assert(param!=null);
  @override
  List<Object> get props => [param];
}
