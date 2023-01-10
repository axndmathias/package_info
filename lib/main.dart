import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// The app name. CFBoundleDisplayName on iOS, application/label on Android
  late String _appName;

  /// The package name. bundleIndetifier on iOS, getPackageName on Android
  late String _packageName;

  /// The package version. CFBoundleDisplayName on iOS, versionName on Android
  late String _version;

  /// The build number. CFBoundleDisplayName on iOS, versionCode on Android
  late String _buildNumber;

  bool _isLoading = true;

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    /// Retrieves package information from the platfrom. The result is cached.
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    /// Assign package info to global variables
    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;

    /// Set is loading flag to false
    _isLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _buildPackageInfoListTile(
                    title: _appName, subtitle: 'App Name'),
                _buildPackageInfoListTile(
                    title: _packageName, subtitle: 'Package Name'),
                _buildPackageInfoListTile(title: _version, subtitle: 'Version'),
                _buildPackageInfoListTile(
                    title: _buildNumber, subtitle: 'Build Number'),
              ],
            ),
    );
  }

  Widget _buildPackageInfoListTile({
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: const Icon(Icons.check),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
