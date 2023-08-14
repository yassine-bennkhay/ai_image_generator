import 'banner_ad_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../domain/repository/admob_ads_repository.dart';
import '../../../domain/usecases/get_banner_ad.dart';

class BannerAdCubit extends Cubit<AdsState>{
  final AdmobAdsRepository admobAdsRepository;
  BannerAdCubit(this.admobAdsRepository):super(InitialAdsState());

  Future<void> getBannerAd(BannerAdListener listener)async{
   try{
     emit(LoadingAds());
     BannerAd bannerAd= await GetBannerAd(admobAdsRepository).loadBannerAd(listener);
     emit(BannerAdsLoaded(bannerAd));
     print("Ads is loaded and emmited");
   }catch (e) {
       emit(BannerAdsError("Error Loading Ads"));
   }
  }
}