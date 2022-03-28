/* 图片资源规范

images: 图片文件
目录：放至对应的一级模块目录下面
   一级模块：common (公共)   home (首页)   community (社区)   life (生活)   mine (我的)   
命名：#业务模块_#功能_(#状态)_#类型
   业务模块：以社区模块为例，如group (圈子)、topic (话题)、content (动态)，
           要注意无需包含一级模块home/home_car_agree_icon.png ❌    home/car_agress_icon.png  ✅
   功能：如 liked (点赞)、post (发布)
   状态 (可选)：
   ● 颜色：dark (暗色)、light (亮色)
   ● 选中：unselected、selected
   ● 可用：enabled、disabled
   ● 圆形：circle
   ● 其他情况以此类比
   类型：背景图以_bg结尾，其他以_icon结尾
适配：2倍图存放至 images/模块目录，3倍图放至 images/模块目录/3.0x
压缩：建议下载完图片后进行压缩，以尽可能的减小包体积
   推荐工具：腾讯智图 https://zhitu.isux.us/，TinyPng https://tinypng.com/
   图片格式：超过200K的图片，以及写死的背景图、Banner图，蓝湖上的切图格式选择JPG，再进行压缩
其他：无用的文件注意删除，经常看到的一个现象是拖进来图片后，发现可能存在相同图片，
   就用了已有的定义，但重复图片并未删除。
*/

library asset_images;

part 'empty_images.g.dart';

class LocalImages {
  /// 空态
  static _EmptyImages empty = _EmptyImages();
}
