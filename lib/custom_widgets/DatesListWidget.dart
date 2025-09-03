import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/LeaveRequestDatesProvider.dart';

class DatesListWidget extends StatelessWidget {
  const DatesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final datesProvider = Provider.of<LeaveRequestDatesProvider>(context, listen: false);

    return Consumer<LeaveRequestDatesProvider>(
      builder: (context, provider, child) {
        if (provider.selectedDates.isEmpty) {
          return const Center(child: Text("No dates selected"));
        }
        return ListView.builder(
          itemCount: provider.selectedDates.length,
          itemBuilder: (context, index) {
            final date = provider.selectedDates[index];
            return ListTile(
              leading: const Icon(Icons.date_range, color: Colors.blue),
              title: Text("${date.day}/${date.month}/${date.year}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  datesProvider.removeDate(index); // use provider method, not direct remove
                },
              ),
            );
          },
        );
      },
    );
  }
}
