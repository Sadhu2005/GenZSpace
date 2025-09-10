import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/user_model.dart';
import '../widgets/swap_item_card.dart';
import '../widgets/add_swap_item_widget.dart';

class StudySwapScreen extends StatefulWidget {
  const StudySwapScreen({super.key});

  @override
  State<StudySwapScreen> createState() => _StudySwapScreenState();
}

class _StudySwapScreenState extends State<StudySwapScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _selectedCategory = 'All';
  String _sortBy = 'Recent';

  final List<String> _categories = [
    'All',
    'Books',
    'Notes',
    'Equipment',
    'Services',
  ];

  final List<String> _sortOptions = [
    'Recent',
    'Price: Low to High',
    'Price: High to Low',
    'Popular',
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.swap_horiz,
              color: Colors.green[300],
              size: 28,
            ),
            const SizedBox(width: 8),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.green[300]!,
                  Colors.blue[300]!,
                ],
              ).createShader(bounds),
              child: const Text(
                'Study Swap',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.green[300]),
            onPressed: () => _showAddItemDialog(),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Filters and search
            _buildFiltersAndSearch(),
            
            // Items grid
            Expanded(
              child: _buildItemsGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[700]!,
                width: 1,
              ),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for books, notes, equipment...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Category filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green[300]!.withOpacity(0.2)
                            : Colors.grey[800],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.green[300]!
                              : Colors.grey[700]!,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.green[300]
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
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Sort options
          Row(
            children: [
              Text(
                'Sort by: ',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              DropdownButton<String>(
                value: _sortBy,
                dropdownColor: Colors.grey[900],
                style: const TextStyle(color: Colors.white),
                underline: Container(),
                items: _sortOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _sortBy = value);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsGrid() {
    // Mock data for demonstration
    final List<StudySwapItem> items = [
      StudySwapItem(
        id: '1',
        sellerId: 'user1',
        sellerName: 'Rahul Sharma',
        title: 'Data Structures & Algorithms Book',
        description: 'Complete DSA book with solved examples. Perfect condition.',
        price: 450.0,
        category: 'books',
        images: ['https://picsum.photos/300/400?random=1'],
        condition: 'Like New',
        location: 'IIT Bombay',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      StudySwapItem(
        id: '2',
        sellerId: 'user2',
        sellerName: 'Priya Patel',
        title: 'Calculus Notes - Semester 3',
        description: 'Comprehensive notes with diagrams and examples.',
        price: 200.0,
        category: 'notes',
        images: ['https://picsum.photos/300/400?random=2'],
        condition: 'Good',
        location: 'NIT Surathkal',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      StudySwapItem(
        id: '3',
        sellerId: 'user3',
        sellerName: 'Amit Kumar',
        title: 'Scientific Calculator',
        description: 'Casio fx-991EX ClassWiz. Barely used.',
        price: 1200.0,
        category: 'equipment',
        images: ['https://picsum.photos/300/400?random=3'],
        condition: 'Excellent',
        location: 'IIT Delhi',
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      StudySwapItem(
        id: '4',
        sellerId: 'user4',
        sellerName: 'Neha Singh',
        title: 'Programming Tutoring',
        description: '1-on-1 coding sessions for beginners. 5 sessions available.',
        price: 500.0,
        category: 'services',
        images: ['https://picsum.photos/300/400?random=4'],
        condition: 'Service',
        location: 'BITS Pilani',
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
    ];

    // Filter items based on selected category
    final filteredItems = _selectedCategory == 'All'
        ? items
        : items.where((item) => item.category == _selectedCategory.toLowerCase()).toList();

    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: SwapItemCard(
                  item: filteredItems[index],
                  onTap: () => _viewItem(filteredItems[index]),
                  onInterest: () => _showInterest(filteredItems[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddItemDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddSwapItemWidget(
        onItemAdded: (item) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${item.category.capitalize()} added successfully!'),
              backgroundColor: Colors.green[300],
            ),
          );
        },
      ),
    );
  }

  void _viewItem(StudySwapItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SwapItemDetailScreen(item: item),
      ),
    );
  }

  void _showInterest(StudySwapItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Interested in this item?',
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          'You can contact ${item.sellerName} to discuss the details.',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Interest sent to ${item.sellerName}!'),
                  backgroundColor: Colors.green[300],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[300],
            ),
            child: const Text('Contact Seller'),
          ),
        ],
      ),
    );
  }
}

class SwapItemDetailScreen extends StatefulWidget {
  final StudySwapItem item;

  const SwapItemDetailScreen({super.key, required this.item});

  @override
  State<SwapItemDetailScreen> createState() => _SwapItemDetailScreenState();
}

class _SwapItemDetailScreenState extends State<SwapItemDetailScreen> {
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
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.item.images.isNotEmpty
                      ? widget.item.images.first
                      : 'https://picsum.photos/400/300?random=1'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and price
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[300]!.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green[300]!,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '₹${widget.item.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: Colors.green[300],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Seller info
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue[300],
                        child: Text(
                          widget.item.sellerName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.sellerName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.item.location,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[300]!.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.item.category.toUpperCase(),
                          style: TextStyle(
                            color: Colors.blue[300],
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.description,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Details
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('Condition', widget.item.condition),
                        _buildDetailRow('Location', widget.item.location),
                        _buildDetailRow('Posted', _getTimeAgo(widget.item.createdAt)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.green[300]!),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Message Seller',
                            style: TextStyle(
                              color: Colors.green[300],
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
                            backgroundColor: Colors.green[300],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Buy Now',
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
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

