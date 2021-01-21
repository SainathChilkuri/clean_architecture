import 'package:clean_architecture/Features/data/models/number_model.dart';
import 'package:clean_architecture/Features/domain/usecases/number_usecase.dart';
import 'package:clean_architecture/core/Exceptions/exception.dart';
import 'package:clean_architecture/core/Utils/pref_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource{
  Future<NumberModel> getLocalNumberFact(NumberUseCaseParam param);
  Future<void> cacheNumberFact(NumberModel numberModel);
}
class LocalDataSourceImpl extends LocalDataSource{
  SharedPreferences sharedPreferences;
  LocalDataSourceImpl({
    @required this.sharedPreferences
});
  @override
  Future<NumberModel> getLocalNumberFact(NumberUseCaseParam param) async{
    try{
      final result = await sharedPreferences.getString(NUMBER_KEY);
      if(result!=null){
        return NumberModel(fact: result);
      }else{
        throw CacheException();
      }
    }catch(e){
      throw CacheException();
    }

  }

  @override
  Future<void> cacheNumberFact(NumberModel numberModel) {
    return sharedPreferences.setString(NUMBER_KEY, numberModel.fact);
  }

}