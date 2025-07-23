import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class InfoSectionPage extends StatefulWidget {
  final String title;
  final List<Map<String, String>> fields;

  const InfoSectionPage({super.key, required this.title, required this.fields});

  @override
  State<InfoSectionPage> createState() => _InfoSectionPageState();
}

class _InfoSectionPageState extends State<InfoSectionPage> {
  late List<TextEditingController> _controllers;
  bool _isEditing = false;

  Map<String, String> updatedData = {};

  @override
  void initState() {
    super.initState();
    _controllers = widget.fields
        .map((item) => TextEditingController(text: item['value']))
        .toList();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleEditSave() {
    if (_isEditing) {
      for (int i = 0; i < widget.fields.length; i++) {
        updatedData[widget.fields[i]['label']!] = _controllers[i].text;
      }
      print('Saved Data: $updatedData');
    }

    setState(() => _isEditing = !_isEditing);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 1,
        leading: const BackButton(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          child: ListView.builder(
            itemCount: widget.fields.length,
            itemBuilder: (context, index) {
              final label = widget.fields[index]['label']!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19 * textScale,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _isEditing
                      ? TextField(
                          controller: _controllers[index],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _controllers[index].text,
                            style: TextStyle(fontSize: 18 * textScale),
                          ),
                        ),
                  !_isEditing
                      ? const Divider(height: 24)
                      : const SizedBox(height: 0.1),
                  SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleEditSave,
        backgroundColor: secondaryColor,
        label: Text(
          _isEditing ? 'Save' : 'Edit',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Colors.white),
      ),
    );
  }
}
