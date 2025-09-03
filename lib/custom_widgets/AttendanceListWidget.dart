import 'package:flutter/material.dart';

class AttendanceListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final String emptyText;
  final Icon icon;

  const AttendanceListWidget({
    Key? key,
    required this.list,
    required this.emptyText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Center(child: Text(emptyText));
    }

    return ListView.builder(
     itemCount: list.length,
        itemBuilder: (context, index){
          final item = list[index];

        return ListTile(
          leading: icon,
          title: Text("Date: ${item["date"] ?? ""}"),
          subtitle: Text("Status: ${item["status"]}"),
        );
      },
    );
  }
}
