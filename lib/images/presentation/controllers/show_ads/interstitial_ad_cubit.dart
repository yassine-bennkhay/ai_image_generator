import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/admob_ads_repository.dart';
import '../../../domain/usecases/show_intertitial_ad.dart';
import 'intertitial_ad_state.dart';

class InterstitialAdCubit extends Cubit<InterstitialAdState> {
  final AdmobAdsRepository admobAdsRepository;

  InterstitialAdCubit(this.admobAdsRepository) : super(InitialInterstitialAd());

  void loadInterstitialAd(Function() onAdClose) {


    ShowIntertitialAd(admobAdsRepository).loadInterstitialAd(() {

    });
    onAdClose();
  }

}
