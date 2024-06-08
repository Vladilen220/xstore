import 'package:get/get.dart';
import 'package:xstore/data/repositories/banners/banner_repository.dart';

import '../../../utils/popups/loaders.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController{

  /// Variables
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  ///Update Page navigate dots
  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async{
    try{
      // Show Loader while loading categories
      isLoading.value = true;

      // Fetch banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // Assign banners
      this.banners.assignAll(banners);

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally{
      //Remove Loader
      isLoading.value = false;
    }
  }
}