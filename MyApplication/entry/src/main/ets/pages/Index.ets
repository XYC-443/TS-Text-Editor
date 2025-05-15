import { fileIo, fileIo as fs, ListFileOptions, ReadOptions, securityLabel } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
import { buffer } from '@kit.ArkTS';
import router from '@ohos.router';
import { access } from '@kit.ConnectivityKit';
import { BusinessError } from '@kit.BasicServicesKit';
// 获取应用文件路径
let include:string=''
let context = getContext(this) as common.UIAbilityContext;
let filesDir = context.filesDir;
let call:string=''



@Component
@CustomDialog
struct CustomDialogExample {
  private inputValue: string = ' ';
  cra: (val: string) => void = () => {
  };
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {
    Column() {
      Text('文件名').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '请输入文件名以创建'}).height(60).width('90%')
        .onChange((value:string) => {
          this.inputValue=value;
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
              this.cancel()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确定')
          .onClick(() => {
            if (this.controller != undefined) {
              this.cra(this.inputValue);
              this.controller.close()
              this.confirm()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }.borderRadius(10)
  }


}

@Component
@CustomDialog
struct OPEN {

  private inputValue: string = '';
  Value: (val: string) => void = () => {
  };
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {
    Column() {
      Text('文件名').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '请输入文件名进行编辑，删除或只读'}).height(60).width('90%')
        .onChange((value:string) => {
          this.inputValue=value;
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
              this.cancel()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确定')
          .onClick(() => {
            if (this.controller != undefined) {
              this.Value(this.inputValue);
              this.controller.close()
              this.confirm()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }.borderRadius(10)
  }


}

function createFile(name:string): void {
  // 文件不存在时创建并打开文件，文件存在时打开文件
  // let str:string=''
  let file = fs.openSync(filesDir + '/'+name, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  console.log(filesDir+'/'+name)

  call=name;
  fs.closeSync(file);
  // // 关闭文件
}
function all():void{

  // 查看文件列表
  let listFileOption: ListFileOptions = {
    recursion: false,
    listNum: 0,
  };
  let path:string=''
  let files = fs.listFileSync(filesDir, listFileOption);
  for (let i = 0; i < files.length; i++) {
    path=files[i]
    console.info(`The name of file: ${files[i]}`);
     path=filesDir+'/'+path
    // 如果文件可以使用

    if (filesDir.length <= 0) {
      return
    }
    try {
      fs.rmdir(path)

    } catch (error) {
      let err: BusinessError = error as BusinessError;
    }

  }
  AlertDialog.show(
    {
      title: '删除所有文件', //弹窗标题
      message:'文件已全部删除', //弹窗信息
      autoCancel: false, //点击遮障层时，是否关闭弹窗
      alignment: DialogAlignment.Center, //弹窗位置
      offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
      secondaryButton: { //次要按钮，位于右侧
        value: '确定',
        action: () => {
          console.log('确定')
        }
      },
      cancel: () => { //点击遮罩层取消时的回调
        console.info('Closed callbacks')
      }
    }
  )
}
function list():void
{
  // 查看文件列表
    let listFileOption: ListFileOptions = {
      recursion: false,
      listNum: 0,
    };
    let path:string=''
    let files = fs.listFileSync(filesDir, listFileOption);
    for (let i = 0; i < files.length; i++) {
      path+=files[i]+'\n'
      console.info(`The name of file: ${files[i]}`);

    }
  AlertDialog.show(
    {
      title: '查看所有文件', //弹窗标题
      message:path, //弹窗信息
      autoCancel: true, //点击遮障层时，是否关闭弹窗
      alignment: DialogAlignment.Center, //弹窗位置
      offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
      secondaryButton: { //次要按钮，位于右侧
        value: '确定',
        action: () => {
          console.log('确定')
        }
      },
      cancel: () => { //点击遮罩层取消时的回调
        console.info('Closed callbacks')
      }
    }
  )
}


function del(name:string): void
{
  let path:string=filesDir+'/'+name
  let st=name
  let i = 0
  console.log(path)
  // 如果文件可以使用
  let listFileOption: ListFileOptions = {
    recursion: false,
    listNum: 0,
  };
  let files = fs.listFileSync(filesDir, listFileOption);
  for (i = 0; i < files.length; i++) {
    console.log("@@@@@@@@@@@@@"+st)
if (st==files[i])
{

  try {
    fs.rmdir(path)
    AlertDialog.show(
      {
        title: '删除文件', //弹窗标题
        message:'删除成功', //弹窗信息
        autoCancel: false, //点击遮障层时，是否关闭弹窗
        alignment: DialogAlignment.Center, //弹窗位置
        offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
        secondaryButton: { //次要按钮，位于右侧
          value: '确定',
          action: () => {
            console.log('确定')
          }
        },
        cancel: () => { //点击遮罩层取消时的回调
          console.info('Closed callbacks')
        }
      }
    )
return

  } catch (error) {
    let err: BusinessError = error as BusinessError;
  }
}


  }

  AlertDialog.show(
    {
      title: '删除文件', //弹窗标题
      message:'删除失败，请检查文件名是否正确', //弹窗信息
      autoCancel: false, //点击遮障层时，是否关闭弹窗
      alignment: DialogAlignment.Center, //弹窗位置
      offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
      secondaryButton: { //次要按钮，位于右侧
        value: '确定',
        action: () => {
          console.log('确定')
        }
      },
      cancel: () => { //点击遮罩层取消时的回调
        console.info('Closed callbacks')
      }
    }
  )



}
function read(name:string): void {
  // 文件不存在时创建并打开文件，文件存在时打开文件
  try {
    let file = fs.openSync(filesDir + '/'+name, fs.OpenMode.READ_WRITE | fs.OpenMode.NONBLOCK);
    console.log(filesDir+'/'+name)
    router.pushUrl({
      url:'pages/third',
      params: {
        username:name
      }
    })
    AlertDialog.show(
      {
        title: '读取文件', //弹窗标题
        message:'该文件目前只支持可读权限，如需编辑请至菜单栏进行操作', //弹窗信息
        autoCancel: false, //点击遮障层时，是否关闭弹窗
        alignment: DialogAlignment.Center, //弹窗位置
        offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
        secondaryButton: { //次要按钮，位于右侧
          value: '我知道了',
          action: () => {
            console.log('确定')
          }
        },
        cancel: () => { //点击遮罩层取消时的回调
          console.info('Closed callbacks')
        }
      }
    )

    fs.closeSync(file);
  }catch (err) {
    console.error("打开文件出现错误：", err.code, err.message);
    if (err.code === "ENOENT") {
      AlertDialog.show(
        {
          title: '打开文件', //弹窗标题
          message:'打开文件时出现了未知错误', //弹窗信息
          autoCancel: true, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Center, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          secondaryButton: { //次要按钮，位于右侧
            value: '确定',
            action: () => {
              console.log('确定')
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
            console.info('Closed callbacks')
          }
        }
      )
    } else if (err.code === "EACCES") {
      AlertDialog.show(
        {
          title: '打开文件', //弹窗标题
          message:'没有权限打开该文件，请检查文件权限设置', //弹窗信息
          autoCancel: true, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Center, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          secondaryButton: { //次要按钮，位于右侧
            value: '确定',
            action: () => {
              console.log('确定')
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
            console.info('Closed callbacks')
          }
        }
      )
    } else {
      AlertDialog.show(
        {
          title: '打开文件', //弹窗标题
          message:'指定的文件不存在，请检查文件路径和文件名是否正确', //弹窗信息
          autoCancel: false, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Center, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          secondaryButton: { //次要按钮，位于右侧
            value: '确定',
            action: () => {
              console.log('确定')
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
            console.info('Closed callbacks')
          }
        }
      )
    }
  }

  // 关闭文件

}


//打开文件并读取
function open(name:string): void {
  // 文件不存在时创建并打开文件，文件存在时打开文件
  try {
    let file = fs.openSync(filesDir + '/'+name, fs.OpenMode.READ_WRITE | fs.OpenMode.NONBLOCK);
    console.log(filesDir+'/'+name)
    router.pushUrl({
      url:'pages/second',
      params: {
        username:name
      }
    })

    fs.closeSync(file);
  }catch (err) {
    console.error("打开文件出现错误：", err.code, err.message);
    if (err.code === "ENOENT") {
      AlertDialog.show(
        {
          title: '编辑文件', //弹窗标题
          message:'打开文件时出现了未知错误', //弹窗信息
          autoCancel: true, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Center, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          secondaryButton: { //次要按钮，位于右侧
            value: '确定',
            action: () => {
              console.log('确定')
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
            console.info('Closed callbacks')
          }
        }
      )
    } else if (err.code === "EACCES") {
      AlertDialog.show(
        {
          title: '编辑文件', //弹窗标题
          message:'没有权限打开该文件，请检查文件权限设置', //弹窗信息
          autoCancel: true, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Center, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          secondaryButton: { //次要按钮，位于右侧
            value: '确定',
            action: () => {
              console.log('确定')
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
            console.info('Closed callbacks')
          }
        }
      )
    } else {
      AlertDialog.show(
        {
          title: '编辑文件', //弹窗标题
          message:'指定的文件不存在，请检查文件路径和文件名是否正确', //弹窗信息
          autoCancel: false, //点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Center, //弹窗位置
          offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
          secondaryButton: { //次要按钮，位于右侧
            value: '确定',
            action: () => {
              console.log('确定')
            }
          },
          cancel: () => { //点击遮罩层取消时的回调
            console.info('Closed callbacks')
          }
        }
      )
    }
  }

  // 关闭文件

}


@Entry
@Component
struct First {
  // isShow1 和 isShow2 分别控制不同的半模态

  @State message: string = ' ';
  // 定义文本颜色的状态变量
  @State private textColor: string = "#2e2e2e";
  // 定义阴影边框颜色的状态变量
  @State private shadowColor: string = "#d5d5d5";
  // 定义基础内边距的状态变量
  @State private basePadding: number = 30;
  @State bianji: string = ' ';
  @State shanchu: string = ' ';
  @State zhidu: string = ' ';
  replace:CustomDialogController | null = new CustomDialogController({
    builder:OPEN({
      inputValue:this.bianji,
      Value:(val:string)=>{
        this.bianji=val;
        open(this.bianji)
        this.bianji=' '
      },
      cancel: () => {
        this.onCancel()
      },
      confirm: () => {
        this.onAccept()
      },
    })
  })

  look:CustomDialogController | null = new CustomDialogController({
    builder:OPEN({
      inputValue:this.shanchu,
      Value:(val:string)=>{
        this.shanchu=val;
        del(this.shanchu)
        this.shanchu=' '
      },
      cancel: () => {
        this.onCancel()
      },
      confirm: () => {
        this.onAccept()
      },
    })
  })

  READ:CustomDialogController | null = new CustomDialogController({
    builder:OPEN({
      inputValue:this.zhidu,
      Value:(val:string)=>{
        this.zhidu=val;
        read(this.zhidu)
        this.zhidu=' '
      },
      cancel: () => {
        this.onCancel()
      },
      confirm: () => {
        this.onAccept()
      },
    })
  })


    create: CustomDialogController | null =new CustomDialogController({
    builder: CustomDialogExample({
      cra: (val: string) => {
        this.message=val
        console.log('*******',this.message+'ggggg')
        if (this.message==' ')
        {
          AlertDialog.show(
            {
              title: '创建文件', //弹窗标题
              message:'文件创建失败', //弹窗信息
              autoCancel: false, //点击遮障层时，是否关闭弹窗
              alignment: DialogAlignment.Center, //弹窗位置
              offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
              secondaryButton: { //次要按钮，位于右侧
                value: '确定',
                action: () => {
                  console.log('确定')
                }
              },
              cancel: () => { //点击遮罩层取消时的回调
                console.info('Closed callbacks')
              }
            }
          )
          return
        }
        createFile(this.message)
        AlertDialog.show(
          {
            title: '创建文件', //弹窗标题
            message:'文件创建成功，地址为:'+filesDir+'/'+call, //弹窗信息
            autoCancel: false, //点击遮障层时，是否关闭弹窗
            alignment: DialogAlignment.Center, //弹窗位置
            offset: { dx: 0, dy: -20 }, //相对于弹窗位置的偏移量
            secondaryButton: { //次要按钮，位于右侧
              value: '确定',
              action: () => {
                console.log('确定')
              }
            },
            cancel: () => { //点击遮罩层取消时的回调
              console.info('Closed callbacks')
            }
          }
        )

      },
      cancel: () => {
        this.onCancel()
      },
      confirm: () => {
        this.onAccept()
      },

    }),
    cancel: this.exitApp,
    autoCancel: true,
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
      console.log("dialog onWillDismiss")
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss()
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss()
      }
    },
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
    cornerRadius: 10,
  })

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.create= null // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  exitApp() {
    console.info('Click the callback in the blank area')
  }
  // 定义监听输入文本变化的状态变量

  // 定义汉字数量的状态变量
  build() {
    // 创建一个列布局容器
    Column() {
      // 添加标题
      Text('简易文本编辑器')
        .fontColor(this.textColor) // 设置字体颜色
        .fontSize(18) // 设置字体大小
        .width('100%') // 设置宽度为100%
        .height(50) // 设置高度为50
        .textAlign(TextAlign.Center) // 设置文本居中对齐
        .backgroundColor(Color.White) // 设置背景色为白色
        .margin({ top: `${this.basePadding}lpx` }) // 设置上边距
        .shadow({ // 设置阴影效果
          radius: 2, // 阴影半径
          color: this.shadowColor, // 阴影颜色
          offsetX: 0, // X轴偏移量
          offsetY: 5 // Y轴偏移量
        });

      // 创建可滚动的容器
      Scroll() {
        // 在可滚动容器内部创建列布局
        Column() {
          // Tab布局
          Tabs() {
            // 首页Tab内容
            TabContent() {
              Column() {
                Swiper() {
                  Image($r('app.media.star'))
                  Image($r('app.media.pen'))
                  Image($r('app.media.back'))
                  Image($r("app.media.rc"))
                }
                .width('100%')
                .height(150)
                .autoPlay(true)
                .interval(2000)
                .padding(1)
                .border({ width: 1 })
                .margin(5)
                .indicator(
                  Indicator.dot()
                    .itemWidth(10)
                    .itemHeight(10)
                    .color(Color.Gray)
                    .selectedItemWidth(10)
                    .selectedItemHeight(10)
                    .selectedColor(Color.Black)
                );

                Column() {
                  Button()
                  {
                    Row(){

                      Image($r('app.media.chuangjian')).width(15).height(15).margin({ right:5 })
                      Text('创建文件').fontSize(18)

                    }
                  }
                    .borderRadius(5) // 设置圆角
                    .padding(`${this.basePadding / 2}lpx`) // 设置内边距
                    .width('80%')  // 必须设置 width
                    .height('10%')  // 每个按钮的高度设置为15%
                    .fontWeight(FontWeight.Bold)
                    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 }) // 设置点击效果
                    .margin({ top: 10 })

                    .onClick(() => {
                      if (this.create != null) {
                        this.create.open()
                      }
                    })
                    .backgroundColor('#87CEEB')
                    .fontColor(Color.White);

                  Blank();

                  Button()
                  {
                    Row(){
                      Image($r('app.media.bianji')).width(15).height(15).margin({ right:5 })
                      Text('编辑文件').fontSize(18)

                    }
                  }
                    .backgroundColor("#007FFF")
                    .borderRadius(5)
                    .padding(`${this.basePadding / 2}lpx`)
                    .width('80%')
                    .height('10%')
                    .fontWeight(FontWeight.Bold)
                    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })
                    .margin({ top: 10 })
                    .onClick(() => {
                      if (this.replace != null) {
                        this.replace.open()
                      }
                    })
                    .backgroundColor('#B0C4DE')
                    .fontColor(Color.White);

                  Blank();

                  Button()
                  {
                    Row(){
                      Image($r('app.media.zhidu')).width(15).height(15).margin({ right:5 })
                      Text('只读文件').fontSize(18)

                    }
                  }
                    .fontColor('skyblue')
                    .backgroundColor("#007FFF")
                    .borderRadius(5)
                    .padding(`${this.basePadding / 2}lpx`)
                    .width('80%')
                    .height('10%')
                    .fontWeight(FontWeight.Bold)
                    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })
                    .margin({ top: 10 })
                    .onClick(() => {
                      if (this.READ != null) {
                        this.READ.open()
                      }
                    })
                    .backgroundColor('#FF0000')
                    .fontColor(Color.White);

                  Blank();

                  Button()
                  {
                    Row(){
                      Image($r('app.media.shanchu')).width(15).height(15).margin({ right:5 })
                      Text('删除文件').fontSize(18)

                    }
                  }
                    .fontSize(18)
                    .borderRadius(5)
                    .padding(`${this.basePadding / 2}lpx`)
                    .width('80%')
                    .height('10%')
                    .fontWeight(FontWeight.Bold)
                    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })
                    .margin({ top: 10 })
                    .onClick(() => {
                      if (this.look != null) {
                        this.look.open()
                      }
                    })
                    .backgroundColor('#CD5C5C')
                    .fontColor(Color.White);

                  Blank();

                  Button()
                  {
                    Row(){
                      Image($r('app.media.chakan')).width(15).height(15).margin({ right:5 })
                      Text('查看所有文件').fontSize(18)

                    }
                  }
                    .fontColor('skyblue')
                    .fontSize(18)
                    .backgroundColor("#007FFF")
                    .borderRadius(5)
                    .padding(`${this.basePadding / 2}lpx`)
                    .width('80%')
                    .height('10%')
                    .fontWeight(FontWeight.Bold)
                    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })
                    .margin({ top: 10 })
                    .onClick(() => {
                      list()
                    })
                    .backgroundColor('#FFAC1C')
                    .fontColor(Color.White);

                  Blank();

                  Button()
                  {
                    Row() {
                      Image($r('app.media.qingkong')).width(15).height(15).margin({ right:5 })
                      Text('清空所有文件').fontSize(18)
                    }
                  }
                    .fontColor('skyblue')
                    .fontSize(18)
                    .backgroundColor("#007FFF")
                    .borderRadius(5)
                    .padding(`${this.basePadding / 2}lpx`)
                    .width('80%')
                    .height('10%')
                    .fontWeight(FontWeight.Bold)
                    .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })
                    .margin({ top: 10 })
                    .onClick(() => {
                      all()
                    });
                }

                .justifyContent(FlexAlign.Start)
                .alignItems(HorizontalAlign.Center)
                .width('100%') // 设置宽度为100%
                .height('auto') // 自适应高度
                .padding(`${this.basePadding}lpx`)
                .margin({ top: 5 })
                .borderRadius(10);
              }
            }.tabBar('首页')

            TabContent() {
              Column() {
                Row(){
                  Text('课程设计开始时间:')
                    .fontSize(20)
                  Blank()
                  Column(){
                    Text(' 2024年12月23日')
                      .fontSize(20)
                      .fontColor('#808080')
                  }

                }.justifyContent(FlexAlign.SpaceBetween)
                Divider()
                Blank()
                Row(){
                  Text('课程设计小组成员:')
                    .fontSize(20)
                  Blank()
                  Column(){
                    Text('曹庭恺')
                      .fontSize(20)
                      .fontColor('#808080')
                    Blank()
                    Text('戈冀增')
                      .fontSize(20)
                      .fontColor('#808080')
                    Blank()
                    Text('肖玉臣')
                      .fontSize(20)
                      .fontColor('#808080')
                    Blank()
                    Text('张通政')
                      .fontSize(20)
                      .fontColor('#808080')
                  }.justifyContent(FlexAlign.Center)

                }.justifyContent(FlexAlign.SpaceBetween)
                Divider()
                Blank()
                Row(){
                  Text('开发项目:    ')
                    .fontSize(20)
                  Blank()
                  Column(){
                    Text('简易文本编辑器')
                      .fontSize(20)
                      .fontColor('#808080')
                  }

                }.justifyContent(FlexAlign.SpaceBetween)
                Divider()
                Blank()
                Row(){
                  Text('实现功能:')
                    .fontSize(20)
                  Blank()
                  Column(){
                    Text('文件，字符串的增删查改')
                      .fontSize(20)
                      .fontColor('#808080')
                    Blank()
                    Text('UI界面设计')
                      .fontSize(20)
                      .fontColor('#808080')
                    Blank()
                    Text('硬件烧录与响应')
                      .fontSize(20)
                      .fontColor('#808080')
                    Blank()
                  }.justifyContent(FlexAlign.Center)

                }.justifyContent(FlexAlign.SpaceBetween)
                Divider()
                Blank()
                Row(){
                  Text('数据结构（部分）:')
                    .fontSize(20)
                  Blank()
                  Column(){
                    Text('KMP算法的查找和删除')
                      .fontSize(20)
                      .fontColor('#808080')
                  }.justifyContent(FlexAlign.Center)

                }.justifyContent(FlexAlign.SpaceBetween)
                Divider()
                Blank()
                Row(){
                  Text('硬件开发板型号:')
                    .fontSize(20)
                  Blank()
                  Column(){
                    Text(' Model:HH-SCDAYU200')
                      .fontSize(20)
                      .fontColor('#808080')
                    Text('  cpu:rk3568')
                      .fontSize(20)
                      .fontColor('#808080')
                    Text('  RAM:2GB LPDDR4X')
                      .fontSize(20)
                      .fontColor('#808080')
                  }.justifyContent(FlexAlign.Center)

                }.justifyContent(FlexAlign.SpaceBetween)

                Divider()
                Blank()
              }
              .alignItems(HorizontalAlign.Start) // 设置水平对齐方式
              .width('650lpx') // 设置宽度
              .height('650px')
              .padding(`${this.basePadding}lpx`) // 设置内边距
              .margin({ top: `${this.basePadding}lpx` }) // 设置外边距
              .borderRadius(10) // 设置圆角
              .backgroundColor(Color.White) // 设置背景色

            }.tabBar('详细信息')
          }

        }
        .justifyContent(FlexAlign.Start) // 调整为从顶部开始
        .width('100%') // 设置宽度为100%
        .height('80%') // 自动调整高度，确保所有按钮显示
        .padding(0) // 移除所有额外的内边距
        .margin(0); // 移除额外的外边距
      }

      .scrollBar(BarState.Off) // 关闭滚动条
      .clip(false); // 不裁剪超出部分
    }
    .justifyContent(FlexAlign.Start) // 强制顶部对齐
    .height('100%') // 设置高度为100%
    .width('100%') // 设置宽度为100%
    .backgroundColor("#f4f8fb"); // 设置背景色
  }
  // pageTransition() {
  //   // 定义页面进入时的效果，从左侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
  //   PageTransitionEnter({ duration: 250 })
  //     .scale({ x: 0, y: 0 })  // 从中心缩放到原始大小
  //     .translate({ x: 0, y: 0 })  // 保持初始位置
  //   // 定义页面退出时的效果，相对于正常页面位置x方向平移100vp，y方向平移100vp，透明度变为0，时长为1000ms，无论页面栈发生push还是pop操作均可生效
  //
  //
  // }
  @Builder
  sheetBuilder1() {
    Column() {
      Text('半模态 1')
        .fontSize(40)
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }

  @Builder
  sheetBuilder2() {
    Column() {
      Text('半模态 2')
        .fontSize(40)
    }
    .backgroundColor(Color.Orange)
    .width('100%')
    .height('100%')
  }


}