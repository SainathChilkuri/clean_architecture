import 'dart:convert';

import 'package:clean_architecture/Features/data/models/number_model.dart';
import 'package:clean_architecture/Features/domain/enitites/number_entity.dart';
import 'package:clean_architecture/Features/domain/usecases/number_usecase.dart';
import 'package:clean_architecture/core/Exceptions/exception.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class RemoteSourceData{
  Future<NumberModel> getRemoteNumber(NumberUseCaseParam param);
}
class RemoteDataSourceImpl extends RemoteSourceData{
  Dio dio;
  RemoteDataSourceImpl({
    @required this.dio
});
  @override
  Future<NumberModel> getRemoteNumber(NumberUseCaseParam param) async {
    try{
      Response response = await dio.get("http://numbersapi.com/${param.number}/math");
      if(response.statusCode == 200){
        print("${response.data}......................");
        return NumberModel.fromJson({"response": response.data});
      }else{
        throw ServerException();
      }
    }on DioError catch(e){
      throw ServerException();
    }
  }
}