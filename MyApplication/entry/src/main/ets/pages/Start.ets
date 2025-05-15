import router from '@ohos.router';
import font from '@ohos.font';

@Entry
@Component
struct Start {

  @State message: string = '文本编辑器';
  @State animate: boolean = false;
  @State opacityValue: number = 0; // 组件透明度
  @State Value: number = 0; // 组件透明度
  @State fontColor: ResourceColor = '#0094ff';
  @State fontWeight: number = 100;
  @State fonts: string[] =['欢迎使用', '我们的', '文本编辑器','现在','请开始你的','文本编辑之旅','简易文本编辑器'] ;
  @State number:number=0;
  // 计时器
  private opacityTimer: number | undefined;
  private Timer: number | undefined;
  aboutToAppear() {
    font.registerFont({
      familyName: 'medium',
      familySrc: '/font/medium.ttf' // font文件与pages目录同级
    });
    this.startOpacityAnimation()
    this.start()
  }
  // 启动透明度动画
  startOpacityAnimation() {
    let increasing = false; // 记录透明度是否在增大

    // 使用 setInterval 来周期性更新透明度
    this.opacityTimer = setInterval(() => {

      if (increasing) {
        this.opacityValue += 0.05; // 增加透明度
        if (this.opacityValue >=1) { // 透明度达到最大值时，开始减小


          if (this.number <this.fonts.length)
          {
            increasing = false;
         //  this.stopOpacityAnimation()
          }
        }
      } else {
        this.opacityValue -= 0.05; // 减少透明度
        if (this.opacityValue <= 0) { // 透明度达到最小值时，开始增大
          increasing = true;
          if (this.number < this.fonts.length)
          {
            this.number++;
          }

        }
      }
    }, 70); // 每50ms更新一次
  }

  //
  start() {
    let increasing = false; // 记录透明度是否在增大

    // 使用 setInterval 来周期性更新透明度
    this.Timer = setInterval(() => {

      if (increasing) {
        this.Value += 0.05; // 增加透明度
        if (this.Value >=1) { // 透明度达到最大值时，开始减小

      increasing = false;
            //  this.stopOpacityAnimation()

        }
      } else {
        this.Value -= 0.05; // 减少透明度
        if (this.Value <= 0) { // 透明度达到最小值时，开始增大
          increasing = true;

        }
      }
    }, 70); // 每50ms更新一次
  }

  // 页面消失时停止透明度动画
  // stopOpacityAnimation() {
  //   if (this.opacityTimer !== undefined) {
  //     clearInterval(this.opacityTimer); // 清除计时器
  //     this.opacityTimer = undefined;
  //   }
  // }

  build() {
    Stack() {
      Image($r('app.media.fengmian'))
        .width('100%') // 设置图片宽度为父容器宽度的100%
        .height('120%') // 设置图片高度为父容器高度的100%
        .objectFit(ImageFit.Cover); // 设置图片适应方式为覆盖整个容器，保持图片比例

      Column() {
        // 第一部分: 居中显示的文本编辑器
        Column() {
          Text(this.fonts[this.number-1])
            .fontFamily('medium') // medium：注册自定义字体的名字
            .fontSize(80)
            .textAlign(TextAlign.Center)
            .fontWeight(FontWeight.Bold)
            .opacity(this.opacityValue) // 设置动画透明度

        }
        .width('30%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .margin({top:5})

        // 第二部分: 底部的文本
        Column() {
          Text('点击任意处以继续......')
            .fontFamily('medium') // medium：注册自定义字体的名字
            .textAlign(TextAlign.Center)
            .fontSize(30)
            .margin(-60)
          .opacity(this.Value) // 设置动画透明度
        }
      }
      .justifyContent(FlexAlign.Center) // 让整个 Column 垂直居中
      .onClick(() => {

        router.pushUrl({
          url: 'pages/Index',
        });
      })
      .height('100%') // 填满全屏
      .width('100%');

      // 页面加载时启动透明度动画

    }
  }

  // 页面退出时的效果
  pageTransition() {
    PageTransitionExit({ duration: 500 })
      .translate({ x: 0, y: 0 })  // 保持初始位置
      .scale({ x: 0, y: 0 });  // 从中心缩放到原始大小
  }
}