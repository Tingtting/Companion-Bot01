import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/bot.dart';

class BotListScreen extends StatefulWidget {
  const BotListScreen({super.key});

  @override
  State<BotListScreen> createState() => _BotListScreenState();
}

class _BotListScreenState extends State<BotListScreen> {
  late Box<Bot> botBox;

  @override
  void initState() {
    super.initState();
    botBox = Hive.box<Bot>('bots');
  }

  void _navigateToCreateBot() async {
    final newBot = await Navigator.pushNamed(context, '/botProfile') as Bot?;
    if (newBot != null) {
      await botBox.add(newBot);
      setState(() {}); // Rebuild UI after adding
    }
  }

  void _openChat(Bot bot) {
    Navigator.pushNamed(context, '/chat', arguments: bot);
  }

  @override
  Widget build(BuildContext context) {
    final bots = botBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bots'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToCreateBot,
          ),
        ],
      ),
      body:
          bots.isEmpty
              ? const Center(child: Text('No bots yet. Tap + to create one.'))
              : ListView.builder(
                itemCount: bots.length,
                itemBuilder: (context, index) {
                  final bot = bots[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(bot.name),
                    subtitle: Text(bot.tagline),
                    onTap: () => _openChat(bot),
                  );
                },
              ),
    );
  }
}
