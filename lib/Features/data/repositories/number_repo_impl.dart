import 'package:clean_architecture/Features/data/datasources/local%20repo/local_datasource.dart';
import 'package:clean_architecture/Features/data/datasources/remote%20repo/remote_number_data_source.dart';
import 'package:clean_architecture/Features/domain/enitites/number_entity.dart';
import 'package:clean_architecture/Features/domain/repositories/number_repository.dart';
import 'package:clean_architecture/Features/domain/usecases/number_usecase.dart';
import 'package:clean_architecture/core/Exceptions/exception.dart';
import 'package:clean_architecture/core/Failures/failure.dart';
import 'package:clean_architecture/core/Network/network_info.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class NumberRepoImpl extends NumberRepository{
  LocalDataSource localDataSource;
  RemoteSourceData remoteDataSource;
  NetworkInfo networkInfo;
  NumberRepoImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo
 });
  @override
  Future<Either<Failure, Number>> getFact(NumberUseCaseParam param) async {
   if(await networkInfo.isConnected){
      return await getRemote(param);
   }else{
     print("No Internet");
     return await getLocal(param);
   }
  }

  Future<Either<Failure,Number>> getRemote(NumberUseCaseParam param) async  {
    try{
      var result = await remoteDataSource.getRemoteNumber(param);
      if(result!=null){
        localDataSource.cacheNumberFact(result);
        return Right(result);
      }else{
        return Left(ServerFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure,Number>> getLocal(NumberUseCaseParam param) async{
    try{
      var result = await localDataSource.getLocalNumberFact(param);
      if(result!=null){
        return Right(result);
      }else{
        return Left(CacheFailure());
      }
    }on CacheException{
      return Left(CacheFailure());
    }
  }
}