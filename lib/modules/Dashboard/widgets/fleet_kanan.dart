import 'package:flutter/material.dart';

class FleetKanan extends StatelessWidget {
  final String localTime;
  final String loadStatus;
  final String headerTitle;
  final IconData headerIcon;
  final List<ActionItem> actions;
  final String? activeLabel;
  final ValueChanged<ActionItem>? onTap;

  const FleetKanan({
    super.key,
    required this.localTime,
    required this.loadStatus,
    this.headerTitle = 'Standby',
    this.headerIcon = Icons.pause_circle_filled,
    required this.actions,
    this.activeLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text(localTime)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.local_shipping, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Kondisi • $loadStatus')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(headerIcon),
                      const SizedBox(width: 8),
                      Text(
                        headerTitle,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Grid tombol aksi
                  LayoutBuilder(
                    builder: (context, c) {
                      return GridView.builder(
                        itemCount: actions.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 2.2,
                            ),
                        itemBuilder: (context, i) {
                          final item = actions[i];
                          final selected = item.label == activeLabel;
                          return _ActionButton(
                            item: item,
                            selected: selected,
                            onTap: () => onTap?.call(item),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 4),
        const Spacer(),
      ],
    );
  }
}

class ActionItem {
  final String label;
  final IconData icon;
  const ActionItem(this.label, this.icon);
}

class _ActionButton extends StatelessWidget {
  final ActionItem item;
  final bool selected;
  final VoidCallback onTap;

  const _ActionButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ElevatedButton.icon(
      icon: Icon(item.icon, size: 20),
      label: Text(
        item.label,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        elevation: selected ? 1 : 0,
        backgroundColor: selected ? scheme.primaryContainer : null,
        foregroundColor: selected ? scheme.onPrimaryContainer : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        minimumSize: const Size(double.infinity, 48),
      ),
      onPressed: onTap,
    );
  }
}
