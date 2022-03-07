import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:quran_kareem/controllers/azkar/azkar_cubit.dart';
import 'package:quran_kareem/presentation/widgets/loading_logo.dart';

class AzkarMuslimDetailsScreen extends StatelessWidget {
  static const routeName = '/AzkarMuslimDetailsScreen';

  @override
  Widget build(BuildContext context) {
    var argument =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return BlocProvider(
      create: (context) => AzkarCubit()
        ..getAzkarMuslimDetails(
            url: argument['url'], detailsUrl: argument['detailsUrl']),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              if (state is AzkarLoading) {
                return Center(
                  child: LoadingShimmer(),
                );
              }
              if (state is AzkarSuccess) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        argument['title'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: AzkarCubit.get(context).azkarMuslimModel.details.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: Card(
                              elevation: 10,
                              color: Colors.black45,
                              shadowColor: Colors.black87,
                              child: Column(
                                children: [
                                  Text(
                                    AzkarCubit.get(context)
                                        .azkarMuslimModel
                                        .details[index]
                                        .arabicText
                                        .replaceAll(')', '')
                                        .replaceAll('(', '')
                                        .replaceAll('﴿', '')
                                        .replaceAll('﴾', '')
                                        .replaceAll('.', '')
                                        .replaceAll(
                                        'يفعلُ ذلك ثلاثَ مرَّاتٍ', ''),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        AzkarCubit().getAzkarMuslimRepeat(
                                          context: context,
                                          index: index,
                                        ),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.orange[300]),
                                    height: 35,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // Wrap(
                      //   textDirection: TextDirection.rtl,
                      //   children: List.generate(
                      //       AzkarCubit.get(context)
                      //           .azkarMuslimModel
                      //           .details
                      //           .length, (index) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: Card(
                      //         elevation: 10,
                      //         color: Colors.black45,
                      //         shadowColor: Colors.black87,
                      //         child: Column(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Text(
                      //                 AzkarCubit.get(context)
                      //                     .azkarMuslimModel
                      //                     .details[index]
                      //                     .arabicText
                      //                     .replaceAll(')', '')
                      //                     .replaceAll('(', '')
                      //                     .replaceAll('﴿', '')
                      //                     .replaceAll('﴾', '')
                      //                     .replaceAll('.', '')
                      //                     .replaceAll(
                      //                         'يفعلُ ذلك ثلاثَ مرَّاتٍ', ''),
                      //                 style: TextStyle(
                      //                   color: Colors.white,
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //                 textAlign: TextAlign.right,
                      //               ),
                      //             ),
                      //             Container(
                      //               child: Center(
                      //                 child: Text(
                      //                   AzkarCubit().getAzkarMuslimRepeat(
                      //                     context: context,
                      //                     index: index,
                      //                   ),
                      //                   style: TextStyle(
                      //                       fontSize: 18,
                      //                       fontWeight: FontWeight.bold,
                      //                       color: Colors.black87),
                      //                 ),
                      //               ),
                      //               decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color: Colors.orange[300]),
                      //               height: 35,
                      //             ),
                      //             const SizedBox(
                      //               height: 8.0,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   }),
                      // ),
                    ],
                  ),
                );
              }
              if (state is AzkarError) {
                return Center(
                  child: SvgPicture.asset(
                      'assets/images/undraw_server_down_s-4-lk.svg'),
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
