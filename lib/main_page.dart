import 'package:bmical/constants.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int height = 150;
  int weight = 70;
  String geneder = '';

  late double bmiValue = calBMI(height: height, weight: weight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        // padding: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Column(children: [
          // first row (geneder selecting part)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      geneder = 'M';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: geneder == 'M' ? Colors.orange.withAlpha(150) : Colors.orange.withAlpha(50),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.male,
                          size: 150,
                        ),
                        Text("Male"),
                      ],
                    ),
                  ),
                ),
                
                const Spacer(),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      geneder = 'F';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: geneder == 'F' ? Colors.orange.withAlpha(150) : Colors.orange.withAlpha(50),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.female,
                          size: 150,
                        ),
                        Text("Female"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 50,),
          // second row (height and weight selecting part)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text("Height"),
                    Text(
                      "$height",
                      style: kInputTextColor,
                    ),
                    Row(
                      children: [
                        FloatingActionButton(
                          onPressed: onHeightMinus,
                          child: const Icon(
                            Icons.remove,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 20,),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              height++;
                              bmiValue = calBMI(height: height, weight: weight);
                            });
                          },
                          child: const Icon(
                            Icons.add,
                            size: 40,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text("Weight"),
                    Text(
                      "$weight",
                      style: kInputTextColor,
                    ),
                    Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            if(weight > 25){
                              setState(() {
                                weight--;
                                bmiValue = calBMI(height: height, weight: weight);
                              });
                            }
                          },
                          child: const Icon(
                            Icons.remove,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 20,),
                        FloatingActionButton(
                          onPressed: () {
                            if(weight < 200){
                              setState(() {
                                weight++;
                                bmiValue = calBMI(height: height, weight: weight);
                              });
                            }
                          },
                          child: const Icon(
                            Icons.add,
                            size: 40,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50,),
          Column(
            children: [
              const Text("BMI"),
              Text(
                bmiValue.toStringAsFixed(2),
                style: kInputTextColor.copyWith(
                  color: kOutputTextColr,
                  fontSize: 60
                ),
              ),
              Text(
                analyzeResult(bmiValue: bmiValue)
              )
            ],
          )
        ]),
      ),
    ));
  }

  void onHeightMinus() {
    setState(() {
      if(height > 50){
        height--;
        bmiValue = calBMI(height: height, weight: weight);
      }
    });
  }

  double calBMI({required int height, required int weight}) {
    return (weight / (height * height)) * 10000;
  }

  String analyzeResult({required double bmiValue}) {
    if(bmiValue >= 25){
      return 'Overweight';
    }
    else if(bmiValue > 18.5){
      return 'Normal';
    }
    else{
      return 'Underweight';
    }
  }
}
