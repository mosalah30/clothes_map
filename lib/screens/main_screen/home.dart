import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/components/offer_card.dart';
import 'package:clothes_map/screens/main_screen/products_search.dart';
import 'package:clothes_map/state_management/screens_controller.dart';
import 'package:clothes_map/state_management/offers_notifier.dart';
import 'package:clothes_map/services/offers_client.dart';
import 'package:clothes_map/utils/status_bar_color.dart';
import 'package:clothes_map/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController;
  OffersClient offersClient;
  OffersNotifier offersNotifier;
  ScreensController screensController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    offersNotifier = Provider.of<OffersNotifier>(context, listen: false);
    screensController = Provider.of<ScreensController>(context, listen: false);
    scrollController = ScrollController();
    searchController = TextEditingController();
    offersClient = OffersClient(offersNotifier);
    changeStatusBarColor(appPrimaryColor, false);
    offersClient.getOffers('hot_offers');
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        screensController.changeOffersLoaderState(true);
        offersNotifier.nextHotOffersPage++;
        await offersClient.getOffers('hot_offers');
        screensController.changeOffersLoaderState(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ScreensController, bool>(
      selector: (context, screenController) => screenController.isSearching,
      builder: (context, searchingState, child) => Column(
        children: <Widget>[
          Container(
            color: Color(0xff1D1D1D),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                autocorrect: true,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  hintText: 'بحث',
                                  border: InputBorder.none,
                                ),
                                controller: searchController,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              searchingState ? Icons.cancel : Icons.search,
                            ),
                            onPressed: () {
                              if (searchController.text.trim().length < 3 &&
                                  !searchingState) {
                                Fluttertoast.showToast(
                                  msg: 'كلمة البحث أقل من 3 أحرف',
                                  textColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  gravity: ToastGravity.TOP,
                                );
                              } else {
                                Provider.of<ScreensController>(
                                  context,
                                  listen: false,
                                ).changeSearchingState();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          searchingState
              ? ProductsSearch(searchController.text)
              : Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Carousel(
                              animationDuration: Duration(seconds: 3),
                              autoplayDuration: Duration(seconds: 4),
                              boxFit: BoxFit.cover,
                              images: [
                                AssetImage('assets/brands/adidas.png'),
                                AssetImage('assets/brands/H&M.jpg'),
                                AssetImage('assets/brands/active.png'),
                                AssetImage('assets/brands/zara.png'),
                              ],
                              onImageTap: (_) {},
                              autoplay: true,
                              dotBgColor: Colors.transparent,
                              dotSize: 5,
                              dotColor: Colors.grey,
                              dotIncreasedColor: Colors.blue,
                              indicatorBgPadding: 2,
                            ),
                          ),
                          Consumer<OffersNotifier>(
                            builder: (context, admin, child) {
                              if (admin.hotOffers.isEmpty) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.6,
                                  child: ColorsLoader(),
                                );
                              } else {
                                return Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    for (var offer in admin.hotOffers)
                                      OfferCard(
                                        id: offer.id,
                                        imageUrl: offer.imageUrl,
                                        description: offer.description,
                                        price: offer.price,
                                        priceBeforeDiscount:
                                            offer.priceBeforeDiscount,
                                        category: offer.category,
                                        section: offer.section,
                                      ),
                                  ],
                                );
                              }
                            },
                          ),
                          Selector<ScreensController, bool>(
                            selector: (context, screensController) =>
                                screensController.offersLoading,
                            builder: (context, isLoading, child) =>
                                isLoading && offersNotifier.hasMore
                                    ? Container(
                                        height: 50,
                                        child: Center(
                                          child: ColorsLoader(),
                                        ),
                                      )
                                    : Container(height: 0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void dispose() {
    super.dispose();
    offersNotifier.reset();
    searchController.clear();
    scrollController.dispose();
    changeStatusBarColor(Colors.black, true);
  }
}
