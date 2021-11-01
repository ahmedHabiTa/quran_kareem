part of 'azkar_cubit.dart';


 class AzkarState {}

class AzkarInitial extends AzkarState {}
class AzkarLoading extends AzkarState {}
class AzkarSuccess extends AzkarState {
   final AzkarModel azkarModel  ;
   final AzkarMuslimModel azkarMuslimModel  ;

  AzkarSuccess({ this.azkarModel,this.azkarMuslimModel});
}
class AzkarError extends AzkarState {}
