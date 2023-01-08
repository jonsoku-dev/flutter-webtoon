import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name;
  final String currency;
  final String value;
  final IconData icon;
  final int rank;
  final bool isInverted;

  final _blackColor = const Color(0xFF1F2123);

  const CurrencyCard({
    super.key,
    required this.name,
    required this.currency,
    required this.value,
    required this.icon,
    required this.isInverted,
    this.rank = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (rank == 0) {
      return InnerChild(
        isInverted: isInverted,
        blackColor: _blackColor,
        name: name,
        value: value,
        currency: currency,
        icon: icon,
      );
    }
    return Transform.translate(
      offset: Offset(
        0, // X
        ((rank - 1) * -1 * 20), // Y
      ),
      child: InnerChild(
        isInverted: isInverted,
        blackColor: _blackColor,
        name: name,
        value: value,
        currency: currency,
        icon: icon,
      ),
    );
  }
}

class InnerChild extends StatelessWidget {
  const InnerChild({
    Key? key,
    required this.isInverted,
    required Color blackColor,
    required this.name,
    required this.value,
    required this.currency,
    required this.icon,
  })  : _blackColor = blackColor,
        super(key: key);

  final bool isInverted;
  final Color _blackColor;
  final String name;
  final String value;
  final String currency;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge, // overflow: hidden
      decoration: BoxDecoration(
        color: isInverted ? Colors.white : _blackColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: isInverted ? _blackColor : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      currency,
                      style: TextStyle(
                        color: isInverted
                            ? _blackColor.withOpacity(0.8)
                            : Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Transform.scale(
              scale: 1.9,
              child: Transform.translate(
                offset: const Offset(
                  -5, // X
                  12, // Y
                ),
                child: Icon(
                  icon,
                  color: isInverted ? _blackColor : Colors.white,
                  size: 88,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
