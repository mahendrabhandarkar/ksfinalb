import '../../core/constants/app_constants.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/membership_plan.dart';
import '../../domain/entities/profile.dart';

/// Offline demo dataset: 24 hand-curated profiles, seeded conversations and
/// membership plans.
///
/// Serves as the stand-in for a REST/GraphQL backend so the entire app runs
/// without network access — ideal for design reviews and widget tests.
class MockDataSource {
  const MockDataSource();

  // ── Profiles ─────────────────────────────────────────────────────────────
  static const List<_Row> _rows = <_Row>[
    // id, name, gender, age, height, religion, community, tongue, marital,
    // city, country, education, profession, incomeL, diet, hobbies, premium, verified, avatarImg
    _Row('r01', 'Ananya Deshmukh', Gender.female, 26, 163, 'Hindu', 'Marathi',
        'Marathi', MaritalStatus.neverMarried, 'Pune', 'India',
        'M.Tech Computer Science', 'Software Engineer', 18, Diet.vegetarian,
        ['Classical dance', 'Trekking', 'Reading'], true, true, 44),
    _Row('r02', 'Ishita Kapoor', Gender.female, 25, 160, 'Hindu', 'Punjabi',
        'Hindi', MaritalStatus.neverMarried, 'New Delhi', 'India',
        'MBA Marketing', 'Brand Manager', 15, Diet.eggetarian,
        ['Baking', 'Yoga', 'Travel'], false, true, 45),
    _Row('r03', 'Meera Iyer', Gender.female, 28, 158, 'Hindu', 'Tamil Brahmin',
        'Tamil', MaritalStatus.neverMarried, 'Chennai', 'India', 'CA',
        'Chartered Accountant', 22, Diet.vegetarian,
        ['Carnatic music', 'Painting', 'Chess'], true, true, 47),
    _Row('r04', 'Sana Sheikh', Gender.female, 27, 165, 'Muslim', 'Sunni',
        'Urdu', MaritalStatus.neverMarried, 'Hyderabad', 'India', 'MBBS',
        'Paediatrician', 20, Diet.nonVegetarian,
        ['Calligraphy', 'Volunteering', 'Poetry'], true, true, 49),
    _Row('r05', 'Ritika Sharma', Gender.female, 24, 157, 'Hindu', 'Brahmin',
        'Hindi', MaritalStatus.neverMarried, 'Jaipur', 'India', 'B.Arch',
        'Architect', 12, Diet.vegetarian,
        ['Photography', 'Sketching', 'Badminton'], false, true, 9),
    _Row('r06', 'Kavya Nair', Gender.female, 29, 161, 'Hindu', 'Nair',
        'Malayalam', MaritalStatus.divorced, 'Kochi', 'India', 'M.Sc Biotech',
        'Research Scientist', 14, Diet.nonVegetarian,
        ['Gardening', 'Cooking', 'Birdwatching'], false, true, 10),
    _Row('r07', 'Simran Kaur', Gender.female, 26, 168, 'Sikh', 'Jat',
        'Punjabi', MaritalStatus.neverMarried, 'Chandigarh', 'India',
        'B.Tech IT', 'Data Analyst', 13, Diet.nonVegetarian,
        ['Bhangra', 'Basketball', 'Vlogging'], false, true, 16),
    _Row('r08', 'Aditi Banerjee', Gender.female, 30, 156, 'Hindu', 'Bengali',
        'Bengali', MaritalStatus.neverMarried, 'Kolkata', 'India',
        'Ph.D English Literature', 'University Professor', 16,
        Diet.eggetarian, ['Rabindra Sangeet', 'Literature', 'Theatre'], true,
        true, 20),
    _Row('r09', 'Pooja Patel', Gender.female, 25, 162, 'Hindu', 'Patel',
        'Gujarati', MaritalStatus.neverMarried, 'Ahmedabad', 'India', 'BDS',
        'Dentist', 11, Diet.vegetarian,
        ['Garba', 'Baking', 'Home decor'], false, true, 23),
    _Row('r10', 'Nikita Jain', Gender.female, 27, 159, 'Jain', 'Jain Agarwal',
        'Hindi', MaritalStatus.neverMarried, 'Mumbai', 'India', 'LLB',
        'Corporate Lawyer', 19, Diet.jain,
        ['Meditation', 'Hindustani vocals', 'Chess'], true, true, 25),
    _Row('r11', 'Aarohi Joshi', Gender.female, 28, 164, 'Hindu', 'Deshastha',
        'Marathi', MaritalStatus.neverMarried, 'Nashik', 'India',
        'M.Sc Statistics', 'Data Scientist', 21, Diet.vegetarian,
        ['Stargazing', 'Trekking', 'Cooking'], false, true, 26),
    _Row('r12', 'Fatima Khan', Gender.female, 31, 166, 'Muslim', 'Shia',
        'Urdu', MaritalStatus.widowed, 'Lucknow', 'India', 'M.Ed',
        'School Principal', 12, Diet.vegetarian,
        ['Mentoring', 'Gardening', 'Ghazals'], false, true, 29),
    _Row('r13', 'Arjun Malhotra', Gender.male, 29, 178, 'Hindu', 'Khatri',
        'Hindi', MaritalStatus.neverMarried, 'Gurugram', 'India',
        'MBA Finance', 'Investment Banker', 36, Diet.nonVegetarian,
        ['Cricket', 'Golf', 'Travel'], true, true, 3),
    _Row('r14', 'Rohan Mehta', Gender.male, 28, 175, 'Hindu', 'Gujarati',
        'Gujarati', MaritalStatus.neverMarried, 'Mumbai', 'India',
        'B.Tech Computer Science', 'Product Manager', 32, Diet.vegetarian,
        ['Table tennis', 'Startups', 'Chess'], true, true, 4),
    _Row('r15', 'Vikram Reddy', Gender.male, 30, 180, 'Hindu', 'Reddy',
        'Telugu', MaritalStatus.neverMarried, 'Bengaluru', 'India',
        'M.S Data Science', 'Data Scientist', 34, Diet.nonVegetarian,
        ['Badminton', 'Cooking', 'Trekking'], false, true, 6),
    _Row('r16', 'Karthik Subramanian', Gender.male, 27, 172, 'Hindu', 'Iyer',
        'Tamil', MaritalStatus.neverMarried, 'Chennai', 'India',
        'B.Tech ECE', 'Embedded Systems Engineer', 14, Diet.vegetarian,
        ['Violin', 'Cycling', 'Puzzles'], false, true, 7),
    _Row('r17', 'Aditya Verma', Gender.male, 26, 176, 'Hindu', 'Brahmin',
        'Hindi', MaritalStatus.neverMarried, 'Lucknow', 'India', 'M.Tech',
        'Design Engineer', 11, Diet.vegetarian,
        ['Astronomy', 'Table tennis', 'Sketching'], false, false, 8),
    _Row('r18', 'Zaid Ansari', Gender.male, 29, 174, 'Muslim', 'Sunni',
        'Urdu', MaritalStatus.neverMarried, 'Hyderabad', 'India', 'MD Medicine',
        'Physician', 24, Diet.nonVegetarian,
        ['Football', 'Community service', 'Cricket'], true, true, 11),
    _Row('r19', 'Harpreet Singh', Gender.male, 31, 183, 'Sikh', 'Jat',
        'Punjabi', MaritalStatus.neverMarried, 'Amritsar', 'India',
        'B.Com', 'Agri-business Owner', 28, Diet.nonVegetarian,
        ['Horse riding', 'Kirtan', 'Farming'], false, true, 12),
    _Row('r20', 'Siddharth Ghosh', Gender.male, 32, 170, 'Hindu', 'Bengali',
        'Bengali', MaritalStatus.divorced, 'Kolkata', 'India', 'Ph.D Physics',
        'Research Scientist', 18, Diet.eggetarian,
        ['Sitar', 'Chess', 'Mountaineering'], false, true, 13),
    _Row('r21', 'Rahul Chauhan', Gender.male, 27, 177, 'Hindu', 'Rajput',
        'Hindi', MaritalStatus.neverMarried, 'Udaipur', 'India', 'BBA',
        'Heritage Hotelier', 20, Diet.eggetarian,
        ['Swimming', 'Horse riding', 'Heritage tours'], true, true, 14),
    _Row('r22', 'Devang Trivedi', Gender.male, 33, 171, 'Hindu', 'Nagar',
        'Gujarati', MaritalStatus.neverMarried, 'Vadodara', 'India', 'CA',
        'Finance Controller', 26, Diet.vegetarian,
        ['Reading', 'Cricket', 'Philately'], false, true, 15),
    _Row('r23', 'Nikhil Kamat', Gender.male, 28, 169, 'Hindu', 'Saraswat',
        'Konkani', MaritalStatus.neverMarried, 'Goa', 'India',
        'B.E Computers', 'Game Developer', 16, Diet.nonVegetarian,
        ['Guitar', 'Football', 'Gaming'], false, true, 17),
    _Row('r24', 'Tanmay Bose', Gender.male, 30, 173, 'Hindu', 'Bengali',
        'Bengali', MaritalStatus.neverMarried, 'Pune', 'India', 'B.Des',
        'UX Designer', 15, Diet.eggetarian,
        ['Tabla', 'Cycling', 'Street photography'], true, true, 18),
  ];

  List<Profile> get profiles {
    final now = DateTime.now();
    return List<Profile>.generate(_rows.length, (i) {
      final r = _rows[i];
      return Profile(
        id: r.id,
        fullName: r.fullName,
        gender: r.gender,
        age: r.age,
        heightCm: r.heightCm,
        religion: r.religion,
        community: r.community,
        motherTongue: r.motherTongue,
        maritalStatus: r.maritalStatus,
        city: r.city,
        country: r.country,
        education: r.education,
        profession: r.profession,
        annualIncomeLakh: r.incomeLakh,
        diet: r.diet,
        about: _aboutFor(r),
        hobbies: List<String>.unmodifiable(r.hobbies),
        isPremium: r.isPremium,
        isVerified: r.isVerified,
        lastActiveAt: now.subtract(Duration(hours: 2 + i * 3)),
        photoUrl: '${AppConstants.mockAvatarBaseUrl}${r.img}',
      );
    });
  }

  String _aboutFor(_Row r) {
    final pronoun = switch (r.gender) {
      Gender.female => 'She',
      Gender.male => 'He',
    };
    final bio =
        '$pronoun values family traditions while embracing a modern outlook. '
        'Holds a degree in ${r.education} and works as a '
        '${r.profession.toLowerCase()} in ${r.city}. '
        '${r.fullName.split(' ').first} enjoys ${r.hobbies.join(', ').toLowerCase()}. '
        'Looking for a life partner who shares warmth, respect and a love for '
        'meaningful conversations.';
    return bio;
  }

  // ── Seeded conversations ─────────────────────────────────────────────────
  static const List<String> _cannedReplies = <String>[
    'Namaste! So glad we matched on Vivaah Royal.',
    'Tell me a little about your family and what you enjoy on weekends?',
    'That sounds lovely. Would you be open to a video call this weekend?',
    'My parents are equally excited to connect with your family. 🙏',
  ];

  ChatData seedChatData() {
    final now = DateTime.now();
    final conversations = <Conversation>[
      Conversation(
        id: 'r01',
        profileId: 'r01',
        lastActivity: now.subtract(const Duration(minutes: 18)),
        unreadCount: 1,
      ),
      Conversation(
        id: 'r03',
        profileId: 'r03',
        lastActivity: now.subtract(const Duration(hours: 5)),
        unreadCount: 0,
      ),
      Conversation(
        id: 'r13',
        profileId: 'r13',
        lastActivity: now.subtract(const Duration(hours: 26)),
        unreadCount: 2,
      ),
    ];
    String mid(String convId, int seq) => 'm_${convId}_$seq';
    final messages = <String, List<ChatMessage>>{
      'r01': <ChatMessage>[
        ChatMessage(
          id: mid('r01', 0),
          conversationId: 'r01',
          text: 'Hi! I saw your profile and thought we have a lot in common — '
              'I love trekking too!',
          sentAt: now.subtract(const Duration(minutes: 26)),
          fromMe: false,
        ),
        ChatMessage(
          id: mid('r01', 1),
          conversationId: 'r01',
          text: 'Namaste Ananya! Which trail did you trek last?',
          sentAt: now.subtract(const Duration(minutes: 22)),
          fromMe: true,
        ),
        ChatMessage(
          id: mid('r01', 2),
          conversationId: 'r01',
          text: 'Rajmachi last month — the monsoon view was magical.',
          sentAt: now.subtract(const Duration(minutes: 18)),
          fromMe: false,
        ),
      ],
      'r03': <ChatMessage>[
        ChatMessage(
          id: mid('r03', 0),
          conversationId: 'r03',
          text: 'Your profile caught my attention. How has your week been?',
          sentAt: now.subtract(const Duration(hours: 6)),
          fromMe: false,
        ),
        ChatMessage(
          id: mid('r03', 1),
          conversationId: 'r03',
          text: 'Busy with audit season, but good otherwise!',
          sentAt: now.subtract(const Duration(hours: 5, minutes: 50)),
          fromMe: true,
        ),
      ],
      'r13': <ChatMessage>[
        ChatMessage(
          id: mid('r13', 0),
          conversationId: 'r13',
          text: 'Hey! Golf this Sunday? There is a great course in Gurugram.',
          sentAt: now.subtract(const Duration(hours: 27)),
          fromMe: false,
        ),
        ChatMessage(
          id: mid('r13', 1),
          conversationId: 'r13',
          text: 'I am more of a cricket person, but I am up for trying!',
          sentAt: now.subtract(const Duration(hours: 26, minutes: 10)),
          fromMe: true,
        ),
        ChatMessage(
          id: mid('r13', 2),
          conversationId: 'r13',
          text: 'Perfect — let us plan something for next week instead.',
          sentAt: now.subtract(const Duration(hours: 26)),
          fromMe: false,
        ),
      ],
    };
    return ChatData(
      conversations: conversations,
      messagesByConversation: messages,
    );
  }

  /// Next canned reply for [profileId], cycling deterministically.
  String cannedReply(String profileId, int sendCount) {
    final index = (profileId.hashCode.abs() + sendCount) %
        _cannedReplies.length;
    return _cannedReplies[index];
  }

  // ── Membership plans ─────────────────────────────────────────────────────
  List<MembershipPlan> get plans => const <MembershipPlan>[
        MembershipPlan(
          id: 'gold',
          name: 'Gold',
          tagline: 'Begin your royal search',
          pricePerMonthInr: 999,
          features: <String>[
            'Send 10 interests every month',
            'Unlimited chat with accepted members',
            'Advanced search filters',
            'Profile visibility boost',
          ],
          isPopular: false,
        ),
        MembershipPlan(
          id: 'diamond',
          name: 'Diamond',
          tagline: 'Most chosen by members',
          pricePerMonthInr: 1999,
          features: <String>[
            'Unlimited interests',
            'Contact numbers visible',
            'Profile highlighted in search',
            'Dedicated relationship advisor',
            'Horoscope compatibility report',
          ],
          isPopular: true,
        ),
        MembershipPlan(
          id: 'platinum',
          name: 'Platinum',
          tagline: 'Concierge matchmaking',
          pricePerMonthInr: 3499,
          features: <String>[
            'Everything in Diamond',
            'Hand-picked premium matches',
            'Background-verified shortlist',
            'Priority matchmaking desk',
            'Family onboarding assistance',
          ],
          isPopular: false,
        ),
      ];
}

/// Compact record describing one mock profile.
class _Row {
  const _Row(
    this.id,
    this.fullName,
    this.gender,
    this.age,
    this.heightCm,
    this.religion,
    this.community,
    this.motherTongue,
    this.maritalStatus,
    this.city,
    this.country,
    this.education,
    this.profession,
    this.incomeLakh,
    this.diet,
    this.hobbies,
    this.isPremium,
    this.isVerified,
    this.img,
  );

  final String id;
  final String fullName;
  final Gender gender;
  final int age;
  final int heightCm;
  final String religion;
  final String community;
  final String motherTongue;
  final MaritalStatus maritalStatus;
  final String city;
  final String country;
  final String education;
  final String profession;
  final int incomeLakh;
  final Diet diet;
  final List<String> hobbies;
  final bool isPremium;
  final bool isVerified;
  final int img;
}
