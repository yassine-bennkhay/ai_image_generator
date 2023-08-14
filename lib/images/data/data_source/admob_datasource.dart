import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../core/utils/constants.dart';

abstract class AdMobDataSource{

  Future<BannerAd> loadBannerAd(BannerAdListener listener);
  void loadInterstitialAd(Function() onAdClosed);
}

class AdMobDataSourceImplementation extends AdMobDataSource{
  @override
  Future<BannerAd> loadBannerAd(BannerAdListener listener) async{
    final bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid ? AppConstants.bannerAdUnitIdAndroid : AppConstants.bannerAdUnitIos,
        listener: listener,
        request: const AdRequest());
    bannerAd.load();
    return bannerAd;
  }

  @override
  void loadInterstitialAd(Function() onAdClosed) async{
    InterstitialAd.load(
      adUnitId:
      Platform.isAndroid ? AppConstants.interstitialAdUnitIdAndroid : AppConstants.interstitialAdUnitIdIos,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              onAdClosed();
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');},
      ),
    );
  }

}