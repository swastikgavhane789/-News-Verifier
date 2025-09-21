import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _loading = false;
  String? _result;
  List<dynamic>? _sources;

  Future<void> _verifyText() async {
    if (_textController.text.trim().isEmpty) return;
    setState(() {
      _loading = true;
      _result = null;
      _sources = null;
    });

    try {
      final data = await ApiService.verifyText(_textController.text.trim());
      setState(() {
        _result = "Truth Score: ${data['score']}%\n${data['explanation']}";
        _sources = data['sources'];
      });
    } catch (e) {
      setState(() => _result = "Error: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _verifyImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      _loading = true;
      _result = null;
      _sources = null;
    });

    try {
      final data = await ApiService.verifyImage(File(pickedFile.path));
      setState(() {
        _result = "Truth Score: ${data['score']}%\n${data['explanation']}";
        _sources = data['sources'];
      });
    } catch (e) {
      setState(() => _result = "Error: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _buildSources() {
    if (_sources == null || _sources!.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sources:", style: TextStyle(fontWeight: FontWeight.bold)),
        ..._sources!.map((s) => InkWell(
              onTap: () {},
              child: Text(
                s.toString(),
                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Floating News Verifier"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "Enter text to verify",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _verifyText,
              icon: const Icon(Icons.check_circle),
              label: const Text("Verify Text"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _verifyImage,
              icon: const Icon(Icons.image),
              label: const Text("Verify Image"),
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_result != null) ...[
              Text(
                _result!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSources(),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _verifyImage,
        child: const Icon(Icons.search),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
