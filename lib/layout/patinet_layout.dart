import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/layout/cubit/patient_cubit.dart';
import 'package:patient_app/layout/utils/rive_utils.dart';
import 'package:rive/rive.dart';

import '../shared/styles/colors.dart';

class PatientLayout extends StatefulWidget {


  @override
  State<PatientLayout> createState() => _PatientLayoutState();
}

class _PatientLayoutState extends State<PatientLayout> {
double screenWidth = 0;
  //0xFF579dff

  RiveAsset selectedBottomNav = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
    var cubit = PatientCubit.get(context);
    screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            body: IndexedStack(
              index: cubit.currentIndex,
              children: cubit.bottomScreen,
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.all(Radius.circular(24))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(bottomNavs.length,
                            (index) =>GestureDetector(
                          onTap: (){
                            bottomNavs[index].input!.change(true);
                            if(bottomNavs[index] != selectedBottomNav){
                              setState(() {
                                selectedBottomNav = bottomNavs[index];
                              });
                            }
                            cubit.changeBottom(index);
                            Future.delayed( const Duration(seconds: 1),(){
                              bottomNavs[index].input!.change(false);

                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 36,
                                width: 36,
                                child: Opacity(
                                  opacity: bottomNavs[index] == selectedBottomNav? 1: 0.5,
                                  child: RiveAnimation.asset(
                                    bottomNavs.first.src,
                                    artboard: bottomNavs[index].artBoard,
                                    animations: [],
                                    onInit: (artboard){
                                      StateMachineController controller = RiveUtils.getRiveController(
                                          artboard,
                                          stateMachineName: bottomNavs[index].stateMachineName,
                                      );
                                      bottomNavs[index].input = controller.findSMI("active") as SMIBool;
                                    },
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: screenWidth /14,
                                width: bottomNavs[index] == selectedBottomNav? 75 : 0,

                                child: Text(
                                  bottomNavs[index].title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    fontFamily: nexaBold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
class RiveAsset{
  final String artBoard, stateMachineName,title,src;
  late SMIBool? input;

  RiveAsset(this.src,{
    required this.artBoard,
    required this.stateMachineName,
    required this.title,
    this.input

  });

  set setInput(SMIBool status){
    input = status;
  }
}

List<RiveAsset>bottomNavs = [
  RiveAsset("assets/images/icons.riv", artBoard: "TIMER", stateMachineName: "TIMER_Interactivity", title: "الدوام"),
  RiveAsset("assets/images/icons.riv", artBoard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "طلب إجازة"),
  RiveAsset("assets/images/icons.riv", artBoard: "SEARCH", stateMachineName: "SEARCH_Interactivity", title: "البحث"),
  RiveAsset("assets/images/icons.riv", artBoard: "BELL", stateMachineName: "BELL_Interactivity", title: "الإشعارات"),
  RiveAsset("assets/images/icons.riv", artBoard: "USER", stateMachineName: "USER_Interactivity", title: "حسابي"),

];