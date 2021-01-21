import 'package:clean_architecture/Features/domain/enitites/number_entity.dart';

class NumberModel extends Number{
  NumberModel({
    String fact
  }):super(fact: fact);
  factory NumberModel.fromJson(Map<String,dynamic> map){
    String fact = map["response"];
    print("Fact: $fact");
    return NumberModel(fact: fact);
  }
  Map<String,dynamic> toMap(NumberModel numberModel){
    return {
       "response": numberModel.fact
    };
  }
}