import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Auth/providers/auth_provider.dart';

class TabletSidebar extends StatefulWidget {
  const TabletSidebar({super.key});

  @override
  State<TabletSidebar> createState() => _TabletSidebarState();
}

class _TabletSidebarState extends State<TabletSidebar> {
  String selectedMenu = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(2, 0)),
        ],
      ),
      child: Column(
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_shipping,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          const Divider(height: 1),

          // Menu Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.settings,
                    isSelected: selectedMenu == 'settings',
                    onTap: () => _selectMenu('settings'),
                  ),
                  _buildMenuItem(
                    icon: Icons.assignment,
                    isSelected: selectedMenu == 'assignment',
                    onTap: () => _selectMenu('assignment'),
                  ),

                  const Spacer(),

                  // Logout Section
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () => _showLogoutDialog(),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.logout,
                          color: Colors.grey.shade600,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: Colors.blue.shade200) : null,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.blue.shade600 : Colors.grey.shade600,
            size: 24,
          ),
        ),
      ),
    );
  }

  void _selectMenu(String menu) {
    setState(() {
      selectedMenu = menu;
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();

              // Show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );

              // Get AuthProvider and call logout
              final authProvider = Provider.of<AuthProvider>(
                context,
                listen: false,
              );
              await authProvider.logout();

              // Hide loading indicator
              if (mounted) {
                Navigator.of(context).pop();
              }

              // Show logout message if there's an error
              if (mounted && authProvider.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authProvider.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
