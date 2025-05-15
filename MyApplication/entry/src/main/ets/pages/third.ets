import router from '@ohos.router';
import { common } from '@kit.AbilityKit';
import { buffer } from '@kit.ArkTS';
import { fileIo as fs, ReadOptions } from '@kit.CoreFileKit';
let include:string=''
let context = getContext(this) as common.UIAbilityContext;
let filesDir = context.filesDir;
let call=''
function read(str:string): string{
  let file = fs.openSync(filesDir + '/'+str, fs.OpenMode.READ_WRITE | fs.OpenMode.NONBLOCK);
  // // // 创建一个大小为1024字节的ArrayBuffer对象，用于存储从文件中读取的数据
  let arrayBuffer = new ArrayBuffer(1024000);
  // // 设置读取的偏移量和长度
  // // 读取文件内容到ArrayBuffer对象中，并返回实际读取的字节数
  let readLen = fs.readSync(file.fd, arrayBuffer);
  // // 将ArrayBuffer对象转换为Buffer对象，并转换为字符串输出
  let buf = buffer.from(arrayBuffer, 0, readLen);
  include=buf.toString();
  console.log('54250')
  fs.closeSync(file);
  return include;
}
interface ParamsObj{
  username:string
}
@Entry
@Component
struct Third {
  @State message: string = '';
  // 定义文本颜色的状态变量
  @State private textColor: string = "#2e2e2e";
  // 定义阴影边框颜色的状态变量
  @State private shadowColor: string = "#d5d5d5";
  // 定义基础内边距的状态变量
  @State private basePadding: number = 30;
  @State inputText: string = "";
  aboutToAppear():void{

    console.log(JSON.stringify(router.getParams()))
    const params = router.getParams() as ParamsObj
    this.message=params.username
    this.inputText=read(this.message)
  }
  build() {
    Column(){
      // 添加标题
      Text('简易文本编辑器')
        .fontColor(this.textColor) // 设置字体颜色
        .fontSize(18) // 设置字体大小
        .width('100%') // 设置宽度为100%
        .height(30) // 设置高度为50
        .textAlign(TextAlign.Center) // 设置文本居中对齐
        .backgroundColor(Color.White) // 设置背景色为白色
        .shadow({ // 设置阴影效果
          radius: 2, // 阴影半径
          color: this.shadowColor, // 阴影颜色
          offsetX: 0, // X轴偏移量
          offsetY: 5 // Y轴偏移量
        })
        .shadow({ // 设置阴影效果
        radius: 2, // 阴影半径
        color: this.shadowColor, // 阴影颜色
        offsetX: 0, // X轴偏移量
        offsetY: 5 // Y轴偏移量
      });


      Column(){
        Row() {
          Button()
          {
            Image($r('app.media.rebank')).width(40).height(40)
          }
            .fontColor("#5871ce") // 设置字体颜色
            .fontSize(16) // 设置字体大小
            .width(50) //宽度大、高度小
            .height(50)
            .borderRadius(20) //圆角是高度的一半
            .padding(`${this.basePadding / 2}lpx`) // 设置内边距
            .backgroundColor("#00000000") // 设置背景色
            .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 }) // 设置点击效果
            .onClick(() => { // 设置点击事件

              router.back({ url: 'pages/Index' })
            });


        }
        .height(45) // 设置高度
        .justifyContent(FlexAlign.Start) // 设置子项之间间距均匀分布
        .width('100%'); // 设置宽度
        Blank();
        Divider(); // 添加分割线
        Text(this.message)
          .fontColor(this.textColor) // 设置字体颜色
          .fontSize(18) // 设置字体大小
          .width('100%') // 设置宽度为100%
          .height(15) // 设置高度为50
          .textAlign(TextAlign.Center) // 设置文本居中对齐
          .backgroundColor(Color.White) // 设置背景色为白色
        Column() {


          TextArea({ text: $$this.inputText, placeholder: `已经到底了...` })
            .width(`${650 - this.basePadding * 2}lpx`) // 设置宽度
            .height(600) // 设置高度
            .fontSize(16) // 设置字体大小
            .caretColor(this.textColor) // 设置光标颜色
            .fontColor(this.textColor) // 设置字体颜色
            .margin({ top: `${this.basePadding}lpx` }) // 设置上边距
            .padding(0) // 设置内边距
            .backgroundColor(Color.Transparent) // 设置背景色
            .borderRadius(0) // 设置圆角
            .textAlign(TextAlign.JUSTIFY); // 设置文本两端对齐

        }.height("200%")
      }



    }


  }
}