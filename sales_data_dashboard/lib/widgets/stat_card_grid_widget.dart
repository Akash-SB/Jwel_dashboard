import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class StatCardGridWidget extends StatelessWidget {
  final List<StatCardModel> cards;

  const StatCardGridWidget({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        const double minCardWidth = 200;
        double spacing = 16.dp;

        int countPerRow = (maxWidth / (minCardWidth + spacing)).floor();
        countPerRow = countPerRow == 0 ? 1 : countPerRow;

        // Calculate actual card width to fill row completely
        double cardWidth =
            (maxWidth - ((countPerRow - 1) * spacing)) / countPerRow;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards.map((model) {
            return Container(
              width: cardWidth,
              padding: EdgeInsets.all(12.dp),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: model.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.title,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        model.iconData,
                        size: 20.dp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.dp),
                  Text(
                    model.value,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8.dp),
                  Text(
                    model.subtitle,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class StatCardModel {
  final String title;
  final String value;
  final String subtitle;
  final IconData iconData;
  final List<Color> gradientColors;

  StatCardModel({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.iconData,
    required this.gradientColors,
  });
}
