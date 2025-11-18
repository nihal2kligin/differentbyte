// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import '../models/login_model.dart';

class ProfilePage extends StatelessWidget {
  final LoginModel loginModel;

  const ProfilePage({Key? key, required this.loginModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginModel.login ?? "Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 54,
                    backgroundImage: loginModel.avatarUrl != null
                        ? NetworkImage(loginModel.avatarUrl!)
                        : null,
                    child: loginModel.avatarUrl == null
                        ? Icon(Icons.person, size: 50)
                        : null,
                  ),
                  SizedBox(height: 16),
                  Text(
                    loginModel.name?.toString() ?? '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '@${loginModel.login ?? ""}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  if (loginModel.bio != null)
                    Text(
                      loginModel.bio.toString(),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 16),
                  _infoRow(
                    Icons.people,
                    "Followers",
                    loginModel.followers?.toString() ?? "0",
                  ),
                  _infoRow(
                    Icons.person_add,
                    "Following",
                    loginModel.following?.toString() ?? "0",
                  ),
                  _infoRow(
                    Icons.book,
                    "Public Repos",
                    loginModel.publicRepos?.toString() ?? "0",
                  ),
                  SizedBox(height: 16),
                  if (loginModel.location != null)
                    _infoRow(
                      Icons.location_on,
                      "Location",
                      loginModel.location.toString(),
                    ),
                  if (loginModel.blog != null && loginModel.blog!.isNotEmpty)
                    _infoRow(Icons.link, "Blog", loginModel.blog!),
                  if (loginModel.company != null)
                    _infoRow(
                      Icons.business,
                      "Company",
                      loginModel.company.toString(),
                    ),
                  if (loginModel.email != null)
                    _infoRow(Icons.email, "Email", loginModel.email.toString()),
                  if (loginModel.twitterUsername != null)
                    _infoRow(
                      Icons.alternate_email,
                      "Twitter",
                      '@${loginModel.twitterUsername}',
                    ),
                  SizedBox(height: 24),
                  Text(
                    "GitHub profile created at\n${loginModel.createdAt ?? ""}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  if (loginModel.updatedAt != null)
                    Text(
                      "Last updated: ${loginModel.updatedAt!}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          SizedBox(width: 8),
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Flexible(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
