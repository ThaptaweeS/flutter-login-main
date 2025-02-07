import 'package:flutter/material.dart';
import 'package:newmaster/presentation/resources/app_resources.dart';
import 'package:newmaster/util/app_helper.dart';

import 'fl_chart_banner.dart';
import 'menu_row.dart';

class AppMenu extends StatefulWidget {
  final List<ChartMenuItem> menuItems;
  final int currentSelectedIndex;
  final Function(int, ChartMenuItem) onItemSelected;
  final VoidCallback? onBannerClicked;

  const AppMenu({
    Key? key,
    required this.menuItems,
    required this.currentSelectedIndex,
    required this.onItemSelected,
    required this.onBannerClicked,
  }) : super(key: key);

  @override
  AppMenuState createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.itemsBackground,
      child: Column(
        children: [
          SafeArea(
            child: AspectRatio(
              aspectRatio: 3,
              child: Center(
                child: InkWell(
                  onTap: widget.onBannerClicked,
                  child: const FlChartBanner(),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, position) {
                final menuItem = widget.menuItems[position];
                return MenuRow(
                    text: menuItem.text,
                    svgPath: menuItem.iconPath,
                    isSelected: widget.currentSelectedIndex == position,
                    onTap: () {
                      widget.onItemSelected(position, menuItem);
                    },
                    onDocumentsTap: () async {});
              },
              itemCount: widget.menuItems.length,
            ),
          ),
        ],
      ),
    );
  }
}

// class _AppVersionRow extends StatelessWidget {
//   const _AppVersionRow();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
//       if (state.appVersion.isNullOrBlank) {
//         return Container();
//       }
//       return Container(
//         margin: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: RichText(
//                   text: TextSpan(
//                     text: '',
//                     style: DefaultTextStyle.of(context).style,
//                     children: <TextSpan>[
//                       const TextSpan(text: 'App version: '),
//                       TextSpan(
//                         text: 'v${state.appVersion!}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       if (state.usingFlChartVersion.isNotBlank) ...[
//                         const TextSpan(text: '\nfl_chart: '),
//                         TextSpan(
//                           text: 'v${state.usingFlChartVersion}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ]
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             state.availableVersionToUpdate.isNotBlank
//                 ? TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Update to ${state.availableVersionToUpdate}',
//                       style: const TextStyle(
//                         color: AppColors.primary,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 : TextButton(
//                     onPressed: () => AppUtils().tryToLaunchUrl(Urls.aboutUrl),
//                     child: const Text(
//                       'About',
//                       style: GoogleFonts.ramabhadra(
//                         color: AppColors.primary,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       );
//     });
//   }
// }

class ChartMenuItem {
  final ChartType chartType;
  final String text;
  final String iconPath;

  const ChartMenuItem(this.chartType, this.text, this.iconPath);
}
