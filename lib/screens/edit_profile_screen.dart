import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Rahul Sharma');
  final _collegeController = TextEditingController(text: 'IIT Bombay');
  final _courseController = TextEditingController(text: 'B.Tech');
  final _branchController = TextEditingController(text: 'Computer Science');
  final _bioController = TextEditingController(text: 'Passionate Computer Science student with a love for technology and innovation.');
  final _instagramController = TextEditingController(text: '@rahulsharma');
  final _linkedinController = TextEditingController(text: 'linkedin.com/in/rahulsharma');

  int _selectedYear = 3;
  List<String> _selectedInterests = ['Machine Learning', 'Web Development', 'Gaming'];
  List<String> _selectedSkills = ['Python', 'JavaScript', 'React'];

  final List<String> _availableInterests = [
    'Machine Learning', 'Web Development', 'Gaming', 'Music', 'Photography',
    'Data Science', 'AI', 'Mobile Development', 'UI/UX', 'Blockchain',
    'IoT', 'Robotics', 'Sports', 'Reading', 'Traveling', 'Art', 'Dancing'
  ];

  final List<String> _availableSkills = [
    'Python', 'JavaScript', 'React', 'Flutter', 'TensorFlow', 'Java',
    'C++', 'Dart', 'Node.js', 'MongoDB', 'Firebase', 'Git', 'Docker',
    'AWS', 'Figma', 'Photoshop', 'Premiere Pro', 'SolidWorks'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _collegeController.dispose();
    _courseController.dispose();
    _branchController.dispose();
    _bioController.dispose();
    _instagramController.dispose();
    _linkedinController.dispose();
    super.dispose();
  }

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
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFFF72585),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              _buildProfilePictureSection(),
              const SizedBox(height: 24),
              
              // Basic Information
              _buildSectionHeader('Basic Information'),
              _buildInputCard([
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  validator: (value) => value?.isEmpty == true ? 'Name is required' : null,
                ),
                _buildTextField(
                  controller: _collegeController,
                  label: 'College',
                  icon: Icons.school_outlined,
                  validator: (value) => value?.isEmpty == true ? 'College is required' : null,
                ),
                _buildTextField(
                  controller: _courseController,
                  label: 'Course',
                  icon: Icons.menu_book_outlined,
                  validator: (value) => value?.isEmpty == true ? 'Course is required' : null,
                ),
                _buildTextField(
                  controller: _branchController,
                  label: 'Branch',
                  icon: Icons.engineering_outlined,
                  validator: (value) => value?.isEmpty == true ? 'Branch is required' : null,
                ),
                _buildYearSelector(),
              ]),
              
              const SizedBox(height: 24),
              
              // Bio Section
              _buildSectionHeader('Bio'),
              _buildInputCard([
                _buildTextField(
                  controller: _bioController,
                  label: 'About Me',
                  icon: Icons.description_outlined,
                  maxLines: 3,
                ),
              ]),
              
              const SizedBox(height: 24),
              
              // Interests Section
              _buildSectionHeader('Interests'),
              _buildInputCard([
                _buildChipSelector(
                  'Select your interests',
                  _selectedInterests,
                  _availableInterests,
                  (interests) => setState(() => _selectedInterests = interests),
                ),
              ]),
              
              const SizedBox(height: 24),
              
              // Skills Section
              _buildSectionHeader('Skills'),
              _buildInputCard([
                _buildChipSelector(
                  'Select your skills',
                  _selectedSkills,
                  _availableSkills,
                  (skills) => setState(() => _selectedSkills = skills),
                ),
              ]),
              
              const SizedBox(height: 24),
              
              // Social Links Section
              _buildSectionHeader('Social Links'),
              _buildInputCard([
                _buildTextField(
                  controller: _instagramController,
                  label: 'Instagram',
                  icon: Icons.camera_alt_outlined,
                  prefix: '@',
                ),
                _buildTextField(
                  controller: _linkedinController,
                  label: 'LinkedIn',
                  icon: Icons.work_outline,
                  prefix: 'linkedin.com/in/',
                ),
              ]),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7209B7), Color(0xFFF72585)],
                  ),
                ),
                child: CircleAvatar(
                  radius: 58,
                  backgroundColor: Colors.grey[800],
                  child: Text(
                    _nameController.text.isNotEmpty 
                        ? _nameController.text[0].toUpperCase()
                        : 'R',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _changeProfilePicture,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF72585),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Tap to change profile picture',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputCard(List<Widget> children) {
    return Container(
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
        children: children,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? prefix,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[500]),
          prefixText: prefix,
          prefixStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFF72585)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildYearSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Year',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _selectedYear,
                isExpanded: true,
                dropdownColor: Colors.grey[800],
                style: const TextStyle(color: Colors.white),
                items: List.generate(4, (index) => index + 1)
                    .map((year) => DropdownMenuItem(
                          value: year,
                          child: Text('Year $year'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedYear = value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipSelector(
    String title,
    List<String> selectedItems,
    List<String> availableItems,
    Function(List<String>) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableItems.map((item) {
            final isSelected = selectedItems.contains(item);
            return GestureDetector(
              onTap: () {
                final newSelection = List<String>.from(selectedItems);
                if (isSelected) {
                  newSelection.remove(item);
                } else {
                  newSelection.add(item);
                }
                onChanged(newSelection);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  item,
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
            );
          }).toList(),
        ),
      ],
    );
  }

  void _changeProfilePicture() {
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
              'Change Profile Picture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption(Icons.camera_alt, 'Camera', () {
                  Navigator.pop(context);
                  _takePhoto();
                }),
                _buildImageOption(Icons.photo_library, 'Gallery', () {
                  Navigator.pop(context);
                  _selectFromGallery();
                }),
                _buildImageOption(Icons.delete, 'Remove', () {
                  Navigator.pop(context);
                  _removePhoto();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFF72585).withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFF72585),
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _takePhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Camera feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _selectFromGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _removePhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile picture removed!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Save profile logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      Navigator.pop(context);
    }
  }
}
