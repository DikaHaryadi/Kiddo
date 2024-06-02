import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/interface/content/animal.dart';
import 'package:textspeech/interface/content/family.dart';
import 'package:textspeech/interface/content/letters.dart';
import 'package:textspeech/interface/content/numbers.dart';

const List<Map<String, dynamic>> gameLevels = [
  {'title': 'Easy', 'level': 4, 'kesulitan': '4 x 4'},
  {'title': 'Medium', 'level': 6, 'kesulitan': '6 x 6'},
  {'title': 'Hard', 'level': 8, 'kesulitan': '8 x 8'},
];

const String gameTitle = 'MEMORY MATCH';
const String puzzleitle = 'Image Word Puzzle';
const int maxFailedLoadAttempts = 3;

const AdRequest request = AdRequest(
  keywords: <String>['foo', 'bar'],
  contentUrl: 'http://foo.com/bar.html',
  nonPersonalizedAds: true,
);

//CATEGORIES
const contentKiddo = [
  {
    'imagePath': 'assets/banner_numbers.png',
    'name': 'Numbers',
    'routePath': '/number-content',
    'subtitle': '(numerus)',
  },
  {
    'imagePath': 'assets/letters.png',
    'name': 'Hijaiyah',
    'routePath': '/letters-content',
    'subtitle': '(الحروف الهجائية)',
  },
  {
    'imagePath': 'assets/banner_animals.png',
    'name': 'Animals',
    'routePath': '/animals-content',
    'subtitle': '(animalia)',
  },
  {
    'imagePath': 'assets/banner_family.png',
    'name': 'Family',
    'routePath': '/family-content',
    'subtitle': '(familia)',
  },
];

List<Widget> openContent = const [
  NumberContent(),
  LettersContent(),
  AnimalContent(),
  FamilyContent(),
];

// Navbar
const navbarOpsion = [
  {
    'title': 'RateUs',
    'routePath': '',
  },
  {
    'title': 'ContactUs',
    'routePath': '',
  },
  {
    'title': 'About App',
    'routePath': '',
  },
  {
    'title': 'Share App',
    'routePath': '',
  },
];

List<IconData> navicon = [
  Iconsax.star,
  Iconsax.mobile,
  Iconsax.info_circle,
  Iconsax.share
];

const gameList = [
  {
    'GameName': 'Memo Game',
    'subtitle': '(ludus memorialis)',
    'imagePath': 'assets/games/color.png',
    'enum': 'memo',
    'routePath': '/memo-game'
  },
  {
    'GameName': 'Summation',
    'subtitle': '(summation)',
    'imagePath': 'assets/games/memo.png',
    'enum': 'numbers',
    'routePath': '/main-menu-quiz'
  },
];
