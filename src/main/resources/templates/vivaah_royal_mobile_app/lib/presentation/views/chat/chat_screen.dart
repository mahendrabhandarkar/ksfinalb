import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/chat.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/profiles_controller.dart';
import '../../widgets/initials_avatar.dart';

/// 1:1 chat thread with bubbles, a typing indicator and the simulated
/// partner reply driven by the demo transport.
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({required this.conversationId, super.key});

  final String conversationId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _inputController.text;
    _inputController.clear();
    await ref.read(chatControllerProvider.notifier).send(
          conversationId: widget.conversationId,
          text: text,
        );
    if (!_scrollController.hasClients) return;
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile =
        ref.watch(profileByIdProvider(widget.conversationId));
    final messages = ref.watch(messagesForProvider(widget.conversationId));
    final typing = ref.watch(
      typingProvider.select((set) => set.contains(widget.conversationId)),
    );
    final theme = Theme.of(context);
    final name = profile?.fullName ?? 'Vivaah Member';

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            InitialsAvatar(name: name, size: 38),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    typing ? 'typing…' : 'Matched on Vivaah Royal',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: typing
                          ? AppColors.crimson
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: Text('Say namaste to begin the conversation'),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length + (typing ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (typing && index == messages.length) {
                        return _TypingBubble();
                      }
                      final message = messages[index];
                      return _MessageBubble(message: message);
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: 'Write a respectful message…',
                        suffixIcon: IconButton(
                          tooltip: 'Attach photo',
                          onPressed: () => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text('Photo sharing ships in the full build'),
                          )),
                          icon: const Icon(Icons.photo_outlined),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    tooltip: 'Send',
                    onPressed: _send,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.crimson,
                      minimumSize: const Size(48, 48),
                    ),
                    icon: const Icon(Icons.send_rounded, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fromMe = message.fromMe;
    final time = DateFormat('h:mm a').format(message.sentAt);

    return Align(
      alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.72,
        ),
        decoration: BoxDecoration(
          color: fromMe ? AppColors.crimson : theme.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(fromMe ? 18 : 4),
            bottomRight: Radius.circular(fromMe ? 4 : 18),
          ),
          border: fromMe
              ? null
              : Border.all(color: theme.colorScheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: fromMe ? Colors.white : AppColors.ink,
                fontSize: 14.5,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: fromMe
                    ? Colors.white.withValues(alpha: 0.75)
                    : theme.colorScheme.onSurfaceVariant,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(18),
          ),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Dot(phase: 0),
            SizedBox(width: 4),
            _Dot(phase: 0.33),
            SizedBox(width: 4),
            _Dot(phase: 0.66),
          ],
        ),
      ),
    );
  }
}

/// One pulsing dot; [phase] staggers the three dots inside the same wave.
class _Dot extends StatefulWidget {
  const _Dot({required this.phase});

  final double phase;

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final wave = (_controller.value + widget.phase) % 1;
        final opacity = 0.25 + 0.75 * (1 - (2 * wave - 1).abs());
        return Opacity(
          opacity: opacity.clamp(0.25, 1.0),
          child: Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.crimson,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
