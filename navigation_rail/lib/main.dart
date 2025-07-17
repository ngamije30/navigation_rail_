import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationRailDemoApp());
}

/// A simple Admin Dashboard demo using Flutter's NavigationRail widget.
/// Demonstrates three key properties: selectedIndex, labelType, and backgroundColor.
class NavigationRailDemoApp extends StatelessWidget {
  const NavigationRailDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavigationRail Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AdminDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // Property 1: selectedIndex controls which destination is active
  int _selectedIndex = 0;

  // Property 2: labelType controls how labels are shown (none, selected, all)
  NavigationRailLabelType _labelType = NavigationRailLabelType.selected;

  // Property 3: backgroundColor customizes the NavigationRail background
  Color _backgroundColor = Colors.blue.shade50;

  // Content for each destination
  static const List<String> _sectionTitles = [
    'Home',
    'Users',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Row(
        children: [
          NavigationRail(
            // Property 1: selectedIndex
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            // Property 2: labelType
            labelType: _labelType,
            // Property 3: backgroundColor
            backgroundColor: _backgroundColor,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            // Add a top logo or avatar for realism
            leading: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade200,
                child: const Icon(Icons.admin_panel_settings, color: Colors.white),
              ),
            ),
            // Add a bottom area to toggle properties live
            trailing: _buildPropertyToggles(),
          ),
          // Main content area updates based on selectedIndex
          Expanded(
            child: Center(
              child: Text(
                'Welcome to the ${_sectionTitles[_selectedIndex]} section!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget to toggle NavigationRail properties live for demo purposes
  Widget _buildPropertyToggles() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Toggle labelType
          const Text('Label Type:'),
          DropdownButton<NavigationRailLabelType>(
            value: _labelType,
            items: const [
              DropdownMenuItem(
                value: NavigationRailLabelType.none,
                child: Text('None'),
              ),
              DropdownMenuItem(
                value: NavigationRailLabelType.selected,
                child: Text('Selected'),
              ),
              DropdownMenuItem(
                value: NavigationRailLabelType.all,
                child: Text('All'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _labelType = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          // Toggle backgroundColor
          const Text('Background Color:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _colorDot(Colors.blue.shade50),
              _colorDot(Colors.white),
              _colorDot(Colors.blue.shade100),
              _colorDot(Colors.grey.shade200),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper to build a color selection dot
  Widget _colorDot(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _backgroundColor = color;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _backgroundColor == color ? Colors.blue : Colors.grey,
            width: 2,
          ),
        ),
      ),
    );
  }
}
