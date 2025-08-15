import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/core.dart';
import '../../Auth/providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            title: const Text('Dashboard'),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    _showLogoutDialog(context, authProvider);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ResponsiveHelper.adaptiveLayout(
            context: context,
            centerContent: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: ResponsiveHelper.getCardPadding(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: ResponsiveHelper.getAvatarRadius(context),
                              backgroundColor: Colors.blue[100],
                              child: Text(
                                user?.fullName.substring(0, 1).toUpperCase() ??
                                    'U',
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.isTablet(context) ? 28 : 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                            ),
                            SizedBox(width: ResponsiveHelper.getSpacing(context, multiplier: 0.75)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back!',
                                    style: TextStyle(
                                      fontSize: ResponsiveHelper.getBodyFontSize(context),
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    user?.fullName ?? 'User',
                                    style: TextStyle(
                                      fontSize: ResponsiveHelper.getSubtitleFontSize(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    user?.email ?? '',
                                    style: TextStyle(
                                      fontSize: ResponsiveHelper.getBodyFontSize(context) - 2,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveHelper.getSpacing(context, multiplier: 1.5)),

                // Quick Actions
                Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getTitleFontSize(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: ResponsiveHelper.getSpacing(context)),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: ResponsiveHelper.getGridCrossAxisCount(context),
                  crossAxisSpacing: ResponsiveHelper.getSpacing(context),
                  mainAxisSpacing: ResponsiveHelper.getSpacing(context),
                  childAspectRatio: ResponsiveHelper.isTablet(context) ? 1.1 : 1.0,
                  children: [
                    _buildActionCard(
                      context: context,
                      icon: Icons.add_box,
                      title: 'New Shipment',
                      subtitle: 'Create a new cargo shipment',
                      color: Colors.green,
                      onTap: () => _showComingSoonDialog(context),
                    ),
                    _buildActionCard(
                      context: context,
                      icon: Icons.track_changes,
                      title: 'Track Cargo',
                      subtitle: 'Track your shipments',
                      color: Colors.orange,
                      onTap: () => _showComingSoonDialog(context),
                    ),
                    _buildActionCard(
                      context: context,
                      icon: Icons.history,
                      title: 'History',
                      subtitle: 'View shipment history',
                      color: Colors.purple,
                      onTap: () => _showComingSoonDialog(context),
                    ),
                    _buildActionCard(
                      context: context,
                      icon: Icons.settings,
                      title: 'Settings',
                      subtitle: 'App settings',
                      color: Colors.grey,
                      onTap: () => _showComingSoonDialog(context),
                    ),
                  ],
                ),

                SizedBox(height: ResponsiveHelper.getSpacing(context, multiplier: 1.5)),

                // Recent Activity
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getTitleFontSize(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: ResponsiveHelper.getSpacing(context)),

                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: ResponsiveHelper.getCardPadding(context),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: ResponsiveHelper.getIconSize(context) * 2,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: ResponsiveHelper.getSpacing(context)),
                            Text(
                              'No recent activity',
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getSubtitleFontSize(context),
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: ResponsiveHelper.getSpacing(context, multiplier: 0.5)),
                            Text(
                              'Your recent shipments will appear here',
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getBodyFontSize(context),
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: ResponsiveHelper.getCardPadding(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon, 
                size: ResponsiveHelper.getIconSize(context), 
                color: color,
              ),
              SizedBox(height: ResponsiveHelper.getSpacing(context, multiplier: 0.5)),
              Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getSubtitleFontSize(context),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveHelper.getSpacing(context, multiplier: 0.25)),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getBodyFontSize(context) - 2,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (ctx) => SizedBox(
        width: ResponsiveHelper.getDialogWidth(context),
        child: AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: ResponsiveHelper.getTitleFontSize(context),
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: ResponsiveHelper.getBodyFontSize(context),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getBodyFontSize(context),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                authProvider.logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: ResponsiveHelper.getBodyFontSize(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SizedBox(
        width: ResponsiveHelper.getDialogWidth(context),
        child: AlertDialog(
          title: Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: ResponsiveHelper.getTitleFontSize(context),
            ),
          ),
          content: Text(
            'This feature is coming soon!',
            style: TextStyle(
              fontSize: ResponsiveHelper.getBodyFontSize(context),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getBodyFontSize(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
