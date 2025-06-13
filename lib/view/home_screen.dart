import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stories/model/state.dart';
import 'package:flutter_stories/model/story_data.dart';
import 'package:flutter_stories/view/story_viewer_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StateStory> _stories = [];

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  void _loadStories() {
    final data = jsonDecode(jsonData);
    final List<dynamic> storyList = data['stories'];
    setState(() {
      _stories = storyList.map((json) => StateStory.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel Stories"),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStoryThumbnails(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Explore India",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Tap a story above to view!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryThumbnails() {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StoryViewer(stateStory: story),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blueGrey,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: CachedNetworkImageProvider(
                        story.places.first.image,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    story.state,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}