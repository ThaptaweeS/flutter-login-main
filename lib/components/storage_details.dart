import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summary Data",
            style: GoogleFonts.ramabhadra(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Chart(),
          const StorageInfoCard(
            svgSrc: "assets/icons/icon3.svg",
            title: "TA Feed/Month",
            amountOfFiles: "17.744 Litter",
            numOfFiles: 1328,
            color: Color.fromARGB(255, 21, 145, 247),
          ),
          const StorageInfoCard(
            svgSrc: "assets/icons/icon3.svg",
            title: "AC Feed/Month",
            amountOfFiles: "7.532 Litter",
            numOfFiles: 1328,
            color: Color(0xFFA4CDFF),
          ),
          const StorageInfoCard(
            svgSrc: "assets/icons/icon3.svg",
            title: "FA Feed/Month",
            amountOfFiles: "0 Litter",
            numOfFiles: 1328,
            color: Color.fromARGB(255, 210, 229, 0),
          ),
          const StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Unknown",
            amountOfFiles: "0 Litter",
            numOfFiles: 140,
            color: Color.fromARGB(255, 255, 167, 45),
          ),
        ],
      ),
    );
  }
}
