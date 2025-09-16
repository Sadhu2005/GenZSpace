import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/user_model.dart';

class AddSwapItemWidget extends StatefulWidget {
  final Function(StudySwapItem) onItemAdded;

  const AddSwapItemWidget({
    super.key,
    required this.onItemAdded,
  });

  @override
  State<AddSwapItemWidget> createState() => _AddSwapItemWidgetState();
}

class _AddSwapItemWidgetState extends State<AddSwapItemWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  String _selectedCategory = 'books';
  String _selectedCondition = 'good';
  List<File> _selectedImages = [];

  final List<String> _categories = [
    'books',
    'notes',
    'equipment',
    'services',
  ];

  final List<String> _conditions = [
    'excellent',
    'good',
    'fair',
    'poor',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value * MediaQuery.of(context).size.height),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        Text(
                          'Add Item to Swap',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.check,
                            color: _canPost() ? Colors.green[300] : Colors.grey,
                          ),
                          onPressed: _canPost() ? _postItem : null,
                        ),
                      ],
                    ),
                  ),
                  
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category selection
                          _buildCategorySelection(),
                          
                          const SizedBox(height: 20),
                          
                          // Title input
                          _buildInputField(
                            controller: _titleController,
                            label: 'Item Title',
                            hint: 'e.g., Data Structures & Algorithms Book',
                            icon: Icons.title,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Description input
                          _buildInputField(
                            controller: _descriptionController,
                            label: 'Description',
                            hint: 'Describe your item in detail...',
                            icon: Icons.description,
                            maxLines: 4,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Price and condition row
                          Row(
                            children: [
                              Expanded(
                                child: _buildInputField(
                                  controller: _priceController,
                                  label: 'Price (₹)',
                                  hint: '0',
                                  icon: Icons.attach_money,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildConditionDropdown(),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Location input
                          _buildInputField(
                            controller: _locationController,
                            label: 'Location',
                            hint: 'e.g., IIT Bombay, Mumbai',
                            icon: Icons.location_on,
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Image selection
                          _buildImageSelection(),
                          
                          const SizedBox(height: 20),
                          
                          // Preview
                          if (_selectedImages.isNotEmpty)
                            _buildImagePreview(),
                          
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _getCategoryColor(category).withOpacity(0.2)
                        : Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? _getCategoryColor(category)
                          : Colors.grey[700]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _getCategoryIcon(category),
                        color: isSelected
                            ? _getCategoryColor(category)
                            : Colors.grey[400],
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category.capitalize(),
                        style: TextStyle(
                          color: isSelected
                              ? _getCategoryColor(category)
                              : Colors.grey[400],
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
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
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(icon, color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConditionDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Condition',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[700]!,
              width: 1,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedCondition,
            dropdownColor: Colors.grey[900],
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            items: _conditions.map((condition) {
              return DropdownMenuItem<String>(
                value: condition,
                child: Text(condition.capitalize()),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedCondition = value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Photos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildImageButton(
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: () => _pickImage(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildImageButton(
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: () => _pickImage(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
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
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selected Photos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _selectedImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImages[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImages.removeAt(index);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'books':
        return Colors.blue[300]!;
      case 'notes':
        return Colors.green[300]!;
      case 'equipment':
        return Colors.orange[300]!;
      case 'services':
        return Colors.purple[300]!;
      default:
        return Colors.grey[300]!;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'books':
        return Icons.book;
      case 'notes':
        return Icons.note;
      case 'equipment':
        return Icons.build;
      case 'services':
        return Icons.work;
      default:
        return Icons.category;
    }
  }

  bool _canPost() {
    return _titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _priceController.text.trim().isNotEmpty &&
        _locationController.text.trim().isNotEmpty &&
        _selectedImages.isNotEmpty;
  }

  Future<void> _pickImage() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images.map((image) => File(image.path)));
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error picking images: $e');
    }
  }

  void _postItem() async {
    if (!_canPost()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final item = StudySwapItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sellerId: 'current_user', // Replace with actual user ID
        sellerName: 'You', // Replace with actual user name
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        category: _selectedCategory,
        images: _selectedImages.map((file) => file.path).toList(),
        condition: _selectedCondition,
        location: _locationController.text.trim(),
        createdAt: DateTime.now(),
      );

      widget.onItemAdded(item);
    } catch (e) {
      _showErrorSnackBar('Error posting item: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
