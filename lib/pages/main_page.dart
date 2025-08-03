import 'package:open_counter/pages/settings_page.dart';
import 'package:open_counter/widgets/build_button.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int counter = 0;

  void decreaseCounter() {
    setState(() {
      counter--;
    });
  }

  void increaseCounter() {
    setState(() {
      counter++;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  void setCounterTo(int newCounter) {
    setState(() {
      counter = newCounter;
    });
  }

  void navigateToSettingsPage() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SettingsPage(
        counter: counter,
        setCounterTo: setCounterTo,
      ))
    );
  }

  // show reset alert dialog
  void showAlertDialog() {
    showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.grey.shade100,
        title: const Text('Reset Counter'),
        content: const Text('Are you sure you want to reset the counter to 0?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTextButton(
                context: context,
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: Theme.of(context).iconTheme.color))
              ),
              buildTextButton(
                context: context,
                onPressed: () {
                  Navigator.pop(context);
                  resetCounter();
                }, 
                child: const Text('Reset', style: TextStyle(color: Colors.red))
              )
            ],
          ),
        ],
      )
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
                  // reset button
                  buildIconButton(
                    IconButton(
                      onPressed: () => showAlertDialog(),
                      icon: const Icon(Icons.replay)
                    ),
                  ),
                  // settings button
                  buildIconButton(
                    IconButton(
                      onPressed: () => navigateToSettingsPage(),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white
                      ),
                      icon: const Icon(Icons.settings)
                    ) 
                  ),
                ],
              ),
            ),
            // app body
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // left side
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: buildIconButton(
                          IconButton(
                            onPressed: () => decreaseCounter(), 
                            icon: const Icon(Icons.remove)
                          )
                        )
                      ),
                      onTap: () => decreaseCounter(),
                    ),
                  ),
                  // counter digit
                  Text(counter.toString(), style: TextStyle(fontSize: 75)),
                  // right side
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: buildIconButton(
                          IconButton(
                            onPressed: () => increaseCounter(), 
                            icon: const Icon(Icons.add)
                          )
                        ),
                      ),
                      onTap: () => increaseCounter(),
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}