import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AdmobAdsRepository{
  Future<BannerAd> loadBannerAd(BannerAdListener listener);
  void loadInterstitialAd(Function() onAdClosed);
}