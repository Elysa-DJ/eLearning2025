import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Compte'),
          _SettingsTile(
            icon: Icons.person,
            title: 'Informations du profil',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.lock,
            title: 'Mot de passe',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {},
          ),
          const _SectionHeader(title: 'Préférences'),
          _SettingsTile(
            icon: Icons.language,
            title: 'Langue',
            subtitle: 'Français',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.dark_mode,
            title: 'Thème',
            subtitle: 'Clair',
            onTap: () {},
          ),
          const _SectionHeader(title: 'Aide'),
          _SettingsTile(
            icon: Icons.help,
            title: 'Centre d\'aide',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.privacy_tip,
            title: 'Politique de confidentialité',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.description,
            title: 'Conditions d\'utilisation',
            onTap: () {},
          ),
          const _SectionHeader(title: 'Application'),
          _SettingsTile(
            icon: Icons.info,
            title: 'À propos',
            subtitle: 'Version 1.0.0',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
