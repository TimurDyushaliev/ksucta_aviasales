import 'package:aviasales/models/search_query.dart';
import 'package:aviasales/resource/string_resource.dart';
import 'package:aviasales/view/pages/flights_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<TextEditingController> textEditingControllers;
  late GlobalKey<FormState> formKey;

  final hints = <String>[
    StringResource.fromTextHint,
    StringResource.targetTextHint,
    StringResource.dateTextHint,
    StringResource.passengerTextHint,
  ];

  DateTime? selectedDate;

  @override
  void initState() {
    textEditingControllers =
        List.generate(4, (index) => TextEditingController(), growable: false);
    formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textEditingControllers.map<Widget>((controller) {
              final index = textEditingControllers.indexOf(controller);
              final isDateTimeField = index == 2;

              return TextFormField(
                controller: controller,
                decoration: InputDecoration(hintText: hints[index]),
                keyboardType: index == 3 ? TextInputType.number : null,
                readOnly: isDateTimeField,
                onTap: () async {
                  if (isDateTimeField) {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        controller.text =
                            '${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}';
                      });
                    }
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringResource.emptyFieldError;
                  }
                  return null;
                },
              );
            }).toList()
              ..add(Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        selectedDate != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlightsPage(
                            searchQuery: SearchQuery(
                              departureCity: textEditingControllers[0].text,
                              arrivalCity: textEditingControllers[1].text,
                              dateTime: selectedDate!,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(StringResource.searchTickets),
                ),
              )),
          ),
        ),
      ),
    );
  }
}
