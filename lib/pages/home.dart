import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

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
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Row(
                      children: [
                        // Use the Padding widget to remove inherent padding around the IconButton
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
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
                                    fontWeight: FontWeight.bold, fontSize: 15)),
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
                            hintText: 'Antibiotica')
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
                                  hintText: '2 pills'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hoevaak Innemen'),
                            const HeightEight(),
                            inputStyle(
                                prefixIcon: Icons.calendar_today_outlined,
                                hintText: 'Elke dag')
                          ],
                        ))
                      ],
                    ),
                    const HeightTwelve(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dosis'),
                        const HeightEight(),
                        inputStyle(
                            prefixIcon: Icons.add_moderator_outlined,
                            hintText: '250MG')
                      ],
                    ),
                    const HeightTwelve(),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Hoevaak Herhalen'),
                          const HeightEight(),
                          inputStyle(
                              prefixIcon: Icons.calendar_today,
                              hintText: 'Elke Dag')
                        ]),
                    const HeightTwelve(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Herinnering'),
                              const HeightEight(),
                              inputStyle(
                                  prefixIcon: Icons.alarm_sharp,
                                  hintText: '09:00')
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
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
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
                        const HeightEight(),
                        SizedBox(
                          height:
                              20, // You may want to increase this if the icons are clipped
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: SvgPicture.asset(
                                      'assets/images/svg/blue-pill.svg',
                                    ));
                              }),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
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
                        onPressed: () {},
                        child: const Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ))
                  ]),
                )));
      },
    );
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

Widget inputStyle({IconData? prefixIcon, String? hintText}) {
  return TextField(
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

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.formattedDate,
  });

  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              'Today, $formattedDate',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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

                    return Container(
                      margin: EdgeInsets.only(
                          left: index == 0 ? 10 : 5,
                          right:
                              5), // Add space on the left only for the first item
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFFeff0f4),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(dateNumber,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text(day)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        const MedicationCard()
      ],
    );
  }
}

class MedicationCard extends StatelessWidget {
  const MedicationCard({
    super.key,
  });

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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Detoxil',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      SizedBox(
                        height: 2,
                      ),
                      Text('20mg pills')
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
                                style: TextStyle(color: Color(0xffeb6081), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Transform.scale(
                                scale: 1,
                                child: const  Stack(
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
                                        color: Colors.white), // Adjust the size as needed
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
                                style: TextStyle(color: Color(0xffeb6081), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Transform.scale(
                                scale: 1,
                                child: const  Stack(
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
                                        color: Colors.white), // Adjust the size as needed
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
                                style: TextStyle(color: Color(0xffeb6081), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Transform.scale(
                                scale: 1,
                                child: const  Stack(
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
                                        color: Colors.white), // Adjust the size as needed
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
                    const Text(
                      'Detoxil, 20MG',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.access_time_filled, size: 15),
                            SizedBox(
                                width:
                                    5), // A small space between icon and text
                            Text('14:00'),
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
