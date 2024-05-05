import 'package:flutter/material.dart';
import 'package:qiblah_pro/modules/premium/service/in_app_purchase_service.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SuperEasyInAppPurchase inAppPurchase;

  @override
  void initState() {
    super.initState();
    inAppPurchase = SuperEasyInAppPurchase(
      inAppPurchaseItems: [
        InAppPurchaseItem(
          productId: 'com.behad.qiblah.namoz.mothly_purchase',
          onPurchaseComplete: () => print('Product 1 purchased successfully !'),
          onPurchaseRefunded: () => print('Product 1 disabled successfully !'),
        ),
        InAppPurchaseItem(
          productId: 'com.behad.qiblah.namoz.annual_purchase',
          onPurchaseComplete: () => print('Product 2 purchased successfully !'),
          onPurchaseRefunded: () => print('Product 2 disabled successfully !'),
          isConsumable: true,
        ),
      ],
    );
  }

  @override
  void dispose() {
    inAppPurchase.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Super Easy In App Purchase'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Activate product 1'),
              onPressed: () async {
                await inAppPurchase
                    .startPurchase('com.behad.qiblah.namoz.mothly_purchase');
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Activate product 2'),
              onPressed: () async {
                await inAppPurchase
                    .startPurchase('com.behad.qiblah.namoz.annual_purchase');
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Deactivate product 2'),
              onPressed: () async {
                await inAppPurchase.removeProduct('annual_purchase');
              },
            ),
          ],
        ),
      ),
    );
  }
}
