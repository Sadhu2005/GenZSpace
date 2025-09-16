import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/user_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  String _selectedSort = 'Recent';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _filters = [
    'All',
    'Same College',
    'Same Branch',
    'Same Year',
    'Similar Interests',
    'Nearby',
  ];

  final List<String> _sortOptions = [
    'Recent',
    'Popular',
    'Alphabetical',
    'Year',
  ];


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFF72585).withOpacity(0.1),
                      const Color(0xFF7209B7).withOpacity(0.1),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            // Logo
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFF72585), Color(0xFF7209B7)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.radar,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // App Name
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFFF72585), Color(0xFF7209B7)],
                              ).createShader(bounds),
                              child: const Text(
                                'Student Radar',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            // Action buttons
                            Row(
                              children: [
                                _buildActionButton(Icons.filter_list, () => _showFilterDialog()),
                                const SizedBox(width: 8),
                                _buildActionButton(Icons.sort, () => _showSortDialog()),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Discover.Connect.Learn',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Search Bar
          SliverToBoxAdapter(
            child: _buildSearchBar(),
          ),
          
          // Quick Stats
          SliverToBoxAdapter(
            child: _buildQuickStats(),
          ),
          
          // Filter Chips
          SliverToBoxAdapter(
            child: _buildFilterChips(),
          ),
          
          // Students List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final users = _getFilteredUsers();
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildUserCard(users[index]),
                    ),
                  ),
                );
              },
              childCount: _getFilteredUsers().length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search students by name, college, branch, interests...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500]),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value);
        },
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF72585).withOpacity(0.2),
            const Color(0xFF7209B7).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF72585).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total Students', '2.5K', Icons.people_outline),
          _buildStatItem('Colleges', '150+', Icons.school_outlined),
          _buildStatItem('Connections', '12K', Icons.handshake_outlined),
          _buildStatItem('Active Today', '890', Icons.trending_up),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String count, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFFF72585),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFF72585).withOpacity(0.2)
                      : Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFF72585)
                        : Colors.grey[700]!,
                    width: 1,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFFF72585)
                        : Colors.grey[400],
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFF72585), Color(0xFF7209B7)],
              ),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[800],
              child: Text(
                user.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user.isVerified) ...[
                      const SizedBox(width: 8),
                      Icon(
                        Icons.verified,
                        color: const Color(0xFFF72585),
                        size: 16,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${user.course} - ${user.branch}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${user.college} • Year ${user.year}',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: user.interests.take(3).map((interest) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7209B7).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      interest,
                      style: const TextStyle(
                        color: Color(0xFF7209B7),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Column(
            children: [
              GestureDetector(
                onTap: () => _connectUser(user),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF72585).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFF72585),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'Connect',
                    style: TextStyle(
                      color: Color(0xFFF72585),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _viewProfile(user),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[500],
                  size: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<UserModel> _getFilteredUsers() {
    // Mock data for demonstration
    final List<UserModel> users = [
      UserModel(
        uid: 'user1',
        name: 'Rahul Sharma',
        phone: '1234567890',
        collegeId: 'IITB2020',
        college: 'IIT Bombay',
        course: 'B.Tech',
        branch: 'Computer Science',
        year: 3,
        interests: ['Machine Learning', 'Web Development', 'Gaming'],
        skills: ['Python', 'JavaScript', 'React'],
        joinedAt: DateTime.now().subtract(const Duration(days: 30)),
        isVerified: true,
      ),
      UserModel(
        uid: 'user2',
        name: 'Priya Patel',
        phone: '0987654321',
        collegeId: 'NITK2021',
        college: 'NIT Surathkal',
        course: 'B.Tech',
        branch: 'Electronics',
        year: 2,
        interests: ['IoT', 'Embedded Systems', 'Photography'],
        skills: ['C++', 'Arduino', 'Python'],
        joinedAt: DateTime.now().subtract(const Duration(days: 25)),
        isVerified: true,
      ),
      UserModel(
        uid: 'user3',
        name: 'Amit Kumar',
        phone: '1122334455',
        collegeId: 'IITD2019',
        college: 'IIT Delhi',
        course: 'B.Tech',
        branch: 'Mechanical',
        year: 4,
        interests: ['Robotics', 'CAD', 'Sports'],
        skills: ['SolidWorks', 'MATLAB', 'C++'],
        joinedAt: DateTime.now().subtract(const Duration(days: 20)),
        isVerified: false,
      ),
      UserModel(
        uid: 'user4',
        name: 'Neha Reddy',
        phone: '5566778899',
        collegeId: 'BITS2020',
        college: 'BITS Pilani',
        course: 'B.Tech',
        branch: 'Computer Science',
        year: 3,
        interests: ['Data Science', 'AI', 'Research'],
        skills: ['Python', 'R', 'TensorFlow'],
        joinedAt: DateTime.now().subtract(const Duration(days: 15)),
        isVerified: true,
      ),
      UserModel(
        uid: 'user5',
        name: 'Vikram Singh',
        phone: '9988776655',
        collegeId: 'IIITH2021',
        college: 'IIIT Hyderabad',
        course: 'B.Tech',
        branch: 'Computer Science',
        year: 2,
        interests: ['Mobile Development', 'UI/UX', 'Startups'],
        skills: ['Flutter', 'Dart', 'Figma'],
        joinedAt: DateTime.now().subtract(const Duration(days: 10)),
        isVerified: true,
      ),
    ];

    // Apply search filter
    var filteredUsers = users.where((user) {
      if (_searchQuery.isEmpty) return true;
      
      final query = _searchQuery.toLowerCase();
      return user.name.toLowerCase().contains(query) ||
             user.college.toLowerCase().contains(query) ||
             user.branch.toLowerCase().contains(query) ||
             user.interests.any((interest) => interest.toLowerCase().contains(query)) ||
             user.skills.any((skill) => skill.toLowerCase().contains(query));
    }).toList();

    // Apply category filter
    if (_selectedFilter != 'All') {
      // Mock filtering logic
      switch (_selectedFilter) {
        case 'Same College':
          filteredUsers = filteredUsers.where((user) => 
            user.college == 'IIT Bombay').toList();
          break;
        case 'Same Branch':
          filteredUsers = filteredUsers.where((user) => 
            user.branch == 'Computer Science').toList();
          break;
        case 'Same Year':
          filteredUsers = filteredUsers.where((user) => 
            user.year == 3).toList();
          break;
        case 'Similar Interests':
          filteredUsers = filteredUsers.where((user) => 
            user.interests.contains('Machine Learning')).toList();
          break;
      }
    }

    // Apply sorting
    switch (_selectedSort) {
      case 'Popular':
        filteredUsers.sort((a, b) => b.socialStats['followers']?.compareTo(a.socialStats['followers'] ?? 0) ?? 0);
        break;
      case 'Alphabetical':
        filteredUsers.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Year':
        filteredUsers.sort((a, b) => b.year.compareTo(a.year));
        break;
      default: // Recent
        filteredUsers.sort((a, b) => b.joinedAt.compareTo(a.joinedAt));
    }

    return filteredUsers;
  }

  void _viewProfile(UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(user: user),
      ),
    );
  }

  void _connectUser(UserModel user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connection request sent to ${user.name}!'),
        backgroundColor: const Color(0xFFF72585),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Filter Students',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ..._filters.map((filter) => ListTile(
              title: Text(
                filter,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: _selectedFilter == filter
                  ? const Icon(Icons.check, color: Color(0xFFF72585))
                  : null,
              onTap: () {
                setState(() => _selectedFilter = filter);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showSortDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sort Students',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ..._sortOptions.map((sort) => ListTile(
              title: Text(
                sort,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: _selectedSort == sort
                  ? const Icon(Icons.check, color: Color(0xFFF72585))
                  : null,
              onTap: () {
                setState(() => _selectedSort = sort);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  final UserModel user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Picture
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF72585), Color(0xFF7209B7)],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 58,
                      backgroundColor: Colors.grey[800],
                      child: Text(
                        user.name[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Name and Verification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (user.isVerified) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.verified,
                          color: const Color(0xFFF72585),
                          size: 24,
                        ),
                      ],
                    ],
                  ),
                  
                  // College and Course
                  Text(
                    '${user.course} - ${user.branch}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${user.college} • Year ${user.year}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: const Color(0xFFF72585)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Connect',
                            style: TextStyle(
                              color: const Color(0xFFF72585),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF72585),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Message',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Profile Details
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey[700]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Passionate ${user.branch} student with interests in ${user.interests.take(3).join(', ')}. Always eager to learn and collaborate on exciting projects!',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Skills
                  const Text(
                    'Skills',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: user.skills.map((skill) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF72585).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFF72585).withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          color: Color(0xFFF72585),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Interests
                  const Text(
                    'Interests',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: user.interests.map((interest) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7209B7).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF7209B7).withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        interest,
                        style: const TextStyle(
                          color: Color(0xFF7209B7),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}