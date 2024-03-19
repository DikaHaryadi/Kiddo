import 'package:flutter/material.dart';

// class AppColors {
//   static const white = Color(0xffEEEEEE);
//   static const black = Color(0xff1e212d);
//   static const backGround = Color(0xfffcf4f1);
//   static const secondary = Color(0xff5fffe0);
//   static const crimson = Color(0xffff5f7e);
//   static const yellow = Color(0xfffbe698);
//   static const orange = Color(0xffff884b);
//   static const lpink = Color(0xffffcce7);
//   static const sage = Color(0xffdaf2dc);
//   static const pale = Color(0xffeacfff);
//   static const tale = Color(0xffdaf2dc);
//   static const green = Color(0xffffffff);
//   static const blue = Color.fromARGB(255, 0, 164, 252);
//   static const cust1 = Color.fromARGB(255, 0, 255, 238);
// }
const Color continueBtnColor = Color.fromRGBO(235, 32, 93, 1);
const Color restartBtnColor = Color.fromRGBO(243, 181, 45, 1);
const Color quitBtnColor = Color.fromRGBO(39, 162, 149, 1);

const List<Map<String, dynamic>> gameLevels = [
  {'title': 'Easy', 'level': 4, 'color': Colors.amberAccent},
  {'title': 'Medium', 'level': 6, 'color': Colors.blueAccent},
  {'title': 'Hard', 'level': 8, 'color': Colors.cyanAccent},
];

const String gameTitle = 'MEMORY MATCH';

// INI CONTENT UNTUK APPLIKASI
// const contentKiddo = [
//   {
//     'imagePath': 'assets/images/number.png',
//     'name': 'Number',
//     'imageHeader': 'assets/images/number.png',
//     'categories': [
//       {
//         'imageContent': 'assets/numbers/0.png',
//         'titleContent': 'Zero',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/1.png',
//         'titleContent': 'One',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/2.png',
//         'titleContent': 'Two',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/3.png',
//         'titleContent': 'Three',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/4.png',
//         'titleContent': 'Four',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/5.png',
//         'titleContent': 'Five',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/6.png',
//         'titleContent': 'Six',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/7.png',
//         'titleContent': 'Seven',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/8.png',
//         'titleContent': 'Eight',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//       {
//         'imageContent': 'assets/numbers/9.png',
//         'titleContent': 'Nine',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       },
//     ]
//   },
//   {
//     'imagePath': 'assets/letters.png',
//     'name': 'Alphabet',
//     'imageHeader': 'assets/images/number.png',
//     'categories': [
//       {
//         'imageContent': 'assets/animals.png',
//         'titleContent': 'Title Content',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       }
//     ]
//   },
//   {
//     'imagePath': 'assets/letters.png',
//     'name': 'Color',
//     'imageHeader': 'assets/images/number.png',
//     'categories': [
//       {
//         'imageContent': 'assets/animals.png',
//         'titleContent': 'Title Content',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       }
//     ]
//   },
//   {
//     'imagePath': 'assets/letters.png',
//     'name': 'Hijaiyah',
//     'imageHeader': 'assets/images/number.png',
//     'categories': [
//       {
//         'imageContent': 'assets/animals.png',
//         'titleContent': 'Title Content',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       }
//     ]
//   },
//   {
//     'imagePath': 'assets/animals.png',
//     'name': 'Animals',
//     'imageHeader': 'assets/images/number.png',
//     'categories': [
//       {
//         'imageContent': 'assets/animals.png',
//         'titleContent': 'Title Content',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       }
//     ]
//   },
//   {
//     'imagePath': 'assets/images/family.png',
//     'name': 'Family',
//     'imageHeader': 'assets/images/number.png',
//     'categories': [
//       {
//         'imageContent': 'assets/animals.png',
//         'titleContent': 'Title Content',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       }
//     ]
//   },
//   {
//     'imagePath': 'assets/images/fruits.png',
//     'name': 'Fruits',
//     'imageHeader': 'assets/images/number.png',
//     'categories': [
//       {
//         'imageContent': 'assets/animals.png',
//         'titleContent': 'Title Content',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       }
//     ]
//   },
//   {
//     'imagePath': 'assets/vegetables.png',
//     'name': 'Vegetables',
//     'imageHeader': 'assets/images/number.png',
//     'categories': [
//       {
//         'imageContent': 'assets/animals.png',
//         'titleContent': 'Title Content',
//         'subtitleContent': 'Subtitle Content',
//         'audio': ''
//       }
//     ]
//   },
// ];

//CATEGORIES
const CardsList = [
  {
    'imagePath': 'assets/images/number.png',
    'name': 'Number',
  },
  {
    'imagePath': 'assets/letters.png',
    'name': 'Alphabet',
  },
  {
    'imagePath': 'assets/letters.png',
    'name': 'Color',
  },
  {
    'imagePath': 'assets/letters.png',
    'name': 'Hijaiyah',
  },
  {
    'imagePath': 'assets/animals.png',
    'name': 'Animals',
  },
  {
    'imagePath': 'assets/images/family.png',
    'name': 'Family',
  },
  {
    'imagePath': 'assets/images/fruits.png',
    'name': 'Fruits',
  },
  {
    'imagePath': 'assets/vegetables.png',
    'name': 'Vegetables',
  },
];

// Content Slider
const contentSlider = [
  {
    'img': 'assets/images/number.png',
  },
  {
    'img': 'assets/animals.png',
  },
];

//ROUTES
// const routesList = [
//   {
//     'routePath': '/Nums',
//   },
//   {
//     'routePath': '/Letters',
//   },
//   {
//     'routePath': '/Animals',
//   },
//   {
//     'routePath': '/Family',
//   },
//   {
//     'routePath': '/Animals',
//   },
//   {
//     'routePath': '/Family',
//   },
//   {
//     'routePath': '/Fruits',
//   },
//   {
//     'routePath': '/Vegetables',
//   },
// ];

// const GamesList = [
//   {'GameName': 'Color Match', 'imagePath': 'assets/games/color.png'},
//   {'GameName': 'Shape Match', 'imagePath': 'assets/games/memo.png'},
// ];

const gamesRoutes = [
  {'routePath': '/memo-game'},
  {'routePath': '/numbers-game'},
];

//NUMS LIST
const numsList = [
  {
    'imagePath': 'assets/numbers/0.png',
    'counterPath': 'assets/counters/hands0.png',
    'name': 'Zero',
  },
  {
    'imagePath': 'assets/numbers/1.png',
    'counterPath': 'assets/counters/hands1.png',
    'name': 'One',
  },
  {
    'imagePath': 'assets/numbers/2.png',
    'counterPath': 'assets/counters/hands2.png',
    'name': 'Two',
  },
  {
    'imagePath': 'assets/numbers/3.png',
    'counterPath': 'assets/counters/hands3.png',
    'name': 'Three',
  },
  {
    'imagePath': 'assets/numbers/4.png',
    'counterPath': 'assets/counters/hands4.png',
    'name': 'Four',
  },
  {
    'imagePath': 'assets/numbers/5.png',
    'counterPath': 'assets/counters/hands5.png',
    'name': 'Five',
  },
  {
    'imagePath': 'assets/numbers/6.png',
    'counterPath': 'assets/counters/hands6.png',
    'name': 'Six',
  },
  {
    'imagePath': 'assets/numbers/7.png',
    'counterPath': 'assets/counters/hands7.png',
    'name': 'Seven',
  },
  {
    'imagePath': 'assets/numbers/8.png',
    'counterPath': 'assets/counters/hands8.png',
    'name': 'Eight',
  },
  {
    'imagePath': 'assets/numbers/9.png',
    'counterPath': 'assets/counters/hands9.png',
    'name': 'Nine',
  },
];

//ANIMALS LIST
const animalsList = [
  {
    'imagePath': 'assets/animals/leo.png',
    'voice': 'voices/leo.mp3',
    'name': 'Lion',
  },
  {
    'imagePath': 'assets/animals/duck.png',
    'voice': 'voices/duck.mp3',
    'name': 'Duck',
  },
  {
    'imagePath': 'assets/animals/chicken.png',
    'voice': 'voices/chicken.mp3',
    'name': 'Chicken',
  },
  {
    'imagePath': 'assets/animals/horse.png',
    'voice': 'voices/horse.mp3',
    'name': 'Horse',
  },
  {
    'imagePath': 'assets/animals/goat.png',
    'voice': 'voices/goat.mp3',
    'name': 'Goat',
  },
  {
    'imagePath': 'assets/animals/cat.png',
    'voice': 'voices/cat.mp3',
    'name': 'Cat',
  },
  {
    'imagePath': 'assets/animals/mouse.png',
    'voice': 'voices/mouse.mp3',
    'name': 'Mouse',
  },
  {
    'imagePath': 'assets/animals/frog.png',
    'voice': 'voices/frog.mp3',
    'name': 'Frog',
  },
  {
    'imagePath': 'assets/animals/dog.png',
    'voice': 'voices/dog.mp3',
    'name': 'Dog',
  },
  {
    'imagePath': 'assets/animals/cow.png',
    'voice': 'voices/cow.mp3',
    'name': 'Cow',
  },
];

//LETTERS LIST
const lettersList = [
  {
    'imagePath': 'assets/letters/أ.png',
    'subImage': 'assets/letters/avatars/أرنب.png',
    'name': 'أ',
  },
  {
    'imagePath': 'assets/letters/ب.png',
    'subImage': 'assets/letters/avatars/بطة.png',
    'name': 'ب',
  },
  {
    'imagePath': 'assets/letters/ت.png',
    'subImage': 'assets/letters/avatars/تفاح.png',
    'name': 'ت',
  },
  {
    'imagePath': 'assets/letters/ث.png',
    'subImage': 'assets/letters/avatars/ثلج.png',
    'name': 'ث',
  },
  {
    'imagePath': 'assets/letters/ج.png',
    'subImage': 'assets/letters/avatars/جَزَر.png',
    'name': 'ج',
  },
  {
    'imagePath': 'assets/letters/ح.png',
    'subImage': 'assets/letters/avatars/حصان.png',
    'name': 'ح',
  },
  {
    'imagePath': 'assets/letters/خ.png',
    'subImage': 'assets/letters/avatars/خيمة.png',
    'name': 'خ',
  },
  {
    'imagePath': 'assets/letters/د.png',
    'subImage': 'assets/letters/avatars/دولفين.png',
    'name': 'د',
  },
  {
    'imagePath': 'assets/letters/ذ.png',
    'subImage': 'assets/letters/avatars/ذُره.png',
    'name': 'ذ',
  },
  {
    'imagePath': 'assets/letters/ر.png',
    'subImage': 'assets/letters/avatars/ريشة.png',
    'name': 'ر',
  },
  {
    'imagePath': 'assets/letters/ز.png',
    'subImage': 'assets/letters/avatars/زرافة.png',
    'name': 'ز',
  },
  {
    'imagePath': 'assets/letters/س.png',
    'subImage': 'assets/letters/avatars/سلحفاة.png',
    'name': 'س',
  },
  {
    'imagePath': 'assets/letters/ش.png',
    'subImage': 'assets/letters/avatars/شمعة.png',
    'name': 'ش',
  },
  {
    'imagePath': 'assets/letters/ص.png',
    'subImage': 'assets/letters/avatars/صقر.png',
    'name': 'ص',
  },
  {
    'imagePath': 'assets/letters/ض.png',
    'subImage': 'assets/letters/avatars/ضفدع.png',
    'name': 'ض',
  },
  {
    'imagePath': 'assets/letters/ط.png',
    'subImage': 'assets/letters/avatars/طائرة.png',
    'name': 'ط',
  },
  {
    'imagePath': 'assets/letters/ظ.png',
    'subImage': 'assets/letters/avatars/ظرف.png',
    'name': 'ظ',
  },
  {
    'imagePath': 'assets/letters/ع.png',
    'subImage': 'assets/letters/avatars/عصفور.png',
    'name': 'ع',
  },
  {
    'imagePath': 'assets/letters/غ.png',
    'subImage': 'assets/letters/avatars/غزالة.png',
    'name': 'غ',
  },
  {
    'imagePath': 'assets/letters/ف.png',
    'subImage': 'assets/letters/avatars/فراولة.png',
    'name': 'ف',
  },
  {
    'imagePath': 'assets/letters/ق.png',
    'subImage': 'assets/letters/avatars/قلم.png',
    'name': 'ق',
  },
  {
    'imagePath': 'assets/letters/ك.png',
    'subImage': 'assets/letters/avatars/كرة.png',
    'name': 'ك',
  },
  {
    'imagePath': 'assets/letters/ل.png',
    'subImage': 'assets/letters/avatars/لمبة.png',
    'name': 'ل',
  },
  {
    'imagePath': 'assets/letters/م.png',
    'subImage': 'assets/letters/avatars/موز.png',
    'name': 'م',
  },
  {
    'imagePath': 'assets/letters/ن.png',
    'subImage': 'assets/letters/avatars/نجمة.png',
    'name': 'ن',
  },
  {
    'imagePath': 'assets/letters/ه.png',
    'subImage': 'assets/letters/avatars/هرم.png',
    'name': 'ه',
  },
  {
    'imagePath': 'assets/letters/و.png',
    'subImage': 'assets/letters/avatars/وردة.png',
    'name': 'و',
  },
  {
    'imagePath': 'assets/letters/ي.png',
    'subImage': 'assets/letters/avatars/يد.png',
    'name': 'ي',
  },
];

//FAMILY LIST
const familyList = [
  {
    'imagePath': 'assets/family/0.png',
    'name': 'الجد',
  },
  {
    'imagePath': 'assets/family/1.png',
    'name': 'الجدة',
  },
  {
    'imagePath': 'assets/family/2.png',
    'name': 'الأب',
  },
  {
    'imagePath': 'assets/family/3.png',
    'name': 'الأم',
  },
  {
    'imagePath': 'assets/family/4.png',
    'name': 'العم/الخال',
  },
  {
    'imagePath': 'assets/family/5.png',
    'name': 'العمة/الخالة',
  },
  {
    'imagePath': 'assets/family/6.png',
    'name': 'الابن',
  },
  {
    'imagePath': 'assets/family/7.png',
    'name': 'الابنة',
  },
  {
    'imagePath': 'assets/family/8.png',
    'name': 'ابن/ابنة العم',
  },
];

const fruitsList = [
  {
    'imagePath': 'assets/fruits/مانجو.png',
    'name': 'Mango',
  },
  {
    'imagePath': 'assets/fruits/بطيخ.png',
    'name': 'Watermelon',
  },
  {
    'imagePath': 'assets/fruits/كيوي.png',
    'name': 'Kiwi',
  },
  {
    'imagePath': 'assets/fruits/عنب.png',
    'name': 'Grape',
  },
];

const vegetablesList = [
  {
    'imagePath': 'assets/vegetables/بطاطس.png',
    'name': 'بطاطس',
  },
  {
    'imagePath': 'assets/vegetables/بازلاء.png',
    'name': 'بازلاء',
  },
  {
    'imagePath': 'assets/vegetables/فلفل.png',
    'name': 'فلفل',
  },
  {
    'imagePath': 'assets/vegetables/باذنجان.png',
    'name': 'باذنجان',
  },
  {
    'imagePath': 'assets/vegetables/خيار.png',
    'name': 'خيار',
  },
];
