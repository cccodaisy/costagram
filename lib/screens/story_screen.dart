import 'package:cached_network_image/cached_network_image.dart';
import 'package:costagram/models/story_model.dart';
import 'package:costagram/widgets/animated_bar.dart';
import 'package:costagram/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  final List<Story> stories;
  const StoryScreen({@required this.stories});

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animationController;
  VideoPlayerController _videoController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);
    _videoController = VideoPlayerController.network(
        widget.stories[2].url
    ) ..initialize().then((value) => setState(() {}));
    _videoController.play(); // play!

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if(_currentIndex + 1 < widget.stories.length){
            _currentIndex += 1;
            _loadStory(story: widget.stories[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadStory(story: widget.stories[_currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[_currentIndex];
    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTapDown: (details) => _onTapDown(details, story),
          child: Stack(
            children: [
              PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: widget.stories.length,
                  itemBuilder: (context, i) {
                    final Story story = widget.stories[i];
                    switch (story.media) {
                      case MediaType.image:
                        return CachedNetworkImage(
                          imageUrl: story.url,
                          fit: BoxFit.cover,
                        );
                      case MediaType.video:
                        if(_videoController != null && _videoController.value.initialized) {
                          return FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          );
                        }
                    }
                    return const SizedBox.shrink();
                  }
              ),
              Positioned(
                top: 40.0,
                left: 10.0,
                right: 10.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: widget.stories
                          .asMap()
                          .map((i, e) {
                        return MapEntry(
                            i,
                            AnimatedBar(
                              animationController: _animationController,
                              position: i,
                              currentIndex: _currentIndex,
                            )
                        );
                      })
                          .values
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 1.5,
                        vertical: 10.0,
                      ),
                      child: UserInfo(user: story.user),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if(dx < screenWidth / 3) {
      setState(() {
        if(_currentIndex -1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if(_currentIndex + 1 < widget.stories.length) {
          _currentIndex += 1;
          _loadStory(story: widget.stories[_currentIndex]);
        } else {
          _currentIndex = 0;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else {
      if(story.media == MediaType.video) {
        if(_videoController.value.isPlaying) {
          _videoController.pause();
          _animationController.stop();
        } else {
          _videoController.play();
          _animationController.forward();
        }
      }
    }
  }

  void _loadStory({Story story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    switch(story.media) {
      case MediaType.image:
        _animationController.duration = story.duration;
        _animationController.forward();
        break;
      case MediaType.video:
        _videoController = null;
        _videoController?.dispose();
        _videoController = VideoPlayerController.network(story.url)
          ..initialize().then((_) {
            setState(() {});
            if(_videoController.value.initialized) {
              _animationController.duration = _videoController.value.duration;
              _videoController.play();
              _animationController.forward();
            }
          });
        break;
    }
    if(animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}
