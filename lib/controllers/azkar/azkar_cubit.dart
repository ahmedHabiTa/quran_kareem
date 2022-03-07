import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
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
    var connectionState =
    await Connectivity().checkConnectivity();
    if (connectionState == ConnectivityResult.none) {
      emit(AzkarError());
      // Constants.get(context)
      //     .showToast(msg: 'خطأ الاتصال بالانترنت');
    }else{
      http.Response res = await http.get(
        Uri.parse(url),
      );
      if (res.body != null) {
        final data = jsonDecode(res.body);
        azkarModel = AzkarModel.fromJson(data);
        emit(AzkarSuccess(azkarModel: azkarModel));
      } else {
        print('---------------error');
        emit(AzkarError());
      }
    }
  }

  AzkarMuslimModel azkarMuslimModel;

  Future<void> getAzkarMuslimDetails({@required String url,String detailsUrl}) async {
    emit(AzkarLoading());
    var connectionState =
    await Connectivity().checkConnectivity();
    if (connectionState == ConnectivityResult.none) {
      emit(AzkarError());
      // Constants.get(context)
      //     .showToast(msg: 'خطأ الاتصال بالانترنت');
    } else {
      http.Response res = await http.get(
        Uri.parse(url),
        // headers: {
        //   'Content-Type': 'application/json;charset=UTF-8',
        //   'Charset': 'utf-8'
        // },
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(utf8.decode(res.bodyBytes));
        azkarMuslimModel =
            AzkarMuslimModel.fromJson(json: data, detailsUrl: detailsUrl);
        emit(AzkarSuccess(azkarMuslimModel: azkarMuslimModel));
      } else {
        print('-------------------error');
        emit(AzkarError());
        //  throw UnimplementedError();
      }
    }
  }
  String getAzkarRepeat({@required int index,@required BuildContext context}) {
    if (AzkarCubit.get(context)
        .azkarModel
        .content[index]
        .repeat ==
        1) {
      return '١';
    }
    if (AzkarCubit.get(context)
        .azkarModel
        .content[index]
        .repeat ==
        3) {
      return '٣';
    }
    if (AzkarCubit.get(context)
        .azkarModel
        .content[index]
        .repeat ==
        33) {
      return '٣٣';
    }
    if (AzkarCubit.get(context)
        .azkarModel
        .content[index]
        .repeat ==
        7) {
      return '۷';
    }
    if (AzkarCubit.get(context)
        .azkarModel
        .content[index]
        .repeat ==
        10) {
      return '١٠';
    }
    if (AzkarCubit.get(context)
        .azkarModel
        .content[index]
        .repeat ==
        100) {
      return '١٠٠';
    }
    if (AzkarCubit.get(context)
        .azkarModel
        .content[index]
        .repeat ==
        4) {
      return '٤';
    }
    return '';
  }
  String getAzkarMuslimRepeat({@required int index,@required BuildContext context}) {
    if (AzkarCubit.get(context)
        .azkarMuslimModel
        .details[index]
        .repeat ==
        1) {
      return '١';
    }
    if (AzkarCubit.get(context)
        .azkarMuslimModel
        .details[index]
        .repeat ==
        3) {
      return '٣';
    }
    if (AzkarCubit.get(context)
        .azkarMuslimModel
        .details[index]
        .repeat ==
        33) {
      return '٣٣';
    }
    if (AzkarCubit.get(context)
        .azkarMuslimModel
        .details[index]
        .repeat ==
        7) {
      return '۷';
    }
    if (AzkarCubit.get(context)
        .azkarMuslimModel
        .details[index]
        .repeat ==
        10) {
      return '١٠';
    }
    if (AzkarCubit.get(context)
        .azkarMuslimModel
        .details[index]
        .repeat ==
        100) {
      return '١٠٠';
    }
    if (AzkarCubit.get(context)
        .azkarMuslimModel
        .details[index]
        .repeat ==
        4) {
      return '٤';
    }
    return '';
  }
}
