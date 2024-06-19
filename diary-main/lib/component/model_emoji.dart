// model_emoji.dart

import 'package:animated_emoji/animated_emoji.dart';

class ModelEmoji {
  static int? getEmojiValue(AnimatedEmojiData emoticonFace) {
    if (emoticonFace == AnimatedEmojis.smile) return 1;
    if (emoticonFace == AnimatedEmojis.rage) return 2;
    if (emoticonFace == AnimatedEmojis.rofl) return 3;
    if (emoticonFace == AnimatedEmojis.happyCry) return 4;
    if (emoticonFace == AnimatedEmojis.heartFace) return 5;
    if (emoticonFace == AnimatedEmojis.sleep) return 6;
    return 0; // Default or unknown emoji
  }
}