import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(key: key); // Veranderd naar Key? voor null safety

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Drag handle (pull bar)
              Center(
                child: Container(
                  width: 40,  // You can adjust the width to fit your design
                  height: 4,   // You can adjust the height to fit your design
                  margin: const EdgeInsets.symmetric(vertical: 12),  // Space from top and bottom
                  decoration: BoxDecoration(
                    color: Colors.grey[300],  // Color of the drag handle
                    borderRadius: BorderRadius.circular(2.5),  // Slightly rounded corners
                  ),
                ),
              ),

              // Rest of your form goes here
              Form(
                key: _formKey,
                child: Expanded(  // Making the form take all remaining space
                  child: ListView(  // Changed from Column to ListView
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Medicijn Naam'),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Dosering'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Hoevaak per dag'),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Hoevaak dagen in de week innemen'),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Welke dagen in de week'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Tijdstip van inname'),
                      ),
                      ElevatedButton(onPressed: () {}, child: const Text('Confirm'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildDateContainer(DateTime date) {
  // Format the date to get the day of the month.
  String dayOfMonth = DateFormat('d').format(date);
  
  // Get the day name (first three letters).
  String dayName = DateFormat('EEE').format(date);

  // Create a container widget with the formatted date and day name.
  return Container(
    margin: const EdgeInsets.all(4.0), // Add margin for spacing
    padding: const EdgeInsets.all(20.0), 
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dayName,
          style: const TextStyle(color: Colors.white, fontSize: 5),
        ),
        Text(
          dayOfMonth,
          style: const TextStyle(color: Colors.white, fontSize: 5),
        ),
      ],
    ),
  );
}


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
      body: ExpansionTile(
        title: Row(
          children: [
            Text(
              'Today, $formattedDate',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ],
        ),
        children: [
          Container(
            height: 80, // This is your fixed height for the container
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // makes the list scroll horizontally
              itemBuilder: (BuildContext context, int index) {
                // Calculate the date for this container based on the index.
                DateTime thisDate = DateTime.now().add(Duration(days: index));

                // Return a widget for this date.
                return _buildDateContainer(thisDate);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showFormBottomSheet();
        },
      ),
    );
  }
}
