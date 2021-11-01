import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_kareem/model/azkar_model.dart';
import 'package:http/http.dart' as http;
import 'package:quran_kareem/model/azkar_muslim_model.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());

  static AzkarCubit get(context) => BlocProvider.of(context);
  AzkarModel azkarModel;

  Future<void> getAzkarDetails({@required String url}) async {
    emit(AzkarLoading());
    http.Response res = await http.get(
      Uri.parse(url),
    );
    if (res.body != null) {
      final data = jsonDecode(res.body);
      azkarModel = AzkarModel.fromJson(data);
      emit(AzkarSuccess(azkarModel: azkarModel));
    } else {
      print('error');
      throw UnimplementedError();
    }
  }

  AzkarMuslimModel azkarMuslimModel;

  Future<void> getAzkarMuslimDetails({@required String url,String detailsUrl}) async {
    emit(AzkarLoading());
    http.Response res = await http.get(
      Uri.parse(url),
      // headers: {
      //   'Content-Type': 'application/json;charset=UTF-8',
      //   'Charset': 'utf-8'
      // },
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(utf8.decode(res.bodyBytes));
      azkarMuslimModel = AzkarMuslimModel.fromJson(json: data,detailsUrl: detailsUrl);
      emit(AzkarSuccess(azkarMuslimModel: azkarMuslimModel));
    } else {
      print('error');
      throw UnimplementedError();
    }
  }
}
