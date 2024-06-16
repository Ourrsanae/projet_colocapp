import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetpfe/themes/theme.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class HEditInformation extends StatefulWidget {
  final String annonceId;

  const HEditInformation({super.key, required this.annonceId});

  @override
  State<HEditInformation> createState() => _HEditInformationState();
}

class _HEditInformationState extends State<HEditInformation> {
  List<String>? _myLanguages;
  List<String>? _myLifeStyle;
  List<String>? _myPersonality;
  List<String>? _myHobbis;
  Color selectedColor = lightColorScheme.outlineVariant;
  Color selectedColor2 = lightColorScheme.outlineVariant;
  Color selectedColor3 = lightColorScheme.outlineVariant;
  String? status;

  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    _myLanguages = [];
    _myLifeStyle = [];
    _myPersonality = [];
    _myHobbis = [];
  }

  final List<Map<String, String>> listLanguages = [
    {"display": "Arabic", "value": "Arabic"},
    {"display": "English", "value": "English"},
    {"display": "French", "value": "French"},
    {"display": "German", "value": "German"},
    {"display": "Chinese", "value": "Chinese"},
    {"display": "Spanish", "value": "Spanish"},
    {"display": "Japanese", "value": "Japanese"},
  ];

  final List<Map<String, String>> listPersonality = [
    {"display": "Serious", "value": "Serious"},
    {"display": "Lazy", "value": "Lazy"},
    {"display": "Generous", "value": "Generous"},
    {"display": "Up early", "value": "Up early"},
    {"display": "Responsible", "value": "Responsible"},
    {"display": "Irresponsible", "value": "Irresponsible"},
    {"display": "Hyperactive", "value": "Hyperactive"},
    {"display": "Self-centered", "value": "Self-centered"},
    {"display": "Calm", "value": "Calm"},
    {"display": "Perfectionist", "value": "Perfectionist"},
    {"display": "Outgoing", "value": "Outgoing"},
    {"display": "Night owl", "value": "Night owl"},
    {"display": "Mischievous", "value": "Mischievous"},
    {"display": "Introverted", "value": "Introverted"},
    {"display": "Sociable", "value": "Sociable"},
    {"display": "Indifferent", "value": "Indifferent"},
  ];

  final List<Map<String, String>> listLifestyle = [
    {"display": "Dog lover", "value": "Dog lover"},
    {"display": "Cat lover", "value": "Cat lover"},
    {"display": "Messy", "value": "Messy"},
    {"display": "Ordered", "value": "Ordered"},
    {"display": "Always late", "value": "Always late"},
    {"display": "Vegetarian", "value": "Vegetarian"},
    {"display": "Fast food", "value": "Fast food"},
    {"display": "Without diet", "value": "Without diet"},
  ];

  final List<Map<String, String>> listHobbis = [
    {"display": "Music", "value": "Music"},
    {"display": "Movies", "value": "Movies"},
    {"display": "Arts", "value": "Arts"},
    {"display": "Computer science", "value": "Computer science"},
    {"display": "Gaming", "value": "Gaming"},
    {"display": "Sport", "value": "Sport"},
    {"display": "Anime", "value": "Anime"},
  ];

  void send() async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();

      try {
        await FirebaseFirestore.instance.collection('announces').doc(widget.annonceId).update({
          'languages': _myLanguages,
          'lifestyle': _myLifeStyle,
          'personality': _myPersonality,
          'hobbies': _myHobbis,
          'status': status,
        });

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Done'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Fill Profile"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildStatusOption(Icons.school, "Student", selectedColor, () {
                            setState(() {
                              selectedColor = selectedColor == lightColorScheme.outlineVariant ? lightColorScheme.primary : lightColorScheme.outlineVariant;
                              status = "Student";
                            });
                          }),
                          buildStatusOption(Icons.card_travel, "Professional", selectedColor2, () {
                            setState(() {
                              selectedColor2 = selectedColor2 == lightColorScheme.outlineVariant ? lightColorScheme.primary : lightColorScheme.outlineVariant;
                              status = "Professional";
                            });
                          }),
                          buildStatusOption(Icons.computer, "Freelancer", selectedColor3, () {
                            setState(() {
                              selectedColor3 = selectedColor3 == lightColorScheme.outlineVariant ? lightColorScheme.primary : lightColorScheme.outlineVariant;
                              status = "Freelancer";
                            });
                          }),
                        ],
                      ),
                      Form(
                        key: formState,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            buildMultiSelectField(
                              title: "Languages",
                              dataSource: listLanguages,
                              initialValue: _myLanguages ?? [],
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _myLanguages = value;
                                });
                              },
                            ),
                            buildMultiSelectField(
                              title: "Personality",
                              dataSource: listPersonality,
                              initialValue: _myPersonality ?? [],
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _myPersonality = value;
                                });
                              },
                            ),
                            buildMultiSelectField(
                              title: "LifeStyle",
                              dataSource: listLifestyle,
                              initialValue: _myLifeStyle ?? [],
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _myLifeStyle = value;
                                });
                              },
                            ),
                            buildMultiSelectField(
                              title: "Hobbies",
                              dataSource: listHobbis,
                              initialValue: _myHobbis ?? [],
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _myHobbis = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              onPressed: send,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lightColorScheme.primary,
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusOption(IconData icon, String label, Color color, VoidCallback onPressed) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(200)),
          ),
          child: CircleAvatar(
            radius: 34,
            backgroundColor: color.withOpacity(0.3),
            child: IconButton(
              icon: Icon(icon, color: color),
              onPressed: onPressed,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget buildMultiSelectField({
    required String title,
    required List<Map<String, String>> dataSource,
    required List<String> initialValue,
    required Function(List<String>?) onSaved,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: lightColorScheme.primary, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          MultiSelectDialogField(
            items: dataSource.map((item) => MultiSelectItem(item['value'] ?? '', item['display'] ?? '')).toList(),
            listType: MultiSelectListType.CHIP,
            initialValue: initialValue,
            onConfirm: (values) {
              onSaved(values.map((value) => value.toString()).toList());
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                setState(() {
                  initialValue.remove(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
