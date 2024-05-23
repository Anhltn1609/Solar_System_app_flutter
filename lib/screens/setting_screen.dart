import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late TextEditingController _timeDurationController;
  late TextEditingController _usernameController;

  late int _timeDuration;
  late String _username;

  @override
  void initState() {
    super.initState();
    _timeDurationController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _timeDurationController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // text & edit text duration
              const SizedBox(height: 60),
              TextField(
                controller: _timeDurationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time duration',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username ',
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _navigate();
                    setDataSP();
                  },
                  child: const Text(
                    'Set up',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
            // text & edit text name of user
            // button save
          ),
        ),
      ),
    );
  }

  void _navigate() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      _timeDuration = int.parse(_timeDurationController.text);
    } catch (e) {
      _timeDuration = prefs.getInt('timeDuration')!;
    }
    _username = _usernameController.text;
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false,
        arguments: {'timeDuration': _timeDuration, 'username': _username});
  }

  void setDataSP() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('timeDuration', _timeDuration);
    prefs.setString('username', _username);
  }
}
