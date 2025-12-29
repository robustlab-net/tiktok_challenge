import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';
import 'package:tiktok_challenge/features/posts/view_models/post_view_model.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('글쓰기 화면'),
      ),
    );
  }
}

class NewThreadScreen extends ConsumerStatefulWidget {
  const NewThreadScreen({super.key});

  @override
  ConsumerState<NewThreadScreen> createState() => _NewThreadScreenState();
}

class _NewThreadScreenState extends ConsumerState<NewThreadScreen> {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  bool _hasText = false;
  XFile? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _hasText = _textController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write something'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      File? imageFile;
      if (_selectedImage != null) {
        imageFile = File(_selectedImage!.path);
      }

      await ref.read(postProvider.notifier).createPost(
            text: _textController.text.trim(),
            imageFile: imageFile,
          );

      final state = ref.read(postProvider);

      if (state.hasError) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Exception: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _showImageSourceDialog() async {
    final isDark = ref.read(darkModeProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _imagePicker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Library'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _imagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(darkModeProvider);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : Colors.white,
          elevation: 0,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          leadingWidth: 80,
          title: Text(
            'New thread',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left side - Profile, line, and avatar
                          Column(
                            children: [
                              // Profile image
                              const CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  'https://picsum.photos/100/100?random=user',
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Vertical line with fixed height
                              Container(
                                width: 2,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.grey.shade700
                                      : Colors.grey.shade300,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Small avatar at bottom
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: isDark
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade200,
                                backgroundImage: const NetworkImage(
                                  'https://picsum.photos/100/100?random=user',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          // Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Username
                                const Text(
                                  'Anonymous',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // Text input
                                TextField(
                                  controller: _textController,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Start a thread...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Selected image
                                if (_selectedImage != null) ...[
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          File(_selectedImage!.path),
                                          width: double.infinity,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedImage = null;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade800
                                                  .withOpacity(0.8),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                                // Attachment icon
                                GestureDetector(
                                  onTap: _showImageSourceDialog,
                                  child: Icon(
                                    FontAwesomeIcons.paperclip,
                                    color: Colors.grey.shade400,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Anyone can reply',
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: _hasText && !_isLoading ? _onSubmit : null,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Post',
                                style: TextStyle(
                                  color: _hasText
                                      ? const Color(0xFF0095F6)
                                      : Colors.grey.shade400,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
