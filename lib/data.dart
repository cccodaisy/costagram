import 'package:costagram/models/story_model.dart';
import 'package:costagram/models/user_model.dart';

final User user = User(
  name: 'John Doe',
  profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
);
final List<Story> stories = [
  Story(
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 10),
    user: user,
  ),
  Story(
    url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
    media: MediaType.image,
    user: User(
      name: 'John Doe',
      profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
    ),
    duration: const Duration(seconds: 7),
  ),
  Story(
    url:
    'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    user: user,
  ),
  Story(
    url:
    'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
    user: user,
  ),
  Story(
    url:
    'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
    media: MediaType.video,
    duration: const Duration(seconds: 0),
    user: user,
  ),
  Story(
    url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
    media: MediaType.image,
    duration: const Duration(seconds: 8),
    user: user,
  ),
];

// img: https://img.thesaracen.com/banner/eae9f237b2ea7d4abb9d12b7e7210b0e.jpg​
// video: https://img.thesaracen.com/banner/cc25353e9e3bb3ab93e209b5e89e0765.mp4​
// title: 21% 쿠폰​
// mainCopy: 다시돌아온 대박쿠폰
// subCopy: 21% 쿠폰받고 장바구니 탈탈 털어버리세요!
// color: #e5e5e5
// link: https://thesaracen.com/event/coupon
// ​
// ​
// img: https://img.thesaracen.com/banner/acae076395169a14c5006de22f5c7bfb.jpg​
// video: https://img.thesaracen.com/banner/b1aec65ad1850710bfc198a9fed4f439.mp4​
// title: ▼ 이주의 NEW 신상 ▼​
// mainCopy: ▼ 이주의 NEW 신상 ▼
// subCopy: ♥이주의 네일템들 만나보세요♥
// color: #e5e5e5
// link: https://thesaracen.com/event/detail/1901
// ​
// ​
// img: https://img.thesaracen.com/banner/5943eb37dafa22045969dc58eb4a736f.jpg​
// video: https://img.thesaracen.com/banner/e129f8cac867ffb00c3d6a21d0263b89.mp4​
// title: 영롱한 보라빛 파우더!​
// mainCopy: 영롱한 보라빛 파우더!
// subCopy: 사라프렌즈 보라보라 파우더
// color: #a6acbc
// link: https://thesaracen.com/goods/221769
// ​
// ​
// img: https://img.thesaracen.com/banner/77c8873fa34800b680ca0a1ac492b15c.jpg​
// video: https://img.thesaracen.com/banner/8037dea53c393341fd67fcbbd01500f9.mp4​
// title: 예쁜 빛을 모두모두 모아​
// mainCopy: 예쁜 빛을 모두모두 모아
// subCopy: 리틀 머메이드 파우더 5종
// color: #C8C3C7
// link: https://thesaracen.com/goods/221905
// ​
// ​
// img: https://img.thesaracen.com/banner/0f049afb757e6e5873dd7029ee320c66.jpg​
// video: ​
// title: <한.정.수.량> BU-003 티눈 비트 3종 세트 ​
// mainCopy: <한.정.수.량> BU-003 티눈 비트 3종 세트
// subCopy: 인기 폭발해서 다시와썹! 부쉬 비트 세트
// color: #C8C3C7
// link: https://thesaracen.com/goods/209980
// ​
// ​
// img: https://img.thesaracen.com/banner/abb8534776928dccfaa988b07200d361.jpg​
// video: ​
// title: 나..띵콥 좋아하네..득템 찬스 SALE 79%!!!​
// mainCopy: 나..띵콥 좋아하네..득템 찬스 SALE 79%!!!
// subCopy: <띵크오브네일> 득템 찬스!! 9,900원 레고레고~
// color: #EAEAEA
// link: https://thesaracen.com/goods/222124