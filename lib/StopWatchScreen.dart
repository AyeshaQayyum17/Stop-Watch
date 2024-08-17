import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
class StopWatch extends StatefulWidget {
  const StopWatch({super.key});
  @override
  State<StopWatch> createState() => _StopWatchState();
}
class _StopWatchState extends State<StopWatch> {
  //create logic business
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHourse = "00";
  Timer? timer;
  bool started = false;

  List laps = [];

  // now create the funtion for stoptimmer
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // now create the funtion for reset
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHourse = "00";

      started = false;
    });
  }

  void addLaps() {
    String lap = "$digitSeconds: $digitMinutes: $digitHourse";
    setState(() {
      laps.add(lap);
    });
  }

  //crate the funtion for start timmer
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMintues = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMintues > 59) {
          localHours++;
          localMintues = 0;
        } else {
          localMintues++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMintues;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHourse = (hours >= 10) ? "$hours" : "0$hours";
      }
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Stop Watch',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "$digitHourse:$digitMinutes:$digitSeconds",
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                // now add list builder
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " Lap n^${index + 1}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "${laps[index]}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.black),
                      ),
                      child: const Text(
                        "start",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                      color: Colors.white,
                      onPressed: () {
                        addLaps();
                      },
                      icon: const Icon(Icons.flag)),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.black),
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
