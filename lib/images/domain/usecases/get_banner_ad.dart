import '../repository/admob_ads_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GetBannerAd{

  final AdmobAdsRepository admobAdsRepository;
  GetBannerAd(this.admobAdsRepository);
  Future<BannerAd> loadBannerAd(BannerAdListener listener){
    return admobAdsRepository.loadBannerAd(listener);
  }
}