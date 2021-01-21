import 'package:clean_architecture/Features/domain/usecases/number_usecase.dart';
import 'package:clean_architecture/Features/presentation/bloc/NumberBloc/number_bloc.dart';
import 'package:clean_architecture/Features/presentation/bloc/NumberBloc/number_events.dart';
import 'package:clean_architecture/Features/presentation/bloc/NumberBloc/number_states.dart';
import 'package:clean_architecture/Features/presentation/widgets/app_bar.dart';
import 'package:clean_architecture/core/Utils/strings.dart';
import 'package:clean_architecture/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MyScreen extends StatelessWidget {
  TextEditingController _number = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(NUMBER),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _factContainer(context),
            _textField(),
            _submitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _factContainer(BuildContext context) {
    return BlocConsumer<NumberBloc,NumberStates>(
      listener: (context,state){
        if(state is NumberLoadingState){

        }
      },
        // ignore: missing_return
        builder: (context,state){
          if(state is NumberInitialState){
            return Container(
              height: 30.0,
              margin: EdgeInsets.all(3.0),
              child: Text(S.of(context).play),
            );
          }
          if(state is NumberLoadingState){
            return Container(
              height: 30.0,
              margin: EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          if(state is NumberLoadedState){
            return Container(
              height: 30.0,
              margin: EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Text(state.number.fact),
            );
          }
          if(state is NumberLoadFailState){
            return Container(
              alignment: Alignment.center,
              child: Text(ERROR),
            );
          }
        });
  }

  Widget _textField() {
    return Container(
      child: TextFormField(
        controller: _number,
      ),
    );
  }

  _submitButton(BuildContext context) {
    return RaisedButton(
        onPressed: (){
          if(_formKey.currentState.validate()){
            BlocProvider.of<NumberBloc>(context).add(GetFactNumber(param: NumberUseCaseParam(number: int.parse(_number.text))));
          }
        },
      child: Text("Submit"),

        );
  }
}
