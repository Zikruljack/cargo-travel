import 'package:flutter/material.dart';

class FleetTengah extends StatelessWidget {
  final String mainStatus;
  final Duration mainTimer;
  final String standbyStatus;
  final Duration standbyTimer;
  final String mapEstimate;
  final Function()? onPlayBroadcast;
  final Function()? onSendBroadcast;

  const FleetTengah({
    super.key,
    required this.mainStatus,
    required this.mainTimer,
    required this.standbyStatus,
    required this.standbyTimer,
    required this.mapEstimate,
    this.onPlayBroadcast,
    this.onSendBroadcast,
  });

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes % 60)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status Cards
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              _statusCard(mainStatus, _formatDuration(mainTimer), isMain: true),
              const SizedBox(height: 8),
              _statusCard(
                standbyStatus,
                _formatDuration(standbyTimer),
                isMain: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Map Placeholder
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Placeholder map (ganti nanti dengan Google Maps atau lainnya)
                  Container(color: Colors.grey[200]),
                  const Center(
                    child: Icon(Icons.map, size: 120, color: Colors.grey),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Text(
                        "Estimate Traveling to ROM: $mapEstimate",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Broadcast/Chat
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Broadcast",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _voiceMessage(isIncoming: true, onPlay: onPlayBroadcast),
                  const SizedBox(height: 6),
                  _voiceMessage(isIncoming: false, onPlay: onPlayBroadcast),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.mic),
                        color: Colors.blue,
                        onPressed: onSendBroadcast,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusCard(String title, String time, {required bool isMain}) {
    return Card(
      color: isMain ? Colors.blue.shade100 : Colors.white,
      child: ListTile(
        leading: Icon(Icons.warning_amber, color: Colors.black87),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.timer_outlined, size: 18, color: Colors.black87),
            const SizedBox(width: 4),
            Text(time, style: const TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _voiceMessage({required bool isIncoming, Function()? onPlay}) {
    return Align(
      alignment: isIncoming ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isIncoming ? Colors.grey[200] : Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.play_arrow), onPressed: onPlay),
            const Text("0:05"),
          ],
        ),
      ),
    );
  }
}
