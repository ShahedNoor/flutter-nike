import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/theme/theme.dart';
import 'package:nike/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width >= 600
                    ? 600
                    : MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context).themeData ==
                              lightMode
                          ? false
                          : true,
                      onChanged: (p01) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
