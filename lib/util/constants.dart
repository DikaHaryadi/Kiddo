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
const contentKiddo = [
  {
    'imagePath': 'assets/images/number.png',
    'name': 'Number',
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
const routesList = [
  {
    'routePath': '/number-content',
  },
  {
    'routePath': '/letters-content',
  },
  {
    'routePath': '/animals-content',
  },
  {
    'routePath': '/family-content',
  },
  {
    'routePath': '/fruits-content',
  },
  {
    'routePath': '/vegetables-content',
  },
];

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
    'kategori': 'Mamalia',
    'jenis_makan': 'Karnivora',
    'deskripsi':
        'Singa adalah kucing besar dengan mantel cokelat keemasan, jantan memiliki janggut tebal. Mereka hidup dalam kelompok sosial yang disebut "pride" dan sering berburu mangsa besar seperti zebra dan impala. Singa aktif terutama pada malam hari.'
  },
  {
    'imagePath': 'assets/animals/duck.png',
    'voice': 'voices/duck.mp3',
    'name': 'Duck',
    'kategori': 'Unggas',
    'jenis_makan': 'Omnivora',
    'deskripsi':
        'Bebek adalah jenis unggas air yang sering ditemui di danau, sungai, dan kolam di seluruh dunia. Mereka memiliki tubuh ramping dengan leher panjang, paruh ramping, dan bulu yang biasanya berwarna cokelat atau hijau keabu-abuan. Bebek sering dijinakkan dan dipelihara oleh manusia untuk daging, telur, dan hobi.'
  },
  {
    'imagePath': 'assets/animals/chicken.png',
    'voice': 'voices/chicken.mp3',
    'name': 'Chicken',
    'kategori': 'Unggas',
    'jenis_makan': 'Omnivora',
    'deskripsi':
        'Ayam adalah jenis unggas yang sering dijinakkan dan dipelihara oleh manusia untuk daging, telur, dan bulu. Mereka memiliki tubuh berbulu dengan sayap, kaki bersisik, dan paruh. Ada banyak ras ayam dengan variasi dalam warna, ukuran, dan karakteristik fisik lainnya. Ayam biasanya hidup dalam kandang atau peternakan, tetapi ada juga ayam liar yang hidup di alam liar.'
  },
  {
    'imagePath': 'assets/animals/horse.png',
    'voice': 'voices/horse.mp3',
    'name': 'Horse',
    'kategori': 'Mamalia',
    'jenis_makan': 'Herbivora',
    'deskripsi':
        'Kuda adalah mamalia berkuku genap yang digunakan manusia untuk transportasi, pertanian, dan olahraga. Mereka memiliki tubuh besar dengan kaki panjang dan kuat, ekor berbulu, dan bulu di sekitar leher yang disebut "jambul". Kuda dapat memiliki berbagai warna bulu dan banyak ras yang berbeda. Mereka memiliki hubungan yang kuat dengan manusia selama ribuan tahun dan sering menjadi bagian penting dalam budaya dan sejarah manusia.'
  },
  {
    'imagePath': 'assets/animals/goat.png',
    'voice': 'voices/goat.mp3',
    'name': 'Goat',
    'kategori': 'Mamalia',
    'jenis_makan': 'Herbivora',
    'deskripsi':
        'Kambing adalah mamalia kecil berkuku genap yang sering dipelihara oleh manusia untuk daging, susu, dan bulu. Mereka memiliki tubuh yang ramping dengan bulu yang bisa beragam warna dan jenis, seperti halnya tanduk yang biasanya ada pada kedua jenis kelamin. Kambing adalah hewan yang serbaguna, mereka dapat hidup di berbagai lingkungan dan mampu beradaptasi dengan kondisi lingkungan yang berbeda. Kambing juga memiliki sifat penjelajahan yang kuat dan mampu memakan berbagai macam tumbuhan.'
  },
  {
    'imagePath': 'assets/animals/cat.png',
    'voice': 'voices/cat.mp3',
    'name': 'Cat',
    'kategori': 'Mamalia',
    'jenis_makan': 'Karnivora',
    'deskripsi':
        'Kucing adalah mamalia kecil yang sering dijinakkan oleh manusia sebagai hewan peliharaan. Mereka memiliki tubuh kecil, fleksibel, dengan bulu yang halus dan cakar yang tajam. Kucing biasanya memiliki mata yang besar dan telinga yang tegak. Mereka dikenal karena kemampuan berburu dan sikap mandiri. Kucing dapat memiliki berbagai warna bulu dan karakteristik fisik yang berbeda tergantung pada rasnya. Sebagai hewan peliharaan, kucing sering diberi makan makanan khusus dan mendapat perhatian serta kasih sayang dari pemiliknya.'
  },
  {
    'imagePath': 'assets/animals/mouse.png',
    'voice': 'voices/mouse.mp3',
    'name': 'Mouse',
    'kategori': 'Mamalia',
    'jenis_makan': 'Omnivora',
    'deskripsi':
        'Tikus adalah mamalia kecil yang sering ditemui di berbagai habitat di seluruh dunia. Mereka memiliki tubuh kecil dengan telinga dan ekor panjang. Tikus sering kali dianggap sebagai hama karena kemampuannya merusak tanaman, makanan, dan benda-benda di rumah. Namun, tikus juga memainkan peran penting dalam ekosistem sebagai pemakan serangga dan penyebar biji-bijian. Beberapa jenis tikus juga dijinakkan dan dipelihara sebagai hewan peliharaan.'
  },
  {
    'imagePath': 'assets/animals/frog.png',
    'voice': 'voices/frog.mp3',
    'name': 'Frog',
    'kategori': 'Amphibia',
    'jenis_makan': 'Omnivora',
    'deskripsi':
        'Katak adalah amfibi dengan tubuh yang halus dan licin, serta memiliki kaki yang panjang dan kuat untuk melompat. Mereka biasanya hidup di dekat air, seperti rawa, danau, atau sungai, meskipun ada beberapa spesies yang hidup di darat. Katak memiliki kulit yang berpori, yang memungkinkan mereka untuk bernapas melalui kulit saat berada di dalam air. Mereka juga memiliki lidah yang panjang dan lengket untuk menangkap mangsa, seperti serangga atau cacing. Tahap awal kehidupan mereka biasanya adalah berupa larva yang hidup di air, yang kemudian berkembang menjadi katak dewasa. Beberapa jenis katak memiliki kemampuan untuk berubah warna sesuai dengan lingkungan mereka, yang berfungsi sebagai mekanisme perlindungan diri.'
  },
  {
    'imagePath': 'assets/animals/dog.png',
    'voice': 'voices/dog.mp3',
    'name': 'Dog',
    'kategori': 'Mamalia',
    'jenis_makan': 'Karnivora',
    'deskripsi':
        'Anjing adalah mamalia yang sering dijinakkan dan dipelihara oleh manusia sebagai hewan peliharaan, hewan pekerja, atau untuk tujuan perlindungan. Mereka memiliki berbagai ras, ukuran, dan warna bulu yang berbeda. Anjing dikenal karena kecerdasan, loyalitas, dan kemampuan untuk berinteraksi dengan manusia. Mereka juga dapat dilatih untuk berbagai tugas, seperti penjagaan, penelusuran, penjagaan ternak, atau sebagai hewan pendamping untuk orang-orang dengan kebutuhan khusus. Anjing juga memainkan peran penting dalam kehidupan manusia sebagai sahabat yang setia dan memberikan dukungan emosional.'
  },
  {
    'imagePath': 'assets/animals/cow.png',
    'voice': 'voices/cow.mp3',
    'name': 'Cow',
    'kategori': 'Mamalia',
    'jenis_makan': 'Herbivora',
    'deskripsi':
        'Sapi adalah mamalia besar yang sering dipelihara oleh manusia untuk daging, susu, dan tenaga kerja. Mereka memiliki tubuh yang besar dengan bulu yang beragam warna dan pola, serta memiliki tanduk pada beberapa ras. Sapi adalah hewan herbivora, yang berarti mereka memakan rumput dan tanaman lainnya. Mereka biasanya diatur dalam peternakan atau padang rumput, dan peran mereka dalam kehidupan manusia sangat beragam, mulai dari sumber makanan hingga bahan baku untuk produk-produk seperti kulit dan tulang. Sapi juga sering digunakan sebagai hewan kerja dalam beberapa masyarakat agraris.'
  },
];

//LETTERS LIST
const lettersList = [
  {
    'imagePath': 'assets/letters/alif_hamza.png',
    'subImage': 'assets/letters/samples/alif_hamza.png',
    'name': 'Alif',
  },
  {
    'imagePath': 'assets/letters/ba.png',
    'subImage': 'assets/letters/samples/ba.png',
    'name': 'Ba'
  },
  {
    'imagePath': 'assets/letters/ta.png',
    'subImage': 'assets/letters/samples/ta.png',
    'name': 'Ta',
  },
  {
    'imagePath': 'assets/letters/tsa.png',
    'subImage': 'assets/letters/samples/tsa.png',
    'name': "Tsa'",
  },
  {
    'imagePath': 'assets/letters/jim.png',
    'subImage': 'assets/letters/samples/jim.png',
    'name': 'Jim',
  },
  {
    'imagePath': 'assets/letters/ha.png',
    'subImage': 'assets/letters/samples/ha.png',
    'name': 'Ha',
  },
  {
    'imagePath': 'assets/letters/kho.png',
    'subImage': 'assets/letters/samples/kho.png',
    'name': 'Kho'
  },
  {
    'imagePath': 'assets/letters/dal.png',
    'subImage': 'assets/letters/samples/dal.png',
    'name': 'Dal',
  },
  {
    'imagePath': 'assets/letters/dzal.png',
    'subImage': 'assets/letters/samples/dzal.png',
    'name': 'Dzal',
  },
  {
    'imagePath': 'assets/letters/ro.png',
    'subImage': 'assets/letters/samples/ro.png',
    'name': 'Ro',
  },
  {
    'imagePath': 'assets/letters/za.png',
    'subImage': 'assets/letters/samples/za.png',
    'name': 'Zay',
  },
  {
    'imagePath': 'assets/letters/sin.png',
    'subImage': 'assets/letters/samples/sin.png',
    'name': 'Sin',
  },
  {
    'imagePath': 'assets/letters/syin.png',
    'subImage': 'assets/letters/samples/syin.png',
    'name': 'Syin',
  },
  {
    'imagePath': 'assets/letters/shod.png',
    'subImage': 'assets/letters/samples/shod.png',
    'name': 'Shod',
  },
  {
    'imagePath': 'assets/letters/dlod.png',
    'subImage': 'assets/letters/samples/dlod.png',
    'name': 'Dhod',
  },
  {
    'imagePath': 'assets/letters/tho.png',
    'subImage': 'assets/letters/samples/tho.png',
    'name': 'Tho',
  },
  {
    'imagePath': 'assets/letters/dzo.png',
    'subImage': 'assets/letters/samples/dzo.png',
    'name': 'Zho',
  },
  {
    'imagePath': 'assets/letters/ain.png',
    'subImage': 'assets/letters/samples/ain.png',
    'name': 'Ain',
  },
  {
    'imagePath': 'assets/letters/ghin.png',
    'subImage': 'assets/letters/samples/ghin.png',
    'name': 'Ghain'
  },
  {
    'imagePath': 'assets/letters/fa.png',
    'subImage': 'assets/letters/samples/fa.png',
    'name': 'Fa',
  },
  {
    'imagePath': 'assets/letters/qof.png',
    'subImage': 'assets/letters/samples/qof.png',
    'name': 'Qof',
  },
  {
    'imagePath': 'assets/letters/kaf.png',
    'subImage': 'assets/letters/samples/kaf.png',
    'name': 'Kaf'
  },
  {
    'imagePath': 'assets/letters/la.png',
    'subImage': 'assets/letters/samples/la.png',
    'name': 'Lam',
  },
  {
    'imagePath': 'assets/letters/ma.png',
    'subImage': 'assets/letters/samples/ma.png',
    'name': 'Mim',
  },
  {
    'imagePath': 'assets/letters/nun.png',
    'subImage': 'assets/letters/samples/nun.png',
    'name': 'Nun',
  },
  {
    'imagePath': 'assets/letters/wawu.png',
    'subImage': 'assets/letters/samples/wawu.png',
    'name': 'Waw',
  },
  {
    'imagePath': 'assets/letters/Hha.png',
    'subImage': 'assets/letters/samples/Hha.png',
    'name': 'Ha',
  },
  {
    'imagePath': 'assets/letters/ya.png',
    'subImage': 'assets/letters/samples/ya.png',
    'name': 'Ya',
  },
];

//FAMILY LIST
const familyList = [
  {
    'imagePath': 'assets/family/0.png',
    'name': 'الجد',
    'deskripsi':
        'Kakek, sosok lelaki yang telah meniti usia panjang, dipandang sebagai pilar keluarga yang memberikan kebijaksanaan, pengalaman hidup, dan nasihat berharga kepada generasi berikutnya, sementara juga menyajikan cinta yang tak terhingga.',
    'subtitle': 'Kakek / Eyang',
  },
  {
    'imagePath': 'assets/family/1.png',
    'name': 'الجدة',
    'deskripsi':
        'Nenek, wanita bijaksana dengan raut wajah yang dipenuhi oleh cerita masa lalu, menjadi tiang keluarga yang menyajikan kehangatan, kelembutan, serta kearifan bagi generasi berikutnya, sambil memberikan cinta yang tak terbatas.',
    'subtitle': 'Nenek / Oma',
  },
  {
    'imagePath': 'assets/family/2.png',
    'name': 'الأب',
    'deskripsi':
        'Ayah, memberikan kehadiran yang tangguh dan kasih sayang yang tak terkalahkan. Dengan kebijaksanaan dan dukungan tak terbatasnya, ia menjadi penuntun dan teladan bagi keluarga, menyediakan pelajaran berharga dan ketenangan dalam setiap langkah keluarga.',
    'subtitle': 'Ayah / Abi',
  },
  {
    'imagePath': 'assets/family/3.png',
    'name': 'الأم',
    'deskripsi':
        'Ibu, sosok yang penuh kasih dan ketabahan, adalah pilar kuat dalam keluarga. Dengan kelembutan dan pengorbanannya, ia memberikan cinta tak terhingga dan membimbing dengan bijaksana, memberikan inspirasi, dukungan, dan kehangatan yang tak tertandingi kepada setiap anggota keluarga.',
    'subtitle': 'Bunda / Ummi',
  },
  {
    'imagePath': 'assets/family/4.png',
    'name': 'العم/الخال',
    'deskripsi':
        'Paman, figur yang ceria dan menyenangkan, hadir dalam keluarga sebagai sumber kecerdasan, humor, dan inspirasi. Dengan kehangatan dan dukungan tak terbatasnya, ia memberikan nasihat bijak dan petualangan yang tak terlupakan kepada generasi muda, menjadikannya panutan dan teman yang berharga',
    'subtitle': 'Paman / Uncle',
  },
  {
    'imagePath': 'assets/family/5.png',
    'name': 'العمة/الخالة',
    'deskripsi':
        'Bibi, sebagai penjaga keceriaan dan kebijaksanaan dalam keluarga. Dengan senyumnya yang menyenangkan dan hati yang terbuka, ia memberikan dukungan tanpa syarat, cerita-cerita yang menginspirasi, dan bimbingan yang penuh cinta kepada keponakan-keponakannya, menjadikannya teladan yang menyenangkan dan perhatian.',
    'subtitle': 'Bibi / Aunty',
  },
  {
    'imagePath': 'assets/family/6.png',
    'name': 'الابن',
    'deskripsi':
        'Anak laki-laki, penerus generasi yang penuh semangat dan keberanian, hadir dengan keceriaan dan keingintahuan yang tak terbatas. Dengan kecerdasan dan tekad, ia mengeksplorasi dunia dengan rasa ingin tahu yang tak terbendung, membawa harapan dan kebahagiaan bagi keluarga.',
    'subtitle': 'Anak laki - laki',
  },
  {
    'imagePath': 'assets/family/7.png',
    'name': 'الابنة',
    'deskripsi':
        'Anak perempuan, cahaya yang membawa kebahagiaan dan kelembutan dalam keluarga. Dengan keanggunan dan kelembutan, ia memancarkan kecerdasan dan kebaikan, menjadi sumber kebanggaan dan cinta yang tak terbatas bagi orang tua dan keluarganya.',
    'subtitle': 'Anak Perempuan',
  },
  {
    'imagePath': 'assets/family/8.png',
    'name': 'ابن/ابنة العم',
    'deskripsi':
        'Keponakan, cahaya yang membawa keceriaan dan kebahagiaan dalam keluarga. Dengan kepolosan dan kehangatan, mereka menjadi sumber kebanggaan dan kasih sayang yang tak terhingga bagi keluarga.',
    'subtitle': 'Keponakan laki - laki / perempuan',
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
