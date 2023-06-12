import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:team_up/constants/borders.dart';
import 'package:team_up/screens/home_screen.dart';
import 'package:team_up/screens/page_navigation_screen.dart';
import 'package:team_up/screens/student_progress_screen.dart';
import 'package:team_up/services/file_uploader.dart';
import 'package:team_up/utils/configuration_util.dart';
import 'package:team_up/utils/util.dart';
import 'dart:io';

import '../constants/colors.dart';
import '../widgets/reusable_widgets/reusable_widget.dart';
import '../widgets/widgets.dart';
import 'package:team_up/services/database_access.dart';

class AddTasksScreen extends StatefulWidget {
  const AddTasksScreen({Key? key}) : super(key: key);

  @override
  State<AddTasksScreen> createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {
  final TextEditingController _subTeamTextController = TextEditingController();
  final TextEditingController _taskTextController = TextEditingController();
  final TextEditingController _dueDateTextController = TextEditingController();
  final TextEditingController _skillsRequiredController =
      TextEditingController();
  final TextEditingController _estimatedTimeController =
      TextEditingController();

  final TextEditingController _submissionController = TextEditingController();

  bool _isExpanded = false;

  File? file;
  String _subteam = "";
  bool fileInitialized = false;

  void menuToggleExpansion() {
    setState(() {
      ConfigUtils.goToScreen(PageNavigationScreen(), context);
      PageNavigationScreen.setIncomingScreen(AddTasksScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConfigUtils.configForBackButtonBehaviour(mainLayout, context);
  }

  Scaffold mainLayout() {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(menuToggleExpansion),
      body: buildMainContent(),
    );
  }

  Widget buildMainContent() {
    List<TextEditingController> controllerList = [
      _subTeamTextController,
      _taskTextController,
      _dueDateTextController,
      _skillsRequiredController,
      _estimatedTimeController
    ];

    return SingleChildScrollView(
        child: Column(
      children: [
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 15),
        //   decoration: BoxDecoration(
        //       color: Colors.white, borderRadius: BorderRadius.circular(20)),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       contentPadding: EdgeInsets.all(0),
        //       prefixIcon: Icon(
        //         Icons.search,
        //         color: tdBlack,
        //         size: 20,
        //       ),
        //       prefixIconConstraints:
        //           BoxConstraints(maxHeight: 20, minWidth: 25),
        //       border: InputBorder.none,
        //       hintText: "Search",
        //       hintStyle: TextStyle(color: tdGrey),
        //     ),
        //   ),
        // ),
        const Text("Add a task!",
            style: TextStyle(fontSize: 30, decorationThickness: 1.5)),
        const SizedBox(height: 10.0),
        Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 199, 196, 196).withOpacity(0.3),
                borderRadius: Borders.imageBorderRadius),
            child: Column(children: [
              const Text(
                "Select subteam:",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              ListTile(
                title: const Text('Build'),
                leading: Radio<String>(
                  value: "Build",
                  groupValue: _subteam,
                  onChanged: (String? value) {
                    setState(() {
                      _subteam = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Programming'),
                leading: Radio<String>(
                  value: "Programming",
                  groupValue: _subteam,
                  onChanged: (String? value) {
                    setState(() {
                      _subteam = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Design'),
                leading: Radio<String>(
                  value: "Design",
                  groupValue: _subteam,
                  onChanged: (String? value) {
                    setState(() {
                      _subteam = value!;
                    });
                  },
                ),
              )
            ])),
        const SizedBox(height: 10.0),
        reusableTextFieldRegular(
            "Enter Specific Task", _taskTextController, false),
        reusableTextFieldRegular(
            "Enter due date for task", _dueDateTextController, false),
        reusableTextFieldRegular(
            "Enter skills required for task", _skillsRequiredController, false),
        reusableTextFieldRegular(
            "Enter estimated time needed", _estimatedTimeController, false),
        reusableButton("Upload a file related to task", context, () async {
          File result = (await FileUploader.pickFile())!;
          setState(() {
            file = result;
            fileInitialized = true;
          });
        }),
        if (fileInitialized && file != null) Image.file(file!),
        reusableButton("ADD TO DATABASE", context, () async {
          String imageURL = "None";
          if (file != null) {
            TaskSnapshot imageSnapshot = await FileUploader.getInstance()
                .addImageToFirebaseStorage(file!);
            imageURL = await imageSnapshot.ref.getDownloadURL();
            FlutterLogs.logInfo(
                "Add to Database", "Upload image", "Image URL: $imageURL");
          }
          Map<String, dynamic> taskToAdd = {
            "task": _taskTextController.text,
            "estimated time": _estimatedTimeController.text,
            "due date": _dueDateTextController.text,
            "skills needed": _skillsRequiredController.text,
            "image url": imageURL
          };
          List<Map<String, dynamic>> curTasks =
              await Util.combineTaskIntoExisting(
                  taskToAdd,
                  await DatabaseAccess.getInstance().getAvailableTasks(
                      int.parse(_estimatedTimeController.text.substring(0, 2)),
                      _subTeamTextController.text));

          DatabaseAccess.getInstance().addToDatabase(
              "Tasks", _subTeamTextController.text, {"tasks": curTasks});
          for (TextEditingController controller in controllerList) {
            controller.clear();
          }
          setState(() {
            fileInitialized = false;
          });
          _submissionController.text = "Submitted!";
        }),
        reusableTextFieldRegular("", _submissionController, true),
      ],
    ));
  }

  void goToProgress() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => StudentProgressScreen()));
  }
}
