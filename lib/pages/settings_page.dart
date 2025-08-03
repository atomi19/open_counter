import 'package:open_counter/widgets/build_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final int counter;
  final Function(int) setCounterTo;

  const SettingsPage({
    super.key,
    required this.counter,
    required this.setCounterTo,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController counterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    counterController.text = widget.counter.toString();
  }

  Widget buildSettingsCard(Widget child) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(26, 0, 0, 0),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ]
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: child
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // top bar
            Container(
              padding: EdgeInsets.all(15),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Settings', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  buildIconButton(
                    IconButton(
                      onPressed: () => Navigator.pop(context), 
                      icon: const Icon(Icons.close)
                    )
                  )
                ],
              ),
            ),
            // body
            buildSettingsCard(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Set Counter To', style: TextStyle(fontSize: 16)),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      controller: counterController,
                      onChanged: (String value) {
                        int newCounter = 0;
                        try {
                          newCounter = value == '' ? 0 : int.parse(value);
                        } catch (e) {
                          newCounter = 0;
                        }
                        widget.setCounterTo(newCounter);
                      }
                    )
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}