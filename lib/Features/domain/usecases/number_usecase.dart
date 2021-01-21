import 'package:clean_architecture/Features/domain/enitites/number_entity.dart';
import 'package:clean_architecture/Features/domain/repositories/number_repository.dart';
import 'package:clean_architecture/core/Failures/failure.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NumberUseCase implements UseCase<Number,NumberUseCaseParam>{
  NumberRepository numberRepository;
  NumberUseCase({
    @required this.numberRepository
  });
  @override
  Future<Either<Failure,Number>> call(NumberUseCaseParam param) async {
   var result = await numberRepository.getFact(param);
   return result;
  }
}
class NumberUseCaseParam extends Equatable{
  final int number;
  NumberUseCaseParam({
    @required this.number
});
  @override
  List<Object> get props => [number];
}