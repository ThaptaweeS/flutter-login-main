import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newmaster/page/page02/remote-pump-feed.dart';
import 'package:newmaster/page/page11.dart';
import 'package:newmaster/page/page2-data/feed-history.dart';
import 'package:newmaster/page/page2-data/manual-process.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/BlocEvent/LoginEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../page/page01.dart';
import '../../page/page02.dart';
import '../../page/page2-data/manual-process-user.dart';
import '../../page/page3.dart';

late BuildContext MenuContext;

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuContext = context;

    // Define a list of menu items with their corresponding access levels
    List<Map<String, dynamic>> menuItems = [
      {
        "title": "Dashboard",
        "svgSrc": "assets/icons/menu_dashboard.svg",
        "page": Page01(),
        "accessLevel": 2
      },
      {
        "title": "Dashboard",
        "svgSrc": "assets/icons/menu_dashboard.svg",
        "page": Page01(),
        "accessLevel": 5
      },
      // {
      //   "title": "Production Monitor",
      //   "svgSrc": "assets/icons/menu_monitor.svg",
      //   "page": Page00(),
      //   "accessLevel": 2
      // },
      {
        "title": "Data Input",
        "svgSrc": "assets/icons/menu_tran.svg",
        "page": Page02(),
        "accessLevel": 5
      },
      {
        "title": "Chemical Feed Task",
        "svgSrc": "assets/icons/menu_task.svg",
        "page": Manualfeed(),
        "accessLevel": 5
      },
      {
        "title": "Chemical Feed Task",
        "svgSrc": "assets/icons/menu_task.svg",
        "page": Manualfeed(),
        "accessLevel": 9
      },
      {
        "title": "Chemical Feed Order",
        "svgSrc": "assets/icons/menu_alert.svg",
        "page": ManualfeedUser(),
        "accessLevel": 2
      },
      {
        "title": "Data History",
        "svgSrc": "assets/icons/menu_doc.svg",
        "page": Page3(),
        "accessLevel": 5
      },

      {
        "title": "Dashboard",
        "svgSrc": "assets/icons/menu_dashboard.svg",
        "page": Page01(),
        "accessLevel": 9
      },
      // {
      //   "title": "Production Monitor",
      //   "svgSrc": "assets/icons/menu_monitor.svg",
      //   "page": Page00(),
      //   "accessLevel": 9
      // },
      {
        "title": "Data Input",
        "svgSrc": "assets/icons/menu_tran.svg",
        "page": Page02(),
        "accessLevel": 9
      },
      {
        "title": "Data History",
        "svgSrc": "assets/icons/menu_task.svg",
        // "page": (),
        "page": Page3(),
        "accessLevel": 9
      },
      {
        "title": "Chemical Feed Order",
        "svgSrc": "assets/icons/menu_alert.svg",
        "page": ManualfeedUser(),
        "accessLevel": 9
      },
      {
        "title": "Feed History",
        "svgSrc": "assets/icons/menu_doc.svg",
        "page": FeedHistory(),
        "accessLevel": 2
      },
      {
        "title": "Feed History",
        "svgSrc": "assets/icons/menu_doc.svg",
        "page": FeedHistory(),
        "accessLevel": 5
      },
      {
        "title": "Feed History",
        "svgSrc": "assets/icons/menu_doc.svg",
        "page": FeedHistory(),
        "accessLevel": 9
      },
      {
        "title": "Remote Pump Control",
        "svgSrc": "assets/icons/pump.svg",
        "page": Remotefeed(),
        "accessLevel": 9
      },
      // {
      //   "title": "Remote Pump Control",
      //   "svgSrc": "assets/icons/pump.svg",
      //   "page": Remotefeed(),
      //   "accessLevel": 5
      // },
      {
        "title": "Remote Pump Control",
        "svgSrc": "assets/icons/pump.svg",
        "page": Remotefeed(),
        "accessLevel": 2
      },
      {
        "title": "Settings",
        "svgSrc": "assets/icons/menu_setting.svg",
        // "page": PasswordSettingPage(),
        "page": MainSetting(),
        "accessLevel": 9
      },
      // {
      //   "title": "Feed History",
      //   "svgSrc": "assets/icons/menu_notification.svg",
      //   "page": FeedHistory,
      //   "accessLevel": [2, 5, 9]
      // },

      {
        "title": "Settings",
        "svgSrc": "assets/icons/menu_setting.svg",
        // "page": PasswordSettingPage(),
        "page": MainSetting(),
        "accessLevel": 2
      },
      {
        "title": "Settings",
        "svgSrc": "assets/icons/menu_setting.svg",
        // "page": PasswordSettingPage(),
        "page": MainSetting(),
        "accessLevel": 5
      },
      {
        "title": "Logout",
        "svgSrc": "assets/icons/logout-svgrepo-com.svg",
        "page": null,
        "accessLevel": [2, 5, 9]
      },
      // {
      //   "title": "About",
      //   "svgSrc": "assets/icons/menu_about.svg",
      //   "page": null,
      //   "accessLevel": 2
      // },
      // {
      //   "title": "About",
      //   "svgSrc": "assets/icons/menu_about.svg",
      //   "page": null,
      //   "accessLevel": 5
      // },
    ];

    // Filter the menu items based on the user's access level
    List<Map<String, dynamic>> visibleMenuItems = menuItems.where((item) {
      var accessLevels = item["accessLevel"];
      if (accessLevels is List) {
        // Check if user's access level is included in the array
        return accessLevels.contains(USERDATA.UserLV);
      } else {
        // Check if user's access level matches the single value
        return USERDATA.UserLV == item["accessLevel"];
      }
    }).toList();

    return SizedBox(
      width: 250, // Set the desired width here
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                color: Color.fromARGB(184, 255, 255, 255),
                child: Image.asset("assets/images/logo_tpk.png"),
              ),
            ),
            // Build DrawerListTile widgets for visible menu items
            Flexible(
              child: ListView(
                children: [
                  for (var item in visibleMenuItems)
                    DrawerListTile(
                      title: item["title"],
                      svgSrc: item["svgSrc"],
                      press: () {
                        if (item["page"] != null) {
                          CuPage = item["page"];
                          CuPageLV = item["accessLevel"];
                          MainBodyContext.read<ChangePage_Bloc>()
                              .add(ChangePage());
                        } else if (item["title"] == "Logout") {
                          LoginContext.read<Login_Bloc>().add(Logout());
                        }
                      },
                      textSize: 15.0,
                    ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Version : 1.0.9\nDate modify : 2024-Oct-10',
                style: TextStyle(fontSize: 10.0),
              ),
              leading: Icon(Icons.info),
            ),
          ],
        ),
      ),
    );
  }
}

// void _showAboutPopup(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('About'),
//         content: Text(
//           'Web application V.1.0.6 \n Developer by Automation Team.',
//           style: TextStyle(fontSize: 14.0),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Close'),
//           ),
//         ],
//       );
//     },
//   );
// }

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    this.textSize = 16.0, // Add textSize parameter with default value
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final double textSize; // Add textSize variable

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(
          Color.fromARGB(250, 0, 0, 0),
          BlendMode.srcIn,
        ),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(250, 0, 0, 0),
          fontSize: textSize, // Set the text size here
        ),
      ),
    );
  }
}
