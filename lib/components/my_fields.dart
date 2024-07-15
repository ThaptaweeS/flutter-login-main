import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/models/MyFiles.dart';
import 'package:newmaster/responsive.dart';

class MyFiles extends StatefulWidget {
  MyFiles({
    Key? key,
    this.taptaptap,
  }) : super(key: key);
  Function(CloudStorageInfo)? taptaptap;

  @override
  _MyFilesState createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  late CloudStorageInfo? _selectedFileInfo;
  late List<Map<String, dynamic>> tableData = [];
  late Timer _timer; // Timer variable
  Map<int, bool> _visibilityStates = {
    0: true,
    1: true,
    2: true,
    3: true,
    4: true,
    5: true,
    6: true,
  };

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Select Tank",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(width: 25), // Add spacing between text and icons
                CircleAvatar(
                  backgroundColor:
                      Colors.green, // Customize the color of the circle icon
                  radius: 10, // Customize the size of the circle icon
                ),
                SizedBox(width: 5),
                Text(
                  "Pass",
                  style: TextStyle(
                    fontSize: 11, // Set the desired font size here
                    // You can also customize other text properties here if needed
                  ),
                ),
                SizedBox(width: 15), // Add spacing between circle icons
                CircleAvatar(
                  backgroundColor:
                      Colors.yellow, // Customize the color of the circle icon
                  radius: 10, // Customize the size of the circle icon
                ),
                SizedBox(width: 5),
                Text(
                  "Waiting Check",
                  style: TextStyle(
                    fontSize: 11, // Set the desired font size here
                    // You can also customize other text properties here if needed
                  ),
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor:
                      Colors.red, // Customize the color of the circle icon
                  radius: 10, // Customize the size of the circle icon
                ),
                SizedBox(width: 5),
                Text(
                  "NG Value",
                  style: TextStyle(
                    fontSize: 11, // Set the desired font size here
                    // You can also customize other text properties here if needed
                  ),
                )
                // Add more CircleAvatar widgets as needed
              ],
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            taptap: widget.taptaptap,
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            visibilityStates: _visibilityStates,
            toggleVisibility: _toggleVisibility,
          ),
          tablet: FileInfoCardGridView(
            taptap: widget.taptaptap,
            visibilityStates: _visibilityStates,
            toggleVisibility: _toggleVisibility,
          ),
          desktop: FileInfoCardGridView(
            taptap: widget.taptaptap,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            visibilityStates: _visibilityStates,
            toggleVisibility: _toggleVisibility,
          ),
        ),
      ],
    );
  }

  void _toggleVisibility(int index) {
    setState(() {
      _visibilityStates[index] = !_visibilityStates[index]!;
    });
  }
}

class FileInfoCardGridView extends StatelessWidget {
  FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 7,
    this.childAspectRatio = 1,
    this.taptap,
    required this.visibilityStates,
    required this.toggleVisibility,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final Function(CloudStorageInfo)? taptap;
  final Map<int, bool> visibilityStates;
  final Function(int) toggleVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(demoMyFiles.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  onPressed: () => toggleVisibility(index),
                  child: Text(visibilityStates[index]!
                      ? 'Hide ${index + 1}'
                      : 'Show ${index + 1}'),
                ),
              );
            }),
          ),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: demoMyFiles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return Visibility(
              visible: visibilityStates[index]!,
              child: InkWell(
                onTap: () {
                  if (taptap != null) {
                    taptap!(demoMyFiles[index]);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.circle,
                              color: getStatusColor(index), size: 16),
                          Icon(Icons.circle,
                              color: getStatusColor(index), size: 16),
                        ],
                      ),
                      Text(
                        demoMyFiles[index].title!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        demoMyFiles[index].totalStorage!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Color getStatusColor(int index) {
    switch (index % 3) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
