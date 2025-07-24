import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe_Page extends StatelessWidget {
  const AboutMe_Page({super.key});
  @override
  Widget build(BuildContext context) {
    final String telegramProfile = "https://t.me/Abdu3377";
    final String telegramChannel = "https://t.me/ziyouzyaypan";
    final String phoneNumber = "+998913273377";
    Future<void> makePhoneCall(String number) async {
      final Uri launchUri = Uri(scheme: 'tel', path: number);
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw "Qo'ng'iroqni amalga oshirib bo'lmadi: $number";
      }
    }

    Future<void> launchTelegram(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw "Havolani ochib bo'lmadi: $url";
      }
    }

    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text("Biz haqimizda", style: TextStyle(color: textColor)),
        iconTheme: theme.iconTheme,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/image.png"),
                  ),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_pin,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "📍 Manzil:\nFarg'ona viloyati,\nO'zbekiston tumani,\nYaypan shaxri",
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Bog'lanish uchun qulay\nusulni tanlang!",
                      textAlign: TextAlign.center,
                    ),
                    const Icon(Icons.link, color: Colors.blue),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.call, color: Colors.blue),
                title: const Text("Telefon orqali"),
                subtitle: InkWell(
                  onTap: () => makePhoneCall(phoneNumber),
                  child: Text(
                    phoneNumber,
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.telegram, color: Colors.blue),
                title: const Text("Telegram profil"),
                subtitle: InkWell(
                  onTap: () => launchTelegram(telegramProfile),
                  child: Text(
                    telegramProfile,
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.telegram, color: Colors.blue),
                title: const Text("Telegram kanal"),
                subtitle: InkWell(
                  onTap: () => launchTelegram(telegramChannel),
                  child: Text(
                    telegramChannel,
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
