import 'package:cargo_travel/modules/Dashboard/widgets/fleet_kanan.dart';
import 'package:cargo_travel/modules/Dashboard/widgets/fleet_kiri.dart';
import 'package:cargo_travel/modules/Dashboard/widgets/fleet_tengah.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Auth/providers/auth_provider.dart';
import '../widgets/tablet_sidebar.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sidebar Section
              const TabletSidebar(),

              // Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: FleetKiri(
                                userName: "Putera Negara",
                                userId: "01786345",
                                orderId: "HT515 - ST552",
                                unitCode: "KA05AS5555",
                                fromLocation: "ROM Wara 3",
                                toLocation: "Hopper 1",
                                dateTime: "14 Jun 2025, 8:31 AM",
                                activeOperation: "Traveling",
                                activeBreakdown: "Scheduled",
                                onOperationTap: (op) =>
                                    print("Selected operation: $op"),
                                onBreakdownTap: (bd) =>
                                    print("Selected breakdown: $bd"),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: FleetTengah(
                                mainStatus: "Your Status: Traveling",
                                mainTimer: const Duration(
                                  minutes: 27,
                                  seconds: 12,
                                ),
                                standbyStatus: "Standby: Antri Kelanis",
                                standbyTimer: const Duration(
                                  minutes: 15,
                                  seconds: 8,
                                ),
                                mapEstimate: "35 minutes",
                                onPlayBroadcast: () => print("Play voice"),
                                onSendBroadcast: () => print("Send voice"),
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: FleetKanan(
                                localTime: "13:00 WITA",
                                loadStatus: "Bermuatan",
                                activeLabel: "Antri Kelanis",
                                actions: const [
                                  ActionItem(
                                    "Standby",
                                    Icons.pause_circle_filled,
                                  ),
                                  ActionItem("Istirahat", Icons.free_breakfast),
                                  ActionItem("Change Shift", Icons.swap_horiz),
                                  ActionItem("Antri ROM", Icons.list_alt),
                                  ActionItem(
                                    "Antri Kelanis",
                                    Icons.pending_actions,
                                  ),
                                  ActionItem(
                                    "Antri Halte",
                                    Icons.directions_bus,
                                  ),
                                  ActionItem(
                                    "Perbaikan Jalan",
                                    Icons.construction,
                                  ),
                                  ActionItem("Antri PI", Icons.verified),
                                  ActionItem(
                                    "Periodic Inspection",
                                    Icons.schedule,
                                  ),
                                  ActionItem(
                                    "Refueling",
                                    Icons.local_gas_station,
                                  ),
                                  ActionItem("Other", Icons.more_horiz),
                                ],
                                onTap: (it) => print('tap: ${it.label}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
