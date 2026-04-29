import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_task_manager_app/core/theme/app_colors.dart';
import 'package:student_task_manager_app/core/theme/app_text_styles.dart';
import 'package:student_task_manager_app/core/utils/app_snackbar.dart';
import 'package:student_task_manager_app/widgets/custom_alert_dialog.dart';
import 'package:student_task_manager_app/widgets/custom_appbar.dart';
import 'package:student_task_manager_app/widgets/edit_alert_dialog.dart';

class ViewTaskScreen extends StatefulWidget {
  const ViewTaskScreen({super.key});

  @override
  State<ViewTaskScreen> createState() => _ViewTaskScreenState();
}


class _ViewTaskScreenState extends State<ViewTaskScreen> {
  Future<void> deleteTask(String id)async{
    await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }
  Future<void> editTask(String newTitle, String newDescription, String id)async{
    await FirebaseFirestore.instance.collection('tasks').doc(id).update({
      'taskTitle' : newTitle,
      'taskDescription' : newDescription
    });
  }
  Future<void> showEditDialog(String currentTitle, String currentDescription, String currentId)async{
    showDialog(
        context: context,
        builder: (_) => EditAlertDialog(
            currentTitle: currentTitle,
            currentDescription: currentDescription,
            onEdit: (newTitle, newDesc) {
            editTask(newTitle, newDesc, currentId);
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "View Tasks"
      ),
      body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tasks').orderBy('createdAt',descending: true).snapshots(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(color: AppColors.primary));
                }
                if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                  return Center(child: Text("No tasks yet",style: AppTextStyles.emptyData));
                }
                final tasks = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      final size = MediaQuery.of(context).size;
                      var task = tasks[index];
                      DateTime date = (task['createdAt'] as Timestamp).toDate();
                      String formattedDate = DateFormat('d MMM yyyy').format(date);
                      String formattedTime = DateFormat('jm').format(date);
                      return ListTile(
                        title: Text(task['taskTitle'],style: AppTextStyles.taskTitle),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: (){
                                  showEditDialog(task['taskTitle'], task['taskDescription'], task.id);
                                },
                                icon: Icon(Icons.edit,color: AppColors.primary,size: 25,)
                            ),
                            IconButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (_) => CustomAlertDialog(
                                          title: "Delete Task?",
                                          content: "Are you sure you want to delete this task?",
                                          confirmText: "Delete",
                                          onConfirm: (){
                                            var deletedTask = task.data() as Map<String, dynamic>;
                                            deleteTask(task.id);
                                            AppSnackBar.deleted(context, () async {
                                              await FirebaseFirestore.instance.collection('tasks').add(deletedTask);
                                            });
                                            Navigator.pop(context);
                                          }
                                      )
                                  );
                                },
                                icon: Icon(Icons.delete,color: AppColors.danger,size: 25,),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: size.height * 0.015,
                          horizontal: size.width * 0.05,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Text(task['taskDescription'],style: AppTextStyles.taskDescription),
                            const SizedBox(height: 5),
                            Text("$formattedDate • $formattedTime",style: AppTextStyles.taskDateTime),
                          ],
                        ),
                      );
                    }
                );
              }
      )
    );
  }
}
