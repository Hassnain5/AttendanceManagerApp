


import 'package:first_app/Admin_module/AdminProviders/LeaveManagmentProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RequestedLeavesList extends StatelessWidget{
  final String status;

  const RequestedLeavesList({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
   return
    Consumer<LeaveManagmentProvider>(
      builder: ( context,  provider, _) {

        final list= status=="Pending" ? provider.pendingList :
        status=="Approved"? provider.approvedList:
        provider.rejectedList;
    print(list);
        // final item = List.generate(7, (index)=>{"id": "fake", "name": "Student Name","avatar1":""});

        if (provider.isLoading) {
          final items = List.generate(7, (index) => {
            "id": "fake",
            "name": "Student Name",
            "date": "2025-09-12"
          });


          return Skeletonizer(
            enabled: provider.isLoading,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final fake = items[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(fake["name"]![0])),
                    title: Text(fake["name"]!),   
                    subtitle: Text("Date: ${fake["date"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircleAvatar(child: Text("A")),
                        SizedBox(width: 8),
                        CircleAvatar(child: Text("B")),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }


        else if(!provider.isLoading && list.isNotEmpty){
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final leave = list[index];

              return Padding(
                padding: const EdgeInsets.only(right: 10.0,left: 10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.white,
                  child: ListTile(
                    leading:  (leave["profilePic"] != null && leave["profilePic"] != "noProfilePic")
                        ? CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(leave["profilePic"]),
                  ):
                CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        (leave["name"] != null && leave["name"].toString().isNotEmpty)?
                        leave["name"][0]: "?",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      leave["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Date: ${leave["date"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (status == "Pending") ...[
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () {
                          provider.updateStatus(leave["id"],index, leave["date"], "Approved");
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () {
                              provider.updateStatus(leave["id"],index, leave["date"], "Rejected");

                            },
                          ),
                        ] else
                          Text(
                            status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: status == "Approved"
                                  ? Colors.green
                                  : status == "Rejected"
                                  ? Colors.red
                                  : Colors.orange,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        else  {
          return Center(child: Text("No requests found"),);
        }
      },

    );
  }

}