import 'package:clean_architecture/Features/domain/enitites/number_entity.dart';
import 'package:clean_architecture/Features/domain/usecases/number_usecase.dart';
import 'package:clean_architecture/Features/presentation/bloc/NumberBloc/number_events.dart';
import 'package:clean_architecture/Features/presentation/bloc/NumberBloc/number_states.dart';
import 'package:clean_architecture/core/Failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberBloc extends Bloc<NumberEvents,NumberStates>{

  NumberUseCase numberUseCase;
  NumberBloc({NumberUseCase numberUseCase}) : super(NumberInitialState()){
    this.numberUseCase =numberUseCase;
  }
  @override
  Stream<NumberStates> mapEventToState(NumberEvents event) async* {
      if(event is GetFactNumber){
       yield NumberLoadingState();
        var result = await numberUseCase.call(event.param);
        yield* result.fold (
                (failure) async* {
                  if(failure is CacheFailure){
                    yield NumberLoadFailState();
                  }else if(failure is ServerFailure){
                    yield NumberLoadFailState();
                  }else{
                    yield NumberLoadFailState();
                  }
               },
                (number) async*{
              yield NumberLoadedState(number: number);
            });
      }
  }

}