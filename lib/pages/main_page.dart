import 'package:open_counter/logic/data_logic.dart';
import 'package:open_counter/pages/settings_page.dart';
import 'package:open_counter/widgets/build_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int counter = 0;
  int setLimit = 0;
  bool enableTapArea = true;

  @override
  void initState() {
    super.initState();
    _loadCounterSetting();
    _loadTapAreaSetting();
  }

  void _loadCounterSetting() async {
    final prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('counter');

    setState(() {
      counter = value ?? 0;
    });
  }

  void _loadTapAreaSetting() async {
    final prefs = await SharedPreferences.getInstance();
    bool? value =  prefs.getBool('isTapAreaEnabled');
    
    setState(() {
      enableTapArea = value ?? true;
    });
  }

  void decreaseCounter() {
    setState(() {
      counter--;
      saveInt('counter', counter);
      countLimit();
    });
  }

  void increaseCounter() {
    setState(() {
      counter++;
      saveInt('counter', counter);
      countLimit();
    });
  }

  // switch tap area setting to true (so tap area enabled) or false (tap area is disabled)
  // and save it to shared_preferences
  void switchTapArea(bool isTapAreaEnabled) {
    setState(() {
      saveBool('isTapAreaEnabled', isTapAreaEnabled);
      enableTapArea = isTapAreaEnabled;
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

  void setLimitTo(int newLimit) {
    setState(() {
      setLimit = newLimit;
    });
  }

  String countLimit() {
    // if setLimit is set to zero, then do not do anything
    if(setLimit != 0) {
      if(setLimit-counter > 0) {
        return ('${setLimit-counter} Available');
      } else {
        return ('${setLimit-counter} Limit Reached');
      }
    }
    return '';
  }

  void navigateToSettingsPage() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SettingsPage(
        counter: counter,
        setLimit: setLimit,
        enableTapArea: enableTapArea,
        setCounterTo: setCounterTo,
        setLimitTo: setLimitTo,
        switchTapArea: switchTapArea,
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
                      // click area
                      onTap: () {
                        if(enableTapArea) {
                          decreaseCounter();
                        }
                      }
                    ),
                  ),
                  // counter digit
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(counter.toString(), style: TextStyle(fontSize: 75)),
                        // hide limit banner if setLimit is set to zero,
                        // othwerwise show banner 
                        Text(
                          setLimit == 0
                          ? '' : countLimit(), 
                          style: TextStyle(fontSize: 15)
                        ),
                      ],
                    ),
                  ),
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
                      // click area
                      onTap: () {
                        if(enableTapArea) {
                          increaseCounter();
                        }
                      }
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