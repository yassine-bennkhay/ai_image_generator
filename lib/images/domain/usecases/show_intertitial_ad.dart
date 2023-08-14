import '../repository/admob_ads_repository.dart';

class ShowIntertitialAd{
  final AdmobAdsRepository admobAdsRepository;
  ShowIntertitialAd(this.admobAdsRepository);
  void loadInterstitialAd(Function() onAdClose ) {
    return  admobAdsRepository.loadInterstitialAd(() => onAdClose);
  }

}