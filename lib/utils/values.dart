import 'package:google_maps_flutter/google_maps_flutter.dart';

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

const regularProductsAPI =
    "$appDomain/backend/scripts/products/get_regular_products.php";

const productsSearchAPI = "$appDomain/backend/scripts/products/search.php";

const accountRecoveryAPI =
    "$appDomain/backend/scripts/users/account_recovery.php";

const getMarkersAPI = "$appDomain/backend/scripts/users/get_shops_markers.php";

const sections = [
  ["صيفي رجالي", "شتوي رجالي", "أحذية رجالي", "شنط رجالي", "إكسسوارات رجالي"],
  ["صيفي حريمي", "شتوي حريمي", "أحذية حريمي", "شنط حريمي", "إكسسوارات حريمي"],
  ["أولاد أطفالي", "بنات أطفالي"]
];

final defaultLocation = LatLng(30.048, 31.1997);
final egyptBounds = LatLngBounds(
  northeast: LatLng(31.5856, 32.8),
  southwest: LatLng(24.2, 26.5),
);

const defaultUserAvatarAsset = "assets/icons/account.png";
