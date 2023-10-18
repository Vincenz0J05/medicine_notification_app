import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
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
                        labelText: 'Hoevaal dagen in de week innemen'),
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
        );
      },
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
      body: 
      ExpansionTile(
      title: Text(
        'Today, $formattedDate',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
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