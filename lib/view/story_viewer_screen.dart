import 'package:flutter/material.dart';
import 'package:flutter_stories/model/state.dart';
import 'package:story_view/story_view.dart';
import 'package:cached_network_image/cached_network_image.dart';


class StoryViewer extends StatefulWidget {
  final StateStory stateStory;

  const StoryViewer({super.key, required this.stateStory});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  final StoryController _storyController = StoryController();
  final List<StoryItem> _storyItems = [];

  @override
  void initState() {
    super.initState();
    _loadStoryItems();
  }
  
  void _loadStoryItems() {
    for (final place in widget.stateStory.places) {
      _storyItems.add(
        StoryItem.pageImage(
          url: place.image,
          controller: _storyController,
          caption: Text(
            "${place.name}\n\n${place.description}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              backgroundColor: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          imageFit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: _storyItems,
        controller: _storyController,
        onComplete: () {
          Navigator.of(context).pop();
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.of(context).pop();
          }
        },
        inline: false, // Set to true for inline stories
        repeat: false, // Set to true to repeat stories
      ),
    );
  }
}