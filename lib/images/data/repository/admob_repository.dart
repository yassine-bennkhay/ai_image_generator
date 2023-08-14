import '../data_source/admob_datasource.dart';
import 'package:google_mobile_ads/src/ad_containers.dart';
import 'package:google_mobile_ads/src/ad_listeners.dart';

import '../../domain/repository/admob_ads_repository.dart';

class ConcreteAdMobRepository implements AdmobAdsRepository{
  final AdMobDataSource adMobDataSource;
  ConcreteAdMobRepository(this.adMobDataSource);

  @override
  Future<BannerAd> loadBannerAd(BannerAdListener listener) async{
    return await adMobDataSource.loadBannerAd(listener);
  }

  @override
  void loadInterstitialAd(Function() onAdClosed) async{
      adMobDataSource.loadInterstitialAd(() => onAdClosed);
  }

}