import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AdminProviders/DeleteStudentsAttendanceProvider.dart';

class DeleteAttendanceScreen extends StatelessWidget {
  final String studentClass;

  const DeleteAttendanceScreen({super.key, required this.studentClass});

  @override
  Widget build(BuildContext context) {
    final provider =
    Provider.of<DeleteStudentsAttendanceProvider>(context, listen: false);

    // load attendance for today initially
    provider.getAttendanceRecords(studentClass, provider.selectedDate);

    return Scaffold(
      appBar: AppBar(
          title: const Text("Delete Attendance"),
        actions: [
          PopupMenuButton<String>(
              onSelected: (val)async{
                if(val=="deleteAll"){
                var confirm = await showDialog<bool>(context: context, builder: (ctx)=>AlertDialog(
    title: Text("Are you shure you want to delete all attendances for this day ?"),
    actions: [
      TextButton(onPressed: ()=>
        Navigator.pop(ctx,false),
       child: Text("Cancel",style: TextStyle(color: Colors.grey))),
      ElevatedButton(onPressed: ()=>
                Navigator.pop(ctx,true),style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[900]),
         child: Text("Delete", style: TextStyle(color: Colors.white),),),
    ],
    ),


              );
                if(confirm==true){
                  provider.deleteAll(provider.selectedDate);
                }
              }

              }
              , itemBuilder: (context)=> [
                const PopupMenuItem(child: Text("Delete all", ),value: "deleteAll",),
          ],
          )
        ],


      ),
      body: Column(
        children: [
          Consumer<DeleteStudentsAttendanceProvider>(
            builder: (context, provider, _) => GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: provider.selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  await provider.getAttendanceRecords(studentClass, picked);
                }
              },
              child: Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.red),
                  title: const Text("Select Date"),
                  subtitle: Text(
                    "${provider.selectedDate.day}-${provider.selectedDate.month}-${provider.selectedDate.year}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

          const Divider(),

          // 🔹 Attendance Records List
          Expanded(
            child: Consumer<DeleteStudentsAttendanceProvider>(
              builder: (context, provider, _) {
                if (provider.records.isEmpty) {
                  return const Center(
                    child: Text(
                      "No attendance found for this date",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: provider.records.length,
                  itemBuilder: (context, index) {
                    final rec = provider.records[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(12),
                      child: ListTile(
                        title: Text(rec["name"]),
                        subtitle: Text(
                            "Date: ${rec["date"]}  •  Status: ${rec["status"]}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Delete Attendance"),
                                content: Text(
                                    "Are you sure you want to delete ${rec["name"]}'s attendance for ${rec["date"]}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(ctx, false),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(ctx, true),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await provider.deleteAttendance(
                                  rec["id"], rec["date"]);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Deleted attendance for ${rec["name"]}")),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
