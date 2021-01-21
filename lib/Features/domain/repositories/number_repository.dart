import 'package:clean_architecture/Features/domain/enitites/number_entity.dart';
import 'package:clean_architecture/Features/domain/usecases/number_usecase.dart';
import 'package:clean_architecture/core/Failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class NumberRepository{
  Future<Either<Failure,Number>> getFact(NumberUseCaseParam param);
}