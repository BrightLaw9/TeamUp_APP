import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:team_up/screens/page_navigation_screen.dart';
import 'package:team_up/services/database_access.dart';
import 'package:team_up/utils/configuration_util.dart';
import 'package:team_up/widgets/reusable_widgets/reusable_widget.dart';
import 'package:team_up/widgets/widgets.dart';
import '../constants/colors.dart';
import '../constants/student_data.dart';
import '../utils/util.dart';
import 'Approve_page.dart';

class AllApproveTasksScreen extends StatefulWidget {
  const AllApproveTasksScreen({Key? key}) : super(key: key);

  @override
  State<AllApproveTasksScreen> createState() => _AllApproveTasksScreenState();
}

class _AllApproveTasksScreenState extends State<AllApproveTasksScreen> {
  bool _isExpanded = false;

  List<Map<String, dynamic>>? studentTasksMap;
  //List<String> task = [];

  List<String> studentTasks = [];
  List<String> imageURL = [];

  Future<void> configure() async {
    //studentTasksMap
    studentTasksMap =
        await DatabaseAccess.getInstance().getMyAssignedStudentSubmissions();
    FlutterLogs.logInfo(
        "My Tasks", "Add to ListView", "studentTasksMap: ${studentTasksMap}");
    for (Map<String, dynamic> taskMap in studentTasksMap!) {
      if (!Util.contains(taskMap['task'], studentTasks)) {
        studentTasks.add(taskMap['task']);
        imageURL.add(taskMap['file url']);
        FlutterLogs.logInfo("My Tasks", "Add to ListView",
            "Displaying task: ${taskMap['task']}");
      }
    }
    // for (String imageUrl in imageUrlList) {
    //   resizedImageList.add(await Util.resizeImage(imageUrl, 1 / 8));
    // }
    setState(() {});
  }

  void menuToggleExpansion() {
    setState(() {
      ConfigUtils.goToScreen(PageNavigationScreen(), context);
      PageNavigationScreen.setIncomingScreen(AllApproveTasksScreen());
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
    return Column(
      children: [
        regularText("Approving Tasks", context, true),
        Expanded(
            child: ListView.builder(
                itemCount: studentTasks.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 177, 167, 167)
                              .withOpacity(0.3),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Row(children: [
                        Column(children: [
                          regularText(studentTasks[index], context, true),
                          reusableSignUpTaskButton("APPROVE this task", context,
                              () {
                            StudentData.approvalTask = studentTasksMap![index];
                            if (StudentData.isAdmin) {
                              ConfigUtils.goToScreen(
                                  const Approve_page(), context);
                            }
                          })
                        ]),
                        if (imageURL[index] != "None")
                          Expanded(child: Image.network(imageURL[index]))
                      ]));
                })),
        reusableButton("Update tasks to approve", context, () async {
          configure();
        }),
      ],
    );
  }
}
