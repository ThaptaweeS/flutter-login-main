import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newmaster/constants.dart';
import 'package:newmaster/data/global.dart';
import 'package:newmaster/mainBody.dart';
import 'package:newmaster/page/page02.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/cubit/NotificationEvent.dart';

late BuildContext Page02AutoContext;

class Page02Auto extends StatelessWidget {
  const Page02Auto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Page02AutoContext = context;

    return Page02Autobody();
  }
}

class Page02Autobody extends StatelessWidget {
  // Lists to store data from input fields
  List<bool> isCheckedList = List.generate(6, (index) => false);
  List<String> taList = List.generate(6, (index) => "");
  List<String> faList = List.generate(6, (index) => "");
  List<String> arList = List.generate(6, (index) => "");
  List<String> acList = List.generate(6, (index) => "");
  List<String> actualTempList = List.generate(6, (index) => "");
  List<String> timesList = List.generate(6, (index) => "01:00");
  List<String> remarkList = List.generate(6, (index) => "");

  bool isDataValid(List<String> missingFields) {
    for (int i = 0; i < isCheckedList.length; i++) {
      if (!isCheckedList[i] ||
          taList[i].isEmpty ||
          faList[i].isEmpty ||
          arList[i].isEmpty ||
          acList[i].isEmpty ||
          actualTempList[i].isEmpty ||
          timesList[i].isEmpty) {
        missingFields.add(getFieldName(i));
      }
    }
    return missingFields.isEmpty;
  }

  String getFieldName(int index) {
    switch (index) {
      case 0:
        return "Select";
      case 1:
        return "No.";
      case 2:
        return "Process (Tank Capacity)";
      case 3:
        return "T.A.";
      case 4:
        return "F.A.";
      case 5:
        return "A.R.";
      case 6:
        return "A.C.";
      case 7:
        return "Actual Temp";
      case 8:
        return "Times";
      case 9:
        return "Remark";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[50],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            CuPage = Page02body();
            MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              List<String> missingFields = [];
              if (isDataValid(missingFields)) {
                print("Button Pressed");
                print('CheckBox: $isCheckedList');
                print('T.A.: $taList');
                print('F.A.: $faList');
                print('A.R.: $arList');
                print('A.C.: $acList');
                print('Actual Temp: $actualTempList');
                print('Time: $timesList');
                print('Remark: $remarkList');

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirmation"),
                      content: Text("Are you sure you want to save data?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Perform actions when Confirm is pressed
                            print("Confirmed");

                            // You can access your variables here and perform further actions
                            Navigator.of(context).pop(); // Close the dialog
                            CuPage = Page02body();
                            MainBodyContext.read<ChangePage_Bloc>()
                                .add(ChangePage_nodrower());

                            BlocProvider.of<BlocNotification>(contextGB)
                                .UpdateNotification(
                                    "Success",
                                    "บันทึกข้อมูลสำเร็จ",
                                    enumNotificationlist.Information);
                          },
                          child: Text("Confirm"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error",
                          style: GoogleFonts.ramabhadra(color: Colors.black)),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("กรุณากรอกข้อมูลในช่องด้านล่างให้ครบถ้วน",
                              style:
                                  GoogleFonts.ramabhadra(color: Colors.black)),
                          for (String fieldName in missingFields)
                            Text("$fieldName"),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              SizedBox(height: 12),
              Text(
                'Data Input (Auto Feed)',
                style: GoogleFonts.ramabhadra(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: defaultPadding),
              Center(
                child: Column(
                  children: [
                    DataTable(
                      dataRowHeight: 100.0,
                      columnSpacing: 30.0,
                      columns: [
                        DataColumn(label: Text('Select')),
                        DataColumn(label: Text('No.')),
                        DataColumn(label: Text('Process (Tank Capacity)')),
                        DataColumn(
                          label: SizedBox(
                            width: 60,
                            child: Text('T.A.'),
                          ),
                          numeric: true,
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 60,
                            child: Text('F.A.'),
                          ),
                          numeric: true,
                          tooltip: 'F.A.',
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 60,
                            child: Text('A.R.'),
                          ),
                          numeric: true,
                          tooltip: 'A.R.',
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 60,
                            child: Text('A.C.'),
                          ),
                          numeric: true,
                          tooltip: 'A.C.',
                        ),
                        DataColumn(label: Text('Actual Temp')),
                        DataColumn(label: Text('Times')),
                        DataColumn(label: Text('Remark')),
                      ],
                      rows: List.generate(6, (index) {
                        return DataRow(
                          cells: [
                            DataCell(CheckboxWidget(
                              onChanged: (value) {
                                isCheckedList[index] = value;
                              },
                            )),
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(getProcessText(index))),
                            DataCell(
                              SizedBox(
                                width: 60,
                                child: NumberInputField(
                                  decimalPlaces: 3,
                                  onChanged: (value) {
                                    taList[index] = value;
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 60,
                                child: NumberInputField(
                                  decimalPlaces: 3,
                                  onChanged: (value) {
                                    faList[index] = value;
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 60,
                                child: NumberInputField(
                                  decimalPlaces: 3,
                                  onChanged: (value) {
                                    arList[index] = value;
                                  },
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 60,
                                child: NumberInputField(
                                  decimalPlaces: 3,
                                  onChanged: (value) {
                                    acList[index] = value;
                                  },
                                ),
                              ),
                            ),
                            DataCell(NumberInputField(
                              decimalPlaces: 2,
                              onChanged: (value) {
                                actualTempList[index] = value;
                              },
                            )),
                            DataCell(DropdownSelect(
                              onChanged: (value) {
                                timesList[index] = value;
                              },
                            )),
                            DataCell(
                              SizedBox(
                                width: 180,
                                child: TextInputField(
                                  onChanged: (value) {
                                    remarkList[index] = value;
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: defaultPadding),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getProcessText(int index) {
    switch (index) {
      case 0:
        return "Zinc Phosphate (3650X)\n(Palbond 3650X (PB-3650X))";
      case 1:
        return "Zinc Phosphate (181X)\n(Palbond 3650X (PB-181X))";
      case 2:
        return "Degreasing\n(Fine Cleaner 4360)";
      case 3:
        return "Acid picking No.1\n(Hydrocholic 10-15%)";
      case 4:
        return "Lubricant (4681)\n(Palube 4618 (LUB-4618))";
      case 5:
        return "Lubricant (255)\n(Palube 235 (LUB-235))";
      default:
        return "";
    }
  }
}

class CheckboxWidget extends StatefulWidget {
  final ValueChanged<bool>? onChanged;

  CheckboxWidget({this.onChanged});

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value!);
        }
      },
    );
  }
}

class NumberInputField extends StatelessWidget {
  final int decimalPlaces;
  final ValueChanged<String>? onChanged;

  NumberInputField({required this.decimalPlaces, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: '',
      ),
      onChanged: onChanged,
    );
  }
}

class DropdownSelect extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  DropdownSelect({this.onChanged});

  @override
  _DropdownSelectState createState() => _DropdownSelectState();
}

class _DropdownSelectState extends State<DropdownSelect> {
  String selectedTime = "01:00";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedTime,
      onChanged: (String? newValue) {
        setState(() {
          selectedTime = newValue!;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue!);
        }
      },
      items: <String>['01:00', '07:00', '13:00', '19:00']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class TextInputField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  TextInputField({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter Remark',
      ),
      onChanged: onChanged,
    );
  }
}
