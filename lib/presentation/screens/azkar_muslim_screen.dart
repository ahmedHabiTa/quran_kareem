import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quran_kareem/controllers/azkar/azkar_cubit.dart';

class AzkarMuslimDetailsScreen extends StatelessWidget {
  static const routeName = '/AzkarMuslimDetailsScreen';

  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context).settings.arguments as Map<String,String>;

    return BlocProvider(
      create: (context) => AzkarCubit()..getAzkarMuslimDetails(url: argument['url'],detailsUrl: argument['detailsUrl']),
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
                        argument['title'],
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        textDirection: TextDirection.rtl,
                        children: List.generate(
                            AzkarCubit.get(context)
                                .azkarMuslimModel
                                .details
                                .length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.black87,
                              child: ListTile(
                                // trailing: Text(
                                //   'التكرار :${AzkarCubit.get(context).azkarMuslimModel.details[index].repeat}',
                                // ),
                                title: Text(
                                  AzkarCubit.get(context)
                                      .azkarMuslimModel
                                      .details[index]
                                      .arabicText,
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
