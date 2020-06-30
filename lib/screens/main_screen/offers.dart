import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clothes_map/components/offer_card.dart';
import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/state_management/screens_controller.dart';
import 'package:clothes_map/state_management/offers_notifier.dart';
import 'package:clothes_map/services/offers_client.dart';
import 'package:clothes_map/utils/screen_util.dart';

class OffersScreen extends StatefulWidget {
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  ScreenUtil screenUtil;
  OffersNotifier offersNotifier;
  OffersClient offersClient;
  ScreensController screensController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    offersNotifier = Provider.of<OffersNotifier>(context, listen: false);
    screensController = Provider.of<ScreensController>(context, listen: false);
    screenUtil = ScreenUtil.instance;
    offersClient = OffersClient(offersNotifier);
    scrollController = ScrollController();
    offersClient.getOffers('offers');
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        screensController.changeOffersLoaderState(true);
        offersNotifier.nextOffersPage++;
        await offersClient.getOffers('offers');
        screensController.changeOffersLoaderState(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: <Widget>[
          Consumer<OffersNotifier>(
            builder: (context, admin, child) {
              if (admin.offers.isEmpty) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ColorsLoader(),
                );
              } else {
                return Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    for (var offer in admin.offers)
                      OfferCard(
                        id: offer.id,
                        imageUrl: offer.imageUrl,
                        description: offer.description,
                        price: offer.price,
                        priceBeforeDiscount: offer.priceBeforeDiscount,
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
    );
  }

  @override
  void dispose() {
    offersNotifier.reset();
    scrollController.dispose();
    super.dispose();
  }
}
