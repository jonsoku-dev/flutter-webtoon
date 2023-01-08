import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';

import 'widgets/currency_card.dart';

const taxAmount = 15;
const priceAmount = 30;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: const Color(0xFF181818),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Hey, Selena',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800),
                          ),
                          Text('Welcome back',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "\$5 194 482",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 44,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Button(
                        text: 'Transfer',
                        bgColor: Color(0xFFF1B33B),
                        textColor: Colors.black,
                      ),
                      Button(
                        text: 'Request',
                        bgColor: Color(0x0ff1b33b),
                        textColor: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Wallets',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CurrencyCard(
                    name: 'Euro',
                    currency: 'EUR',
                    value: '1 000 000',
                    icon: Icons.euro_rounded,
                    isInverted: false,
                    rank: 1,
                  ),
                  const CurrencyCard(
                    name: 'Bitcoin',
                    currency: 'BTC',
                    value: '9 785',
                    icon: Icons.currency_bitcoin_rounded,
                    isInverted: true,
                    rank: 2,
                  ),
                  const CurrencyCard(
                    name: 'Dollar',
                    currency: 'USD',
                    value: '428',
                    icon: Icons.attach_money_rounded,
                    isInverted: false,
                    rank: 3,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
