import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      alignment: Alignment.center,
                      child: const Text('Plan je medicijn inname in',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  const SizedBox(height: 20),
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
                      // ElevatedButton(
                      //     onPressed: () {}, child: const Text('Confirm'))
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
                                colors: [Color(0xffeb6081), Color(0xffeb6081)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Handle button press
                              },
                              icon: const Icon(Icons.add, color: Colors.white),
                              iconSize: 40,
                              color: const Color(0xffeb6081),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
            ));
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
                height: 100,
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
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          height: 100,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: const Color(0xFFeff0f4),
            borderRadius: BorderRadius.circular(30),
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
                    'lib/assets/images/—Pngtree—pharmacy drug health tablet pharmaceutical_6861618.png'),
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
                                // Handle the action here
                              },
                              child: const Text(
                                'Show more',
                                style: TextStyle(
                                  color: Color(0xffeb6081),
                                ),
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
