import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

final collection = FirebaseFirestore.instance.collection('medication');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController reminderTimesController = TextEditingController();
  final TextEditingController appearanceController = TextEditingController();

  final List<String> _allDays = [
    'Maandag',
    'Dinsdag',
    'Woensdag',
    'Donderdag',
    'Vrijdag',
    'Zaterdag',
    'Zondag'
  ];
  List<String> _selectedDays = [];

  List<String> imageUrls = [
    'assets/images/black-outlined-bottle.png',
    'assets/images/black-outlined-pill.png',
    'assets/images/blue-pill.png',
    'assets/images/blue-yellow-tablet.png',
    'assets/images/colored-bottle.png',
    'assets/images/green-pill.png',
    'assets/images/orange-tablet.png',
    'assets/images/pink-pill.png',
    'assets/images/pink-tablet.png',
    'assets/images/white-tablet.png',
  ];

  String selectedImageUrl = '';

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMMM').format(DateTime.now());

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Overview',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: DateSelector(formattedDate: formattedDate),
        bottomNavigationBar: Footer(
          onButtonPressed: _showFormBottomSheet,
        ));
  }

  void _showFormBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
            child: SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Row(
                          children: [
                            // Use the Padding widget to remove inherent padding around the IconButton
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Color(0xffeb6081), size: 20),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              constraints:
                                  const BoxConstraints(), // This removes minimum size constraints
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('Plan je medicijn inname in',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xffeb6081))),
                              ),
                            ),
                          ],
                        ),
                        const HeightTwelve(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Medicijn Naam'),
                            const HeightEight(),
                            inputStyle(
                                prefixIcon: Icons.medication_rounded,
                                hintText: 'Paracetamol/Hoestdrank',
                                controller: nameController)
                          ],
                        ),
                        const HeightTwelve(),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Hoeveelheid'),
                                  const HeightEight(),
                                  inputStyle(
                                      prefixIcon: Icons.medical_information,
                                      hintText: '1 pil/tablet',
                                      controller: amountController)
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Dosis'),
                                const HeightEight(),
                                inputStyle(
                                    prefixIcon: Icons.my_library_add_rounded,
                                    hintText: '500mg/ml',
                                    controller: dosageController)
                              ],
                            ))
                          ],
                        ),
                        const HeightTwelve(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Welke dag(en)'),
                            const HeightEight(),
                            MultiSelectBottomSheetField(
                              initialChildSize: 0.4,
                              listType: MultiSelectListType.LIST,
                              searchable: true,
                              items: _allDays
                                  .map((day) => MultiSelectItem(day, day))
                                  .toList(),
                              onConfirm: (values) {
                                _selectedDays = List<String>.from(values);
                              },
                              chipDisplay: MultiSelectChipDisplay(
                                onTap: (value) {
                                  setState(() {
                                    _selectedDays.remove(value);
                                  });
                                },
                              ),
                              buttonText: const Text(
                                "Selecteer dagen",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                              title: const Text(
                                "Dagen",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              buttonIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey[700],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                        const HeightTwelve(),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Gewenste tijd(en) instellen'),
                                  const HeightEight(),
                                  inputStyle(
                                      prefixIcon: Icons.alarm_sharp,
                                      hintText: '09:00',
                                      controller: reminderTimesController)
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffeb6081),
                                        Color(0xffeb6081)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // Handle button press
                                    },
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    iconSize: 40,
                                    color: const Color(0xffeb6081),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const HeightTwelve(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Uiterlijk'),
                            SizedBox(
                              height:
                                  80, // Adjust the height to fit your images and labels
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageUrls.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageUrl = imageUrls[index];
                                      });
                                    },
                                    child: Container(
                                      width:
                                          80, // Adjust the width as necessary
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      color: selectedImageUrl ==
                                              imageUrls[index]
                                          ? Colors.blue
                                          : Colors
                                              .transparent, // Highlight selected image
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Image.asset(
                                                imageUrls[index]), // Image
                                          ), // Replace with your actual labels as necessary
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 90),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) => const Color(0xffeb6081)),
                                minimumSize:
                                    MaterialStateProperty.resolveWith<Size>(
                                  (states) => Size(
                                      MediaQuery.of(context).size.width * 0.95,
                                      50.0),
                                )),
                            onPressed: addReminder,
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ))
                      ]),
                    ))));
      },
    );
  }

  Future<void> addReminder() async {
    await collection.add({
      'name': nameController.text,
      'amount': amountController.text,
      'dosage': dosageController.text,
      'days': _selectedDays,
      'reminder_times': reminderTimesController.text,
      'appearance': selectedImageUrl,
    });
  }
}

class HeightTwelve extends StatelessWidget {
  const HeightTwelve({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 12);
  }
}

class HeightEight extends StatelessWidget {
  const HeightEight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 8);
  }
}

Widget inputStyle(
    {IconData? prefixIcon,
    String? hintText,
    required TextEditingController controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(prefixIcon),
      hintText: hintText,
    ),
  );
}

class DateSelector extends StatefulWidget {
  final String formattedDate;

  const DateSelector({
    Key? key,
    required this.formattedDate,
  }) : super(key: key);

  @override
  DateSelectorState createState() => DateSelectorState();
}

class DateSelectorState extends State<DateSelector> {
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(true);
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            onExpansionChanged: (bool expanded) {
              _isExpanded.value = expanded;
            },
            initiallyExpanded: true,
            trailing: ValueListenableBuilder<bool>(
              valueListenable: _isExpanded,
              builder: (context, isExpanded, child) {
                return RotatedBox(
                  quarterTurns: isExpanded ? 0 : 2,
                  child: const Icon(
                    Icons.expand_more,
                    color: Color(0xffeb6081),
                  ),
                );
              },
            ),
            title: Text(
              'Today, ${widget.formattedDate}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            children: [
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime nextDate =
                        DateTime.now().add(Duration(days: index));
                    String dateNumber = DateFormat('d').format(nextDate);
                    String day =
                        DateFormat('EEE').format(nextDate).substring(0, 3);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = nextDate;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? 10 : 5,
                          right: 5,
                        ),
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: nextDate.day == _selectedDate.day
                              ? const Color(0xffeb6081)
                              : const Color(0xFFeff0f4),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dateNumber,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: nextDate.day == _selectedDate.day
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                day,
                                style: TextStyle(
                                  color: nextDate.day == _selectedDate.day
                                      ? Colors.white
                                      : Colors.black, // Change here for the day
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        MedicationCard(date: _selectedDate),
      ],
    );
  }
}

class MedicationCard extends StatefulWidget {
  final DateTime date;

  MedicationCard({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  _MedicationCardState createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  String name = '';
  String dosage = '';
  String image = '';
  List<String> days = []; 
  List<dynamic> reminderTime = []; 
  String amount = ''; 

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot querySnapshot = await collection.get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          name = data['name'] ?? ''; // Handle null values
          dosage = data['dosage'] ?? ''; // Handle null values
          image = data['image'];
          days = List<String>.from(data['days']); // Assign the fetched data
          reminderTime = List<dynamic>.from(data['reminder_time']); // Assign the fetched data
          amount = data['amount'] ?? '';
        });
      }
    } catch (e) {
      print('got an error: $e');
    }
  }

  // Future<void> fetchData() async {
  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.95,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const HeightTwelve(),
                Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Color(0xffeb6081),
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      constraints:
                          const BoxConstraints(), // This removes minimum size constraints
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Terug',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xffeb6081),
                        ),
                      ),
                    ))
                  ],
                ),
                const HeightTwelve(),
                const Placeholder(
                  color: Colors.red,
                  fallbackHeight: 200,
                  fallbackWidth: 0.90,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(dosage)
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: const Color(0xFFeff0f4),
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10), // adjusted padding
                          child: Row(children: [
                            Image.asset(
                              'assets/images/—Pngtree—pharmacy drug health tablet pharmaceutical_6861618.png',
                              width: 40, // reduced image width
                            ),
                            const SizedBox(width: 5), // reduced spacing
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('60 mg',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                SizedBox(height: 5),
                                Text('Daily Dosage')
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // reduced spacing
                    Expanded(
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: const Color(0xFFeff0f4),
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10), // adjusted padding
                          child: Row(children: [
                            Image.asset(
                              'assets/images/—Pngtree—pharmacy drug health tablet pharmaceutical_6861618.png',
                              width: 40, // reduced image width
                            ),
                            const SizedBox(width: 5), // reduced spacing
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('3x Pills',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                SizedBox(height: 5),
                                Text('Each Day')
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gepland',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFeff0f4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '10:00',
                                style: TextStyle(
                                    color: Color(0xffeb6081),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Transform.scale(
                                scale: 1,
                                child: const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Checkbox(
                                      shape: CircleBorder(),
                                      value: true,
                                      onChanged: null,
                                      activeColor: Colors.green,
                                      checkColor:
                                          Colors.green, // same as activeColor
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    Icon(Icons.check,
                                        size: 12,
                                        color: Colors
                                            .white), // Adjust the size as needed
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '15:00',
                                style: TextStyle(
                                    color: Color(0xffeb6081),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Transform.scale(
                                scale: 1,
                                child: const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Checkbox(
                                      shape: CircleBorder(),
                                      value: false,
                                      onChanged: null,
                                      activeColor: Colors.green,
                                      checkColor:
                                          Colors.green, // same as activeColor
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    Icon(Icons.check,
                                        size: 12,
                                        color: Colors
                                            .white), // Adjust the size as needed
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '18:00',
                                style: TextStyle(
                                    color: Color(0xffeb6081),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Transform.scale(
                                scale: 1,
                                child: const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Checkbox(
                                      shape: CircleBorder(),
                                      value: false,
                                      onChanged: null,
                                      activeColor: Colors.green,
                                      checkColor:
                                          Colors.green, // same as activeColor
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    Icon(Icons.check,
                                        size: 12,
                                        color: Colors
                                            .white), // Adjust the size as needed
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const HeightTwelve(),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffeb6081))),
                          onPressed: scanBarcode,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center the content horizontally
                            children: <Widget>[
                              Icon(Icons
                                  .camera_alt_rounded), // The icon you want
                              SizedBox(
                                  width:
                                      8), // Optional: Adds a spacing between the icon and text
                              Text('Scan Barcode'), // The text content
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 15, top: 30),
          child: const Text('To take',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 18, bottom: 5),
          height: 100,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: const Color(0xFFeff0f4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center alignment vertically
            children: [
              const SizedBox(width: 20),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Image.asset(
                    'assets/images/—Pngtree—pharmacy drug health tablet pharmaceutical_6861618.png'),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name, $dosage',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.access_time_filled, size: 15),
                            const SizedBox(
                                width:
                                    5), // A small space between icon and text
                            Text('$reminderTime'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                _showDetails(context);
                              },
                              child: const Icon(
                                Icons.info,
                                color: Color(0xffeb6081),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key, required this.onButtonPressed}) : super(key: key);

  final void Function() onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const Expanded(child: Icon(Icons.home, size: 30)),
          Expanded(
            child: FloatingActionButton(
                backgroundColor: const Color(0xffeb6081),
                onPressed: onButtonPressed,
                child: const Icon(Icons.add)),
          ),
          const Expanded(child: Icon(Icons.history, size: 30))
        ],
      ),
    );
  }
}

Future<void> scanBarcode() async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", // The color for the scan button
      "Cancel", // The string for the cancel button
      true, // Set to false to disable the beep on scan
      ScanMode.BARCODE, // Can be set to QR or other modes
    );
    if (barcodeScanRes == "-1") {
      // User canceled or other error
      return;
    }
    // Do something with barcodeScanRes
    print(barcodeScanRes);
  } catch (e) {
    print(e);
  }
}
