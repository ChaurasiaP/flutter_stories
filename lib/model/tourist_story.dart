enum MediaType { image, video }

class TouristStory {
  final String url;
  final MediaType mediaType;
  final String caption;

  TouristStory({
    required this.url,
    required this.mediaType,
    required this.caption,
  });
}
