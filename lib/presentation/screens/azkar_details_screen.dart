import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quran_kareem/controllers/azkar/azkar_cubit.dart';

class AzkarDetailsScreen extends StatelessWidget {
  static const routeName = '/AzkarDetailsScreen';

  @override
  Widget build(BuildContext context) {
    var url = ModalRoute.of(context).settings.arguments as String;

    return BlocProvider(
      create: (context) => AzkarCubit()..getAzkarDetails(url: url),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              if (state is AzkarLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AzkarSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        AzkarCubit.get(context).azkarModel.title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        textDirection: TextDirection.rtl,
                        children: List.generate(
                            AzkarCubit.get(context).azkarModel.content.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.black87,
                              child: ListTile(trailing: Text('التكرار :${AzkarCubit.get(context)
                                  .azkarModel
                                  .content[index]
                                  .repeat}'),

                                title: Text(
                                  AzkarCubit.get(context)
                                      .azkarModel
                                      .content[index]
                                      .zekr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
