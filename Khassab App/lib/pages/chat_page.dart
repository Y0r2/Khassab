import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// صفحة الدردشة والدعم - تحتوي على نظام دردشة داخلي ومركز المساعدة
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();

  // قائمة مؤقتة للرسائل
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'مرحباً! كيف يمكنني مساعدتك اليوم؟',
      isFromUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatMessage(
      text: 'أهلاً، أريد معرفة كيفية استخدام العربة الذكية',
      isFromUser: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    ChatMessage(
      text:
          'بالطبع! إليك الخطوات:\n\n1. اقترب من العربة الذكية\n2. افتح التطبيق وانقر على "مسح QR"\n3. وجه الكاميرا نحو الرمز على العربة\n4. ارمِ النفايات العضوية\n5. احصل على نقاطك البيئية! 🌱',
      isFromUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    ChatMessage(
      text: 'رائع! شكراً لك',
      isFromUser: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: _messageController.text.trim(),
        isFromUser: true,
        timestamp: DateTime.now(),
      ));
    });

    final userMessage = _messageController.text.trim();
    _messageController.clear();

    // محاكاة رد تلقائي من الدعم
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: _getAutoReply(userMessage),
            isFromUser: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom();
      }
    });

    _scrollToBottom();
  }

  String _getAutoReply(String userMessage) {
    final message = userMessage.toLowerCase();

    if (message.contains('قر') || message.contains('qr')) {
      return 'لمسح رمز QR:\n1. انتقل للصفحة الرئيسية\n2. انقر على "مسح رمز QR"\n3. وجه الكاميرا نحو الرمز\n\nهل تحتاج مساعدة أخرى؟';
    } else if (message.contains('نقاط') || message.contains('نقطة')) {
      return 'تحصل على نقاط بيئية عند:\n• التخلص من النفايات العضوية (50 نقطة)\n• استخدام العربة الذكية (25 نقطة)\n• المشاركة في الأنشطة البيئية\n\nيمكنك رؤية نقاطك في الملف الشخصي 📊';
    } else if (message.contains('شجرة') || message.contains('نبات')) {
      return 'شجرتك الافتراضية تنمو كلما:\n🌱 جمعت نقاط أكثر\n🌿 ساهمت في حماية البيئة\n🌳 استخدمت التطبيق بانتظام\n\nكل مستوى جديد يعني تأثير بيئي أكبر!';
    } else if (message.contains('مشكلة') || message.contains('خطأ')) {
      return 'آسف لسماع ذلك! يرجى وصف المشكلة بالتفصيل وسنقوم بحلها في أقرب وقت.\n\nيمكنك أيضاً التواصل معنا عبر:\n📧 support@khassab.com\n📱 +966 11 234 5678';
    } else {
      return 'شكراً لتواصلك معنا! فريق الدعم متاح 24/7 لمساعدتك.\n\nهل يمكنك توضيح استفسارك أكثر؟ 😊';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_chatScrollController.hasClients) {
        _chatScrollController.animateTo(
          _chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الدعم والمساعدة',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2E7D32),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4CAF50),
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: const Color(0xFF4CAF50),
          labelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.cairo(),
          tabs: const [
            Tab(text: 'الدردشة المباشرة'),
            Tab(text: 'مركز المساعدة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatTab(),
          _buildHelpCenterTab(),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        // منطقة الرسائل
        Expanded(
          child: Container(
            color: const Color(0xFFF5F5F5),
            child: ListView.builder(
              controller: _chatScrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
        ),

        // منطقة كتابة الرسالة
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'اكتب رسالتك...',
                    hintStyle: GoogleFonts.cairo(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF0F0F0),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  style: GoogleFonts.cairo(),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      alignment:
          message.isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: message.isFromUser ? const Color(0xFF4CAF50) : Colors.white,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: message.isFromUser ? const Radius.circular(4) : null,
            bottomLeft: !message.isFromUser ? const Radius.circular(4) : null,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: GoogleFonts.cairo(
                color:
                    message.isFromUser ? Colors.white : const Color(0xFF2E2E2E),
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTime(message.timestamp),
              style: GoogleFonts.cairo(
                color: message.isFromUser
                    ? Colors.white.withOpacity(0.7)
                    : Colors.grey[500],
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCenterTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الأسئلة الشائعة
          Text(
            'الأسئلة الشائعة',
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),

          ..._buildFAQItems(),

          const SizedBox(height: 32),

          // معلومات التواصل
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.contact_support,
                      color: Color(0xFF4CAF50),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'تواصل معنا',
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildContactItem(
                  Icons.email,
                  'البريد الإلكتروني',
                  'support@khassab.com',
                ),
                _buildContactItem(
                  Icons.phone,
                  'رقم الهاتف',
                  '+966 11 234 5678',
                ),
                _buildContactItem(
                  Icons.schedule,
                  'ساعات العمل',
                  '24/7 - متاح طوال الأسبوع',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // تقييم التطبيق
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  'هل أعجبك التطبيق؟',
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'نسعد بتقييمك لمساعدتنا في التطوير',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: فتح متجر التطبيقات للتقييم
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('شكراً لك! سيتم فتح متجر التطبيقات قريباً')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF4CAF50),
                  ),
                  child: Text(
                    'تقييم التطبيق',
                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFAQItems() {
    final faqs = [
      {
        'question': 'كيف أستخدم العربة الذكية؟',
        'answer':
            'اقترب من العربة، افتح التطبيق، اختر "مسح QR"، وجه الكاميرا نحو الرمز، ارمِ النفايات العضوية، واحصل على نقاطك البيئية!'
      },
      {
        'question': 'ما هي النقاط البيئية وكيف أحصل عليها؟',
        'answer':
            'النقاط البيئية هي مكافآت تحصل عليها عند المساهمة في حماية البيئة. تحصل على 50 نقطة لكل مرة تستخدم فيها العربة الذكية.'
      },
      {
        'question': 'كيف تنمو شجرتي الافتراضية؟',
        'answer':
            'شجرتك تنمو كلما جمعت نقاط أكثر. كل 500 نقطة تزيد من مستوى شجرتك، مما يعكس تأثيرك الإيجابي على البيئة.'
      },
      {
        'question': 'أين يمكنني العثور على العربات الذكية؟',
        'answer':
            'استخدم خريطة التطبيق لرؤية جميع العربات الذكية القريبة منك مع معلومات المسافة وحالة التوفر.'
      },
      {
        'question': 'ما نوع النفايات المقبولة؟',
        'answer':
            'نقبل النفايات العضوية فقط: بقايا الطعام، قشور الفواكه والخضروات، أوراق الشجر الجافة.'
      },
    ];

    return faqs
        .map((faq) => _buildFAQItem(
              faq['question']!,
              faq['answer']!,
            ))
        .toList();
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2E7D32),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: GoogleFonts.cairo(
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF4CAF50),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return 'قبل ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'قبل ${difference.inHours} ساعة';
    } else {
      return 'قبل ${difference.inDays} يوم';
    }
  }
}

/// نموذج رسالة الدردشة
class ChatMessage {
  final String text;
  final bool isFromUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isFromUser,
    required this.timestamp,
  });
}
