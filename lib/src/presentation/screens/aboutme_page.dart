import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  final String telegramProfile = "https://t.me/Abdu3377";
  final String telegramChannel = "https://t.me/ziyouzyaypan";
  final String phoneNumber = "+998913273377";

  Future<void> _launchUrl(String url, {bool isPhone = false}) async {
    final Uri uri = isPhone ? Uri(scheme: 'tel', path: url) : Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Ulanishda xatolik: $url";
    }
  }

  Widget _contactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: InkWell(
        onTap: onTap,
        child: Text(subtitle, style: TextStyle(color: Colors.blue.shade800)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Biz haqimizda", style: TextStyle(color: textColor)),
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.iconTheme,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/image.png"),
              ),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.location_pin, size: 30, color: Colors.red),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "📍 Manzil:\nFarg'ona viloyati,\nO'zbekiston tumani,\nYaypan shahri",
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: const [
                Text(
                  "Bog'lanish uchun qulay\nusulni tanlang!",
                  textAlign: TextAlign.center,
                ),
                Icon(Icons.link, color: Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _contactTile(
            icon: Icons.call,
            title: "Telefon orqali",
            subtitle: phoneNumber,
            onTap: () => _launchUrl(phoneNumber, isPhone: true),
          ),
          _contactTile(
            icon: Icons.telegram,
            title: "Telegram profil",
            subtitle: telegramProfile,
            onTap: () => _launchUrl(telegramProfile),
          ),
          _contactTile(
            icon: Icons.telegram,
            title: "Telegram kanal",
            subtitle: telegramChannel,
            onTap: () => _launchUrl(telegramChannel),
          ),
        ],
      ),
    );
  }
}
