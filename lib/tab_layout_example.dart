import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TabLayoutExample extends StatefulWidget {
  const TabLayoutExample({super.key});

  @override
  State<TabLayoutExample> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayoutExample> {
  int _currentTabIndex = 0;

  final List<TabItem> _tabItems = [
    TabItem(
      icon: Icons.dashboard,
      label: '首页',
      content: const DashboardContent(),
    ),
    TabItem(icon: Icons.people, label: '人员', content: const UserListContent()),
    TabItem(icon: Icons.person, label: '我的', content: const UserListContent()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          // 根据方向和屏幕宽度选择布局方式
          final isLandscape = orientation == Orientation.landscape;
          final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

          if (isLandscape || isTablet) {
            return Row(
              children: [
                Container(
                  width: 120,
                  color: Theme.of(context).primaryColorLight,
                  child: ListView.builder(
                    itemCount: _tabItems.length,
                    itemBuilder: (context, index) {
                      final tab = _tabItems[index];
                      return ListTile(
                        leading: Icon(tab.icon),
                        title: Text(tab.label),
                        selected: index == _currentTabIndex,
                        selectedColor: Colors.red,
                        selectedTileColor: Theme.of(context).primaryColor,
                        onFocusChange: (focus) {},
                        onTap: () {
                          setState(() {
                            _currentTabIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: _tabItems[_currentTabIndex].content,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: _tabItems[_currentTabIndex].content,
                  ),
                ),
                Container(
                  height: 60,
                  color: Colors.blue[100],
                  child: Row(
                    children: _tabItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final tab = entry.value;
                      final isSelected = index == _currentTabIndex;
                      return Expanded(
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  tab.icon,
                                  color: isSelected ? Colors.blue : Colors.grey,
                                ),
                                Text(
                                  tab.label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _currentTabIndex = index;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class TabItem {
  final IconData icon;
  final String label;
  final Widget content;

  TabItem({required this.icon, required this.label, required this.content});
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

        final minItemWidth = isTablet ? 120.0 : 80.0;
        final borderRadius = 8.0;
        final mainAxisSpacing = 10.0;
        final crossAxisSpacing = 10.0;
        final crossAxisCount = (constraints.maxWidth / minItemWidth).floor();

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: 0.75,
          ),
          itemCount: 60,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius - 1),
                child: Center(child: Text('Item $index')),
              ),
            );
          },
        );
      },
    );
  }
}

class UserListContent extends StatefulWidget {
  const UserListContent({super.key});

  @override
  State<StatefulWidget> createState() => _UserListContentState();
}

class _UserListContentState extends State<UserListContent> {
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center();
      },
    );
  }

  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));

    final response = await http.post(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'type': ''}),
    );

    if (response.statusCode == 200) {
      // print(response.body);
      // return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('http failed');
    }
  }
}
