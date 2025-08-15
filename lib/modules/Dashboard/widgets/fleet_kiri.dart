import 'package:flutter/material.dart';

class FleetKiri extends StatelessWidget {
  final String userName;
  final String userId;
  final String unitCode;
  final String orderId;
  final String fromLocation;
  final String toLocation;
  final String dateTime;
  final Function(String) onOperationTap;
  final Function(String) onBreakdownTap;
  final String activeOperation;
  final String activeBreakdown;

  const FleetKiri({
    super.key,
    required this.userName,
    required this.userId,
    required this.unitCode,
    required this.orderId,
    required this.fromLocation,
    required this.toLocation,
    required this.dateTime,
    required this.onOperationTap,
    required this.onBreakdownTap,
    required this.activeOperation,
    required this.activeBreakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section
                  Row(
                    children: [
                      const CircleAvatar(radius: 20, child: Icon(Icons.person)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "ID $userId",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Order ID
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_shipping,
                        size: 18,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          orderId,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.archive, size: 18, color: Colors.grey[700]),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          unitCode,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Timeline route
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline line
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 30,
                            color: Colors.grey[400],
                          ),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 16),

                      // Route info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "From: $fromLocation",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              "To: $toLocation",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    // Time
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(height: 4),
                      Text(
                        dateTime,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_shipping, size: 18, color: Colors.blue),
                      const Text(
                        "Operation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2.5,
                    children: [
                      _operationButton(
                        "Traveling",
                        activeOperation == "Traveling",
                        () => onOperationTap("Traveling"),
                      ),
                      _operationButton(
                        "Delivery",
                        activeOperation == "Delivery",
                        () => onOperationTap("Delivery"),
                      ),
                      _operationButton(
                        "Dumping",
                        activeOperation == "Dumping",
                        () => onOperationTap("Dumping"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, size: 18, color: Colors.red),
                      const Text(
                        "Breakdown",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Column(
                    children: [
                      _breakdownButton(
                        "Scheduled",
                        activeBreakdown == "Scheduled",
                        () => onBreakdownTap("Scheduled"),
                      ),
                      const SizedBox(height: 8),
                      _breakdownButton(
                        "Unscheduled",
                        activeBreakdown == "Unscheduled",
                        () => onBreakdownTap("Unscheduled"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _operationButton(String label, bool selected, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.blue : Colors.grey[200],
        foregroundColor: selected ? Colors.white : Colors.black87,
        elevation: selected ? 2 : 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _breakdownButton(String label, bool selected, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.blue : Colors.grey[200],
          foregroundColor: selected ? Colors.white : Colors.black87,
          elevation: selected ? 2 : 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
