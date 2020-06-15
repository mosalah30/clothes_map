import 'package:google_maps_flutter/google_maps_flutter.dart';

const shoppingMapAdUnitId = "ca-app-pub-2775719056787328/4147895000";
const offersAdUnitId = "ca-app-pub-2775719056787328/5962419995";
const productDetailsAdUnitId = "ca-app-pub-2775719056787328/1935545070";

const appDomain = "https://clothes-map.000webhostapp.com";

const shopsMarkersStorage = "$appDomain/backend/content/dealers_shops_markers/";
const regularProductsImagesStorage =
    "$appDomain/backend/content/regular_products_images/";

const customersAvatarsStorage = "$appDomain/backend/content/customers_avatars/";
const hotOffersImagesStorage = "$appDomain/backend/content/hot_offers_images/";
const offersImagesStorage = "$appDomain/backend/content/offers_images/";

const customerInfoUpdateAPI =
    "$appDomain/backend/scripts/users/update_customer_info.php";

const customersSignupAPI =
    "$appDomain/backend/scripts/users/customers_signup.php";

const customersAvatarsAPI =
    "$appDomain/backend/scripts/users/upload_customer_avatar.php";

const customersLoginAPI =
    "$appDomain/backend/scripts/users/customers_login.php";

const customersSocialLoginAPI =
    "$appDomain/backend/scripts/users/customers_social_login.php";

const accountsDuplicateValidatorAPI =
    "$appDomain/backend/scripts/users/accounts_duplicate_validator.php";

const offersAPI = "$appDomain/backend/scripts/products/get_offers.php";

const productsSearchAPI = "$appDomain/backend/scripts/products/search.php";

const accountRecoveryAPI =
    "$appDomain/backend/scripts/users/account_recovery.php";

const getMarkersAPI = "$appDomain/backend/scripts/users/get_shops_markers.php";

const clothesBrands = {
  0: "Adidas",
  1: "Nike",
  2: "H&M",
  3: "Active",
  4: "Zara",
};
const clothesSectionItems = [
  "بناطيل وقمصان",
  "بدل رجالي وجينز",
  "ملابس النوم وشربات",
  "ملابس داخلية"
];
const shoesSectionItems = [
  "صنادل وشباشب",
  "أحذية رياضية",
];
const accessoriesSectionItems = [
  "ساعات رجالي",
  "ساعات حريمي",
  "نظارات",
  "أحزمة وكرفتات"
];

final defaultLocation = LatLng(30.048, 31.1997);
final egyptBounds = LatLngBounds(
  northeast: LatLng(31.5856, 32.8),
  southwest: LatLng(24.2, 26.5),
);

const defaultUserAvatarAsset = "assets/icons/account.png";