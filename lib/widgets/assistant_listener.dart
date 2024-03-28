import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sgela_services/data/assistant_data_openai/message.dart';
import 'package:sgela_services/services/openai_assistant_service.dart';
import 'package:sgela_services/sgela_util/functions.dart';
import 'package:sgela_shared_widgets/util/gaps.dart';
import 'package:sgela_shared_widgets/util/styles.dart';

import 'busy_indicator.dart';

class AssistantListener extends StatefulWidget {
  const AssistantListener({super.key});

  @override
  AssistantListenerState createState() => AssistantListenerState();
}

class AssistantListenerState extends State<AssistantListener> {
  static const mm = '🦠🦠🦠🦠🦠 AssistantListener  🔵🔵';

  late StreamSubscription<String> statusSubscription;
  late StreamSubscription<List<Message>> messageSubscription;
  OpenAIAssistantService assistantService =
      GetIt.instance<OpenAIAssistantService>();

  @override
  void initState() {
    super.initState();
    _listen();
  }

  @override
  void dispose() {
    statusSubscription.cancel();
    messageSubscription.cancel();
    super.dispose();
  }

  String? statusMessage;
  bool _busy = true;

  void _listen() {
    pp('$mm ... listening to Assistant result and status streams ....');

    statusSubscription = assistantService.statusStream.listen((status) {
      pp('$mm ... Assistant status arrived: $status');

      switch (status) {
        case 'queued':
          statusMessage = "Request is queued";
          color = Colors.white;
          break;
        case 'failed':
          statusMessage = "Request has failed";
          _busy = false;
          color = Colors.red;
          break;
        case 'expired':
          statusMessage = "Request has expired";
          _busy = false;
          color = Colors.grey;
          break;
        case 'cancelling':
          statusMessage = "Request is being cancelled";
          color = Colors.amber;
          break;
        case 'cancelled':
          statusMessage = "Request is cancelled";
          _busy = false;
          color = Colors.red;
          break;
        case 'in_progress':
          statusMessage = "SgelaAI is still working ...";
          color = Colors.blue;
          break;
        case 'completed':
          statusMessage = "Request is completed";
          color = Colors.green;
          _busy = false;
          pp('\n\n\n$mm ... 🍎🍎🍎🍎🍎🍎 Thread run completed!! 🍎🍎🍎🍎🍎🍎\n\n\n');
          break;
      }

      if (mounted) {
        setState(() {});
      }
    });

    messageSubscription =
        assistantService.questionResponseStream.listen((mMessages) {
      pp('$mm ...questionResponseStream: Assistant messages arrived: ${mMessages.length}');
      if (mounted) {
        setState(() {
          hide = true;
        });
      }
    });
  }

  Color? color;
  bool hide = false;

  @override
  Widget build(BuildContext context) {
    return hide
        ? gapH16
        : Card(
            elevation: 8,
            color: Colors.amber.shade900,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SizedBox(
                height: 60,
                width: 320,
                child: Row(
                  children: [
                    Text(
                      statusMessage == null
                          ? 'SgelaAI is working ...'
                          : statusMessage!,
                      style: myTextStyle(
                          context, Colors.black, 14, FontWeight.normal),
                    ),
                    gapW8,
                    _busy
                        ? const BusyIndicator(showTimerOnly: true, width: 60)
                        : gapH8,
                    gapW8,
                    Container(
                        height: 20,
                        width: 20,
                        color: color == null ? Colors.white : color!),
                  ],
                ),
              ),
            ),
          );
  }
}
