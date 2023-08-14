import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsState{}

class InitialAdsState extends AdsState{}

class LoadingAds extends AdsState{}

class BannerAdsLoaded extends AdsState{
  final BannerAd bannerAd;
  BannerAdsLoaded(this.bannerAd);
}
class BannerAdsError extends AdsState{
  final String errorMessage;
  BannerAdsError(this.errorMessage);
}
