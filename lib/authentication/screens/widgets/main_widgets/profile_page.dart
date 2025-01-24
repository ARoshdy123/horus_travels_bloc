import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late String name;
  late String email;
  late String phone;
  late String password;
  bool isEditing = false;
  bool isLoading = true;
  bool obscurePassword = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('firstName') ?? "Name";
      email = prefs.getString('email') ?? "email";
      phone = prefs.getString('phone') ?? "12";
      passwordController.text = prefs.getString('password') ?? "******";

      nameController.text = name;
      emailController.text = email;
      phoneController.text = phone;
      isLoading = false; // Data loaded
    });
  }

  Future<void> _saveProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('password', passwordController.text);

    setState(() {
      name = nameController.text;
      email = emailController.text;
      phone = phoneController.text;
      password = passwordController.text;
      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated!")),
    );
  }

  Future<void> _logout() async {
    await _saveProfileData();

    Navigator.pushReplacementNamed(context, '/login'); // Navigate to login page
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (isEditing) {
                _saveProfileData();
              } else {
                setState(() {
                  isEditing = true;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Name
            Text(
              'Name:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            isEditing
                ? TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Enter your name",
              ),
            )
                : Text(name, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),

            // Email
            Text(
              'Email:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            isEditing
                ? TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Enter your email",
              ),
            )
                : Text(email, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),

            // Phone
            Text(
              'Phone:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            isEditing
                ? TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: "Enter your phone number",
              ),
            )
                : Text(phone, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),

            // Password
            Text(
              'Password:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            isEditing
                ? TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                hintText: "Enter your password",
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            )
                : Row(
              children: [
                Expanded(
                  child: Text(
                    obscurePassword ? "******" : passwordController.text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Logout Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: _logout,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
