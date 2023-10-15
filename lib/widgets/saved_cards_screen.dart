import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thawani_payment/helper/alerts.dart';
import 'package:thawani_payment/models/create.dart';
import 'package:thawani_payment/models/saveed_cards_model.dart';
import 'package:thawani_payment/viewmodel/thawani_cards.dart';
import 'package:thawani_payment/widgets/saved_pay_screen.dart';

import '../viewmodel/keys_viewmodel.dart';

import '../viewmodel/thawani_paymentIntent.dart';

class SavedCardsScreen extends StatefulWidget {
  const SavedCardsScreen(
      {super.key,
      required this.saved,
      required this.apiKey,
      required this.amount,
      required this.returnLink,
      required this.testMode,
      this.metadata,
      required this.onCancelledCard,
      required this.onPaidCard,
      required this.onCreateCard});

  @override
  State<SavedCardsScreen> createState() => _SavedCardsScreenState();
  final SavedCardsModel saved;
  final String apiKey;
  final int amount;
  final String returnLink;
  final bool testMode;

  ///The Function And The Result Of Data If The User  Cancelled The Payment.
  final void Function(Map<String, dynamic> payStatus) onCancelledCard;

  ///The Function And The Result Of Data If The User  Cancelled The Payment.
  final void Function(Map<String, dynamic> payStatus) onPaidCard;
  final void Function(Create data) onCreateCard;
  final Map<String, dynamic>? metadata;
}

class _SavedCardsScreenState extends State<SavedCardsScreen> {
  PaymentIntentViewModel thawaniPayment = PaymentIntentViewModel();
  ThawaniCards cards = ThawaniCards();
  final String rawSvg =
      '''<svg width="126" height="113" viewBox="0 0 126 113" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M59.1336 41.31C59.1395 43.7412 58.4242 46.1194 57.0783 48.144C55.7324 50.1686 53.8162 51.7485 51.5722 52.6839C49.3282 53.6193 46.8571 53.8681 44.4717 53.3989C42.0862 52.9297 39.8935 51.7636 38.171 50.048C36.4484 48.3324 35.2733 46.1445 34.7944 43.7609C34.3155 41.3774 34.5543 38.9054 35.4805 36.6576C36.4068 34.4098 37.9789 32.4872 39.998 31.1331C42.017 29.7789 44.3924 29.054 46.8236 29.05C50.0813 29.0447 53.2079 30.3331 55.5162 32.632C57.8245 34.9309 59.1256 38.0522 59.1336 41.31Z" fill="#80be59"/>
<path d="M91.6336 41.25C91.6375 43.6811 90.9203 46.0589 89.5728 48.0824C88.2252 50.1058 86.3077 51.6842 84.0629 52.6178C81.8182 53.5513 79.3469 53.7981 76.9619 53.327C74.5768 52.8559 72.3851 51.6879 70.6639 49.9709C68.9427 48.254 67.7694 46.0651 67.2924 43.6811C66.8155 41.2972 67.0563 38.8254 67.9843 36.5784C68.9124 34.3313 70.4861 32.41 72.5063 31.0575C74.5265 29.705 76.9024 28.982 79.3336 28.98C80.947 28.9774 82.5452 29.2927 84.0368 29.9081C85.5283 30.5234 86.884 31.4266 88.0262 32.5661C89.1685 33.7056 90.0751 35.0591 90.694 36.5491C91.313 38.0391 91.6323 39.6365 91.6336 41.25Z" fill="#80be59"/>
<path d="M74.0436 12.26C74.0495 14.6916 73.334 17.0703 71.9876 19.0951C70.6413 21.1199 68.7245 22.6998 66.4799 23.6349C64.2353 24.57 61.7638 24.8182 59.378 24.3482C56.9923 23.8782 54.7996 22.7111 53.0775 20.9945C51.3553 19.2779 50.181 17.089 49.7032 14.7048C49.2254 12.3207 49.4656 9.84833 50.3934 7.60071C51.3212 5.35308 52.8948 3.43118 54.9153 2.07821C56.9357 0.72523 59.312 0.00198985 61.7436 4.10408e-06C64.9996 -0.00265495 68.1237 1.28689 70.4298 3.58551C72.7359 5.88414 74.0356 9.00396 74.0436 12.26Z" fill="#80be59"/>
<path d="M62.6936 90.36C57.2548 90.3731 51.8667 89.3142 46.8374 87.2438C41.8081 85.1734 37.2362 82.1321 33.383 78.2937C29.5297 74.4554 26.4708 69.8952 24.381 64.8739C22.2911 59.8527 21.2114 54.4688 21.2036 49.03H0.00356227C-0.0848432 57.3175 1.47304 65.54 4.58687 73.2208C7.70069 80.9015 12.3085 87.8876 18.143 93.7739C23.9775 99.6602 30.9227 104.329 38.5756 107.511C46.2286 110.693 54.4371 112.323 62.725 112.308C71.0129 112.293 79.2154 110.632 86.8566 107.422C94.4978 104.213 101.426 99.5179 107.239 93.6102C113.051 87.7026 117.634 80.6996 120.719 73.0074C123.805 65.3153 125.332 57.0871 125.214 48.8H104.024C104.045 54.2443 102.992 59.6393 100.925 64.676C98.8581 69.7128 95.8182 74.2925 91.9792 78.1529C88.1402 82.0133 83.5774 85.0786 78.5522 87.1732C73.5269 89.2679 68.1379 90.3508 62.6936 90.36Z" fill="#80be59"/>
</svg>''';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<CardData> data = widget.saved.data!;
    return Scaffold(
        appBar: AppBar(
          title: userSavedCardsAppBar,
          actions: [
            IconButton(
                onPressed: () {
                  cards.add(context, onCreate: (data) {
                    widget.onCreateCard(data);
                  }, onCancelled: (data) {
                    widget.onCancelledCard(data);
                  }, onPaid: (data) {
                    widget.onPaidCard(data);
                  }, onError: (data) {});
                },
                icon: const Icon(Icons.add_card))
          ],
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Alert.loading(context, userSelectCardLoading);
                              thawaniPayment.create(widget.apiKey,
                                  amount: widget.amount,
                                  returnLink: widget.returnLink,
                                  testMode: widget.testMode,
                                  cardID: data[i].id!,
                                  clientID: data[i].customer!.customerClientId!,
                                  onDone: (c, d) {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PaySavedWidget(
                                              paid: (data) {
                                                widget.onPaidCard(data);
                                              },
                                              unpaid: (data) {
                                                widget.onCancelledCard(data);
                                              },
                                              url: c.data!.nextAction!.url!,
                                              api: widget.apiKey,
                                              testMode: widget.testMode,
                                              returnLink: widget.returnLink,
                                              payID: c.data!.id!,
                                            )));
                              }, onError: (d) {});
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                height: 200,
                                width: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: userSavedCardBackground),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: userSavedCardTextColor),
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.all(5),
                                          child: SvgPicture.string(
                                            rawSvg,
                                            theme: const SvgTheme(
                                                currentColor:
                                                    Color(0xff80be59)),
                                          ),
                                        ),
                                        Text(
                                          "Thawani Card",
                                          style: TextStyle(
                                              color: userSavedCardTextColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data[i].brand ?? "",
                                          style: TextStyle(
                                              color: userSavedCardTextColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        data[i].maskedCard ?? "",
                                        style: TextStyle(
                                            color: userSavedCardTextColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data[i].nickname ?? "",
                                          style: TextStyle(
                                              color: userSavedCardTextColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "EXP: ${data[i].expiryMonth} / ${data[i].expiryYear}",
                                          style: TextStyle(
                                            color: userSavedCardTextColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              Alert.loading(context, userDeleteLoading,
                                  ableToClose: false);
                              cards.delete(
                                  cardId: data[i].id!,
                                  onDelete: () {
                                    Navigator.pop(context);

                                    setState(() {
                                      data.removeAt(i);
                                    });
                                  },
                                  onError: () {
                                    Navigator.pop(context);
                                    Alert.msg(context, '', userDeleteError);
                                  });
                              // setState(() {
                              //   // items.removeAt(index);
                              // });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })),
        ));
  }
}
