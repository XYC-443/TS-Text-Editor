import router from '@ohos.router';
import { common } from '@kit.AbilityKit';
import fileio from '@ohos.fileio';
import { fileIo, fileIo as fs, ReadOptions } from '@kit.CoreFileKit';

let context = getContext(this) as common.UIAbilityContext;
let filesDir = context.filesDir;
function read(str:string): string{
  let text:string=fileio.readTextSync(filesDir + '/'+str,{encoding:'utf-8'})
  console.log('gxxt ',text)
  return text;
}
function baocun(str:string,name:string): string{
  let file = fs.openSync(filesDir + '/'+name, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  fs.truncateSync(filesDir + '/'+name);
  // 写入一段内容至文件
  let writeLen = fs.writeSync(file.fd, str);
  fileio.readText(filesDir + '/'+name).then((data) => {
    str=data;
  })
  fs.closeSync(file);
  console.log('经过保存后的数据为'+str)
  return str

}
@CustomDialog
@Component


struct CustomDialogExample {
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
      Text('输入').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '输入字符以进行查找,命名或删除'}).height(60).width('90%')
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
@CustomDialog
struct replace {
  private inputValue: string = '';
  private place: string = '';
  Value: (val: string,val1:string) => void = () => {
  };
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }
  build() {
    Column() {
      Text('输入').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '请输入想要替换的字符'}).height(70).width('90%')
        .margin({top:20})
        .onChange((value:string) => {
          this.inputValue=value;
        })

      TextInput({ placeholder: '请输入替换后的字符'}).height(70).width('90%')
        .margin({ top: 20 })
        .onChange((val1:string) => {
          this.place=val1;
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
              this.Value(this.inputValue,this.place);
              this.controller.close()
              this.confirm()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }.borderRadius(10)
  }
}

// interface ParamsObj{
//   name:string
// }
@CustomDialog
struct INSERT {
  private inputValue: string = '';
  private place: string = '';
  Value: (val: string,val1:string) => void = () => {
  };
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }
  build() {
    Column() {
      Text('插入位置').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '请输入想要操作的字符'}).height(70).width('90%')
        .margin({top:20})
        .onChange((value:string) => {
          this.inputValue=value;
        })

      TextInput({ placeholder: '请输入插入的字符'}).height(70).width('90%')
        .margin({ top: 20 })
        .onChange((val1:string) => {
          this.place=val1;
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
              this.cancel()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('前面')
          .onClick(() => {
            if (this.controller != undefined) {
              this.Value(this.inputValue,this.place+this.inputValue);
              this.controller.close()
              this.confirm()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
        Button('后面')
          .onClick(() => {
            if (this.controller != undefined) {
              this.Value(this.inputValue,this.inputValue+this.place);
              this.controller.close()
              this.confirm()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Blue)
      }.margin({ bottom: 10 })
    }.borderRadius(10)
  }
}

interface ParamsObj{
  username:string
}

@Entry
@Component

struct NumberToChineseConverter {




  // 定义一个状态变量，存储示例数字字符串
  @State private exampleNumber: string = '我们所完成的项目设计叫:\n简易文本编辑器\n我们的小组成员有:\n2307014119 张通政\n2307014114 肖玉臣\n2307014115 曹庭恺\n2307014135 戈冀增';
  // 定义文本颜色的状态变量
  @State private textColor: string = "#2e2e2e";
  // 定义阴影边框颜色的状态变量
  @State private shadowColor: string = "#d5d5d5";
  // 定义基础内边距的状态变量
  @State private basePadding: number = 30;
  // 定义汉字数量的状态变量
  @State private newlineCount: string = "0";
  // 定义英文字符数量的状态变量
  @State private englishCharCount: string = "0";
  // 定义数字数量的状态变量
  @State private spaceCount: string = "0";
  // 定义总字符数的状态变量
  @State private charTotalCount: string = "0";
  @State  inputValue: string = '';
  @State  inreplace: string = '';
  @State  str: string = '';
  @State @Watch('inputChanged') inputText: string = "";

  aboutToAppear():void{

    console.log(JSON.stringify(router.getParams()))
    const params = router.getParams() as ParamsObj
    this.str=params.username
    this.inputText=read(this.str);
    console.log('传过来的参数为'+params.username)
  }

  replace:CustomDialogController | null = new CustomDialogController({
    builder:replace({
      inputValue:this.inputValue='',
      Value:(val:string,val1:string)=>{
        if (val==''||val1=='') {
          return
        }
        this.inputValue = val;
        this.inreplace=val1;


        let result: string = "";
        let index: number = 0;
        let isReplaced: boolean = false;  // 用于标识是否替换成功
        while (index < this.inputText.length) {
          let foundIndex: number = this.inputText.indexOf(this.inputValue, index);
          if (foundIndex === -1) {
            result += this.inputText.slice(index);
            break;
          }
          isReplaced = true;  // 只要进入了替换流程，就标记为替换成功
          result += this.inputText.slice(index, foundIndex);
          result += this.inreplace;
          index = foundIndex + this.inputValue.length;
        }

        if (isReplaced) {
          this.inputText=result;
        } else {
          AlertDialog.show(
            {
              title: '替换', //弹窗标题
              message:'不存在要查找的内容', //弹窗信息
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



      },
      cancel: () => {
        this.onCancel()
      },
      confirm: () => {
        this.onAccept()
      },
    })
  })
  insert:CustomDialogController | null = new CustomDialogController({
    builder:INSERT({
      inputValue:this.inputValue='',
      Value:(val:string,val1:string)=>{
        if (val==''||val1=='') {
          return
        }
        this.inputValue = val;
        this.inreplace=val1;


        let result: string = "";
        let index: number = 0;
        let isReplaced: boolean = false;  // 用于标识是否替换成功
        while (index < this.inputText.length) {
          let foundIndex: number = this.inputText.indexOf(this.inputValue, index);
          if (foundIndex === -1) {
            result += this.inputText.slice(index);
            break;
          }
          isReplaced = true;  // 只要进入了替换流程，就标记为替换成功
          result += this.inputText.slice(index, foundIndex);
          result += this.inreplace;
          index = foundIndex + this.inputValue.length;
        }

        if (isReplaced) {
          this.inputText=result;
        } else {
          AlertDialog.show(
            {
              title: '插入', //弹窗标题
              message:'不存在要插入的内容', //弹窗信息
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



      },
      cancel: () => {
        this.onCancel()
      },
      confirm: () => {
        this.onAccept()
      },
    })
  })

  statistics: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      inputValue: this.inputValue='',
      Value: (val: string) => {
        // 如果输入的目标字符串为空，直接返回
        if (val == '') {
          return;
        }
        this.inputValue = val;

        // 初始化用于记录匹配位置的数组
        let positions: number[][] = []; // 每个元素包含所在行数、出现次数、起始字符位置以及结束字符位置
        let matchProgress: number = 0; // 当前匹配进度（已匹配到目标字符串中的第几个字符）
        let currentRow: number = 1; // 当前行数
        let occurrenceCountInRow: number = 0; // 目标字符串在当前行出现的次数
        let totalOccurrences: number = 0; // 总的匹配次数

        // 遍历输入文本的每一个字符
        for (let index: number = 0; index < this.inputText.length; index++) {
          const currentChar: string = this.inputText[index];

          // 遇到换行符时，更新行数并重置当前行内目标字符串出现次数
          if (currentChar === '\n') {
            currentRow++;
            occurrenceCountInRow = 0;
            continue;
          }

          // 判断当前字符是否与目标字符串中正在匹配的字符相等
          if (this.inputValue[matchProgress] === currentChar) {
            matchProgress++;

            // 当匹配进度达到目标字符串长度时，说明找到了一次完整的目标字符串匹配
            if (matchProgress === this.inputValue.length) {
              occurrenceCountInRow++;
              totalOccurrences++;

              // 记录此次匹配的起始字符位置
              let startPosition = index - this.inputValue.length + 1;

              // 记录此次匹配的结束字符位置
              let endPosition = index;

              // 将匹配信息添加到positions数组中
              positions.push([currentRow, occurrenceCountInRow, startPosition, endPosition]);

              // 重置匹配进度，继续查找下一次出现的位置
              matchProgress = 0;
            }
          } else {
            // 如果不匹配，重置匹配进度
            matchProgress = 0;
          }
        }

        // 格式化结果为字符串
        let resultText: string = `目标字符串出现的行数,次数及开始位置和结束位置:\n`;
        positions.forEach((position, i) => {
          resultText += `匹配 ${i + 1}: 行号 ${position[0]}, 次数 ${position[1]}, 起始位置 ${position[2]}, 结束位置 ${position[3]}\n`;
        });
        resultText += `\n总的匹配次数: ${totalOccurrences}`;

        // 显示弹窗展示结果
        AlertDialog.show({
          title: '统计', // 弹窗标题
          message: resultText, // 弹窗信息
          autoCancel: true, // 点击遮障层时，是否关闭弹窗
          alignment: DialogAlignment.Center, // 弹窗位置
          offset: { dx: 0, dy: -20 }, // 相对于弹窗位置的偏移量
          secondaryButton: { // 次要按钮，位于右侧
            value: '确定',
            action: () => {
              console.log('确定');
            }
          },
          cancel: () => { // 点击遮罩层取消时的回调
            console.info('Closed callbacks');
          }
        });
      },
      cancel: () => {
        this.onCancel(); // 取消按钮点击事件
      },
      confirm: () => {
        this.onAccept(); // 确认按钮点击事件
      },
    })
  })
  delete: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      inputValue: this.inputValue='',
      Value: (val: string) => {
          if (val=='') {
            return
          }
        this.inputValue = val;

        // 验证输入
        if (!this.inputText || typeof this.inputText !== 'string') {
          console.error('inputText 必须是字符串');
          return;
        }
        if (!this.inputValue || typeof this.inputValue !== 'string') {
          console.error('inputValue 必须是字符串');
          return;
        }

        // 边界条件处理
        if (this.inputValue === "") {
          console.log("输入值为空字符串");
          return;
        }

        try {
          const positions = this.kmpSearch(this.inputText, this.inputValue);
          if (positions.length > 0) {
            console.log("找到了匹配的字符串，位置分别为：", positions);
            this.inputText = this.removeOccurrences(this.inputText, this.inputValue);
          } else {
            AlertDialog.show({
              title: '删除', // 弹窗标题
              message: "非法删除", // 弹窗信息
              autoCancel: false, // 点击遮障层时，是否关闭弹窗
              alignment: DialogAlignment.Center, // 弹窗位置
              offset: { dx: 0, dy: -20 }, // 相对于弹窗位置的偏移量
              secondaryButton: { // 次要按钮，位于右侧
                value: '确定',
                action: () => {
                  console.log('确定');
                }
              },
              cancel: () => { // 点击遮罩层取消时的回调
                console.log('Closed callbacks');
              }
            });
            console.log("未找到匹配的字符串");
          }
        } catch (error) {
          console.error('发生错误:', error);
        }
      },
      cancel: () => {
        this.onCancel();
      },
      confirm: () => {
        this.onAccept();
      },
    })
  });

  // KMP算法实现
  kmpSearch(text: string, pattern: string): number[] {
    const positions: number[] = [];
    const lps = this.computeLPSArray(pattern);
    let i = 0; // index for text
    let j = 0; // index for pattern

    while (i < text.length) {
      if (pattern[j] === text[i]) {
        i++;
        j++;
      }

      if (j === pattern.length) {
        positions.push(i - j);
        j = lps[j - 1];
      } else if (i < text.length && pattern[j] !== text[i]) {
        if (j !== 0) {
          j = lps[j - 1];
        } else {
          i++;
        }
      }
    }

    return positions;
  }

  computeLPSArray(pattern: string): number[] {
    const lps: number[] = new Array(pattern.length).fill(0); // 显式指定 lps 数组的类型为 number[]
    let length = 0;
    let i = 1;

    while (i < pattern.length) {
      if (pattern[i] === pattern[length]) {
        length++;
        lps[i] = length;
        i++;
      } else {
        if (length !== 0) {
          length = lps[length - 1];
        } else {
          lps[i] = 0;
          i++;
        }
      }
    }

    return lps;
  }
  removeOccurrences(text: string, pattern: string): string {
    let result = '';
    let i = 0;
    const patternLength = pattern.length;

    while (i < text.length) {
      if (text.substring(i, i + patternLength) === pattern) {
        i += patternLength;
      } else {
        result += text[i];
        i++;
      }
    }

    return result;
  }


  //查找
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      inputValue: this.inputValue='',
      Value: (val: string) => {

        if (val=='') {
          return
        }
        this.inputValue = val;

        // KMP算法：构建LPS（最长前后缀）表 //
        const buildLPS = (pattern: string): number[] =>
        {
          let lps: number[] = Array(pattern.length).fill(0);// 初始化LPS数组，长度为模式串的长度，初始值为0
          let length = 0;// 当前匹配的前缀长度
          let i = 1;// i用于遍历模式串，从第二个字符开始
          while (i < pattern.length)// 遍历模式串的每个字符
          {
            if (pattern[i] === pattern[length])// 如果模式串的当前字符与前缀位置的字符匹配
            {
              length++;  // 增加前缀长度
              lps[i] = length;  // 将当前字符的LPS值设为当前前缀长度
              i++;  // 继续比较下一个字符
            }
            else
            {
              if (length !== 0)  // 如果字符不匹配
              {
                length = lps[length - 1];// 如果当前前缀长度不为0，则回退到上一个可能的前缀长度
              }
              else
              {
                lps[i] = 0; // 如果前缀长度为0，说明没有任何匹配，直接将LPS[i]设为0，并继续遍历
                i++;
              }
            }
          }
          return lps;// 返回构建好的LPS数组
        };

        // KMP 算法：进行模式匹配 //
        const KMP = (text: string, pattern: string) =>
        {
          const lps = buildLPS(pattern); // 构建模式串的LPS（最长前后缀）数组
          let positions: number[] = []; // 初始化一个空数组，用于存储匹配的位置
          let i = 0; // 文本指针
          let j = 0; // 模式串指针
          let matchCount = 0; // 用于记录匹配次数的计数器
          // 遍历整个文本
          while (i < text.length)
          {
            if (pattern[j] === text[i]) // 如果当前字符匹配，移动指针
            {
              i++; // 文本指针向前移动
              j++; // 模式串指针向前移动
            }
            if (j === pattern.length) // 如果模式串指针达到了模式串的末尾，表示匹配成功
            {
              positions.push(i - j); // 记录匹配的起始位置（i - j）
              matchCount++; // 增加匹配计数
              j = lps[j - 1]; // 使用LPS表回退到合适的位置，继续尝试匹配
            }
            else if (i < text.length && pattern[j] !== text[i])
            {
              if (j !== 0) // 如果字符不匹配且模式串指针不为0，则根据LPS表回退
              {
                j = lps[j - 1]; // 使用LPS表跳过已匹配的部分
              }
              else
              {
                i++; // 如果模式串指针为0，文本指针向前移动
              }
            }
          }
          return positions;// 返回所有匹配的位置
        };

        // 执行KMP算法进行匹配 //
        let positions = KMP(this.inputText, this.inputValue);

        // 弹窗显示匹配结果 //
        let resultText: string = positions.length > 0
          ? `找到了匹配的字符串，次数为: ${positions.length}`
          : "文中不存在要查找的内容";

        // 显示弹窗 //
        this.showAlertDialog('查找', resultText);
      },
      cancel: () =>
      {this.onCancel();},
      confirm: () =>
      {this.onAccept();}
    }),
    cancel: this.exitApp,  // 取消操作时，调用 exitApp 方法（通常退出应用或关闭对话框）
    autoCancel: true,  // 设置为 true，表示点击对话框外部区域时会自动取消（关闭对话框）
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {  // 在对话框即将关闭时触发的回调函数
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason));  // 打印关闭对话框的原因
      console.log("dialog onWillDismiss");  // 打印“对话框将要关闭”的日志信息

      // 判断对话框关闭的原因是否是按返回键或点击外部区域
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK || dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE)
      {
        dismissDialogAction.dismiss();  // 如果是按返回键或点击外部区域，执行对话框关闭操作
      }
    },
    alignment: DialogAlignment.Bottom,  // 设置对话框的位置为底部对齐
    offset: { dx: 0, dy: -20 },  // 设置对话框相对于其默认位置的偏移量，dy 为 -20，表示向上偏移 20 像素
    gridCount: 4,  // 设置对话框内容的网格列数为 4
    customStyle: false,  // 设置是否使用自定义样式，false 表示不使用
    cornerRadius: 10,  // 设置对话框的圆角半径为 10，表示对话框的角落有圆滑效果
  });

  // 显示弹窗的通用方法 //
  private showAlertDialog(title: string, message: string) {
    AlertDialog.show({
      title: title, // 弹窗标题
      message: message, // 弹窗信息
      autoCancel: true, // 点击遮障层时，是否关闭弹窗
      alignment: DialogAlignment.Center, // 弹窗位置设置为居中
      offset: { dx: 0, dy: -20 }, // 设置弹窗的偏移量，dy 为向上偏移20像素
      secondaryButton: { // 次要按钮（一般为确认按钮）
        value: '确定', // 按钮文字
        action: () => {
          console.log('确定');
        }
      },
      cancel: () => {
        console.info('Closed callbacks'); // 点击遮罩层取消时的回调
      }
    });
  }

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
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


  // 当输入文本发生变化时调用的方法
  inputChanged() {
    // 初始化计数器

    let newline = 1; // 汉字数量
    // let chinesePunctuation = 0; // 中文标点数量
    let englishChars = 0; // 英文字符数量
    let space = 0; // 数字数量
    let count = 0; // 总字符数
    // 遍历输入文本的每个字符
    for (let i = 0; i < this.inputText.length; i++) {
      let char = this.inputText.charAt(i); // 获取当前字符
      count++; // 计数器加一
      // 如果字符是空格，则数字计数器加一
      if (char==' ') {
        space++;
      }
      // 如果字符是换行，则换行计数器加一
      if (char=='\n') {
        newline++;
      }
      // 如果字符是英文字符或英文标点，则英文字符计数器加一
      if ((char>='A'&&char<='Z')||(char>='a'&&char<='z')) {
        englishChars++;
      }
    }
    count=count-newline+1;
    // 更新状态变量
    this.newlineCount = `${newline}`;
    this.englishCharCount = `${englishChars}`;
    this.spaceCount = `${space}`;
    this.charTotalCount = `${count}`;
  }

  // 构建UI界面的方法
  build() {
    // 创建一个列布局容器
    Column() {

      // 创建可滚动的容器
      Scroll() {
        // 在可滚动容器内部创建列布局
        Column() {
          // 添加标题
          Text('简易文本编辑器')
            .fontColor(this.textColor) // 设置字体颜色
            .fontSize(18) // 设置字体大小
            .width('100%') // 设置宽度为100%
            .height(50) // 设置高度为50
            .textAlign(TextAlign.Center) // 设置文本居中对齐
            .backgroundColor(Color.White) // 设置背景色为白色
            .shadow({ // 设置阴影效果
              radius: 2, // 阴影半径
              color: this.shadowColor, // 阴影颜色
              offsetX: 0, // X轴偏移量
              offsetY: 5 // Y轴偏移量
            });
          Column() {
            Row() {
              Text('示例')
                .fontColor("#5871ce") // 设置字体颜色
                .fontSize(16) // 设置字体大小
                .padding(`${this.basePadding / 2}lpx`) // 设置内边距
                .backgroundColor("#f2f1fd") // 设置背景色
                .borderRadius(5) // 设置圆角
                .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 }) // 设置点击效果
                .onClick(() => { // 设置点击事件
                  this.inputText = this.exampleNumber; // 将示例文本赋值给输入框
                });
              Blank(); // 添加空白间隔

              Text('查找')

                  .fontColor("red")//设置颜色
                  .fontSize(16)
                  .padding(`${this.basePadding / 2}lpx`)// 设置内边距
                  .backgroundColor('#f2f1fe')
                  .borderRadius(0)// 设置圆角
                  .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })// 设置点击效果
                  .onClick(() => {


                    if (this.dialogController != null) {
                      this.dialogController.open()

                    }

                  })

              Blank();
              Text('删除')
                .fontColor("red")//设置颜色
                .fontSize(16)
                .padding(`${this.basePadding / 2}lpx`)// 设置内边距
                .backgroundColor('#f2f1fe')
                .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })// 设置点击效果
                .onClick(() => {
                  if (this.delete != null) {
                    this.delete.open()
                  }
                })


              Blank();
              Text('替换')
                .fontColor("black")//设置颜色
                .fontSize(16)
                .padding(`${this.basePadding / 2}lpx`)// 设置内边距
                .backgroundColor('#f2f1fe')
                .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })// 设置点击效果
                .onClick(() => {
                  if (this.replace != null) {
                    this.replace.open()
                  }
                })
              Blank();
              Text('统计')
                .fontColor("blue")//设置颜色
                .fontSize(16)
                .padding(`${this.basePadding / 2}lpx`)// 设置内边距
                .backgroundColor('#f2f1fe')
                .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 })// 设置点击效果
                .onClick(() => {
                  if (this.statistics != null) {
                    this.statistics.open()
                  }
                })
              Blank();
              Text('清空')
                .fontColor("#e48742") // 设置字体颜色
                .fontSize(16) // 设置字体大小
                .padding(`${this.basePadding / 2}lpx`) // 设置内边距
                .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 }) // 设置点击效果
                .backgroundColor("#ffefe6") // 设置背景色
                .borderRadius(5) // 设置圆角
                .onClick(() => { // 设置点击事件
                  this.inputText = ""; // 清空输入框
                });
            }
            .height(45) // 设置高度
            .justifyContent(FlexAlign.SpaceBetween) // 设置子项之间间距均匀分布
            .width('100%'); // 设置宽度
            Blank();
            Divider(); // 添加分割线
            // 添加文本输入区域
            TextArea({ text: $$this.inputText, placeholder: `请输入内容` })
              .width(`${650 - this.basePadding * 2}lpx`) // 设置宽度
              .height(380) // 设置高度
              .fontSize(16) // 设置字体大小
              .caretColor(this.textColor) // 设置光标颜色
              .fontColor(this.textColor) // 设置字体颜色
              .margin({ top: `${this.basePadding}lpx` }) // 设置上边距
              .padding(0) // 设置内边距
              .backgroundColor(Color.Transparent) // 设置背景色
              .borderRadius(0) // 设置圆角
              .textAlign(TextAlign.JUSTIFY); // 设置文本两端对齐
            Row(){
              Text('取消')
                .fontColor("red") // 设置字体颜色
                .fontSize(16) // 设置字体大小
                .padding(`${this.basePadding / 2}lpx`) // 设置内边距
                .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 }) // 设置点击效果
                .backgroundColor("#ffefe6") // 设置背景色
                .borderRadius(5) // 设置圆角
                .onClick(() => { // 设置点击事件
                  router.back({ url: 'pages/Index' })
                });
              Blank();
              Text('插入')
                .fontColor("blue") // 设置字体颜色
                .fontSize(16) // 设置字体大小
                .padding(`${this.basePadding / 2}lpx`) // 设置内边距
                .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 }) // 设置点击效果
                .backgroundColor("#ffefe6") // 设置背景色
                .borderRadius(5) // 设置圆角
                .onClick(() => { // 设置点击事件
                  if (this.insert != null) {
                    this.insert.open()
                  }
                });
              Blank()
              Text('保存')
                .fontColor("blue") // 设置字体颜色
                .fontSize(16) // 设置字体大小
                .padding(`${this.basePadding / 2}lpx`) // 设置内边距
                .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.8 }) // 设置点击效果
                .backgroundColor("#ffefe6") // 设置背景色
                .borderRadius(5) // 设置圆角
                .onClick(() => { // 设置点击事件
                  baocun(this.inputText,this.str)
                  router.back({
                    url:'pages/Index',
                  })
                });
            }.height(45) // 设置高度
            .justifyContent(FlexAlign.SpaceBetween) // 设置子项之间间距均匀分布
            .width('100%'); // 设置宽度
            Blank()
          }
          // 设置样式
          .alignItems(HorizontalAlign.Start) // 设置水平对齐方式
          .width('650lpx') // 设置宽度
          .padding(`${this.basePadding}lpx`) // 设置内边距
          .margin({ top: `${this.basePadding}lpx` }) // 设置外边距
          .borderRadius(10) // 设置圆角
          .backgroundColor(Color.White) // 设置背景色
          .shadow({ // 设置阴影效果
            radius: 10, // 阴影半径
            color: this.shadowColor, // 阴影颜色
            offsetX: 0, // X轴偏移量
            offsetY: 0 // Y轴偏移量
          });


          // 添加统计结果展示
          Column() {
            // 汉字数量
            Row() {
              Text() {
                Span(`行数：`)
                Span(`${this.newlineCount} `).fontColor(Color.Red) // 汉字数量以红色显示
                Span('行')
              }
              .fontColor(this.textColor) // 设置字体颜色
              .fontSize(16) // 设置字体大小
              .layoutWeight(1); // 设置布局权重
            }
            .constraintSize({ minHeight: 45 }) // 设置最小高度
            .justifyContent(FlexAlign.SpaceBetween) // 设置子项之间间距均匀分布
            .width('100%'); // 设置宽度
            Divider(); // 添加分割

            // 英文字符数量
            Row() {
              Text() {
                Span(`英文：`)
                Span(`${this.englishCharCount} `).fontColor(Color.Red) // 英文字符数量以红色显示
                Span('个')
                Span('（含英文状态下的数字、符号、标点）').fontSize(13) // 附加说明
              }
              .fontColor(this.textColor) // 设置字体颜色
              .fontSize(16) // 设置字体大小
              .layoutWeight(1); // 设置布局权重
            }
            .constraintSize({ minHeight: 45 }) // 设置最小高度
            .justifyContent(FlexAlign.SpaceBetween) // 设置子项之间间距均匀分布
            .width('100%'); // 设置宽度
            Divider(); // 添加分割线
            // 空格数量
            Row() {
              Text() {
                Span(`空格：`)
                Span(`${this.spaceCount} `).fontColor(Color.Red) // 数字数量以红色显示
                Span('个')
              }
              .fontColor(this.textColor) // 设置字体颜色
              .fontSize(16) // 设置字体大小
              .layoutWeight(1); // 设置布局权重
            }
            .constraintSize({ minHeight: 45 }) // 设置最小高度
            .justifyContent(FlexAlign.SpaceBetween) // 设置子项之间间距均匀分布
            .width('100%'); // 设置宽度
            Divider(); // 添加分割线
            // 总字符数
            Row() {
              Text() {
                Span(`字数：`)
                Span(`${this.charTotalCount} `).fontColor(Color.Red) // 总字符数以红色显示
                Span('个字')
              }
              .fontColor(this.textColor) // 设置字体颜色
              .fontSize(16) // 设置字体大小
              .layoutWeight(1); // 设置布局权重
            }
            .constraintSize({ minHeight: 45 }) // 设置最小高度
            .justifyContent(FlexAlign.SpaceBetween) // 设置子项之间间距均匀分布
            .width('100%'); // 设置宽度
          }
          // 设置样式
          .alignItems(HorizontalAlign.Start) // 设置水平对齐方式
          .width('650lpx') // 设置宽度
          .padding(`${this.basePadding}lpx`) // 设置内边距
          .margin({ top: `${this.basePadding}lpx` }) // 设置外边距
          .borderRadius(10) // 设置圆角
          .backgroundColor(Color.White) // 设置背景色
          .shadow({ // 设置阴影效果
            radius: 10, // 阴影半径
            color: this.shadowColor, // 阴影颜色
            offsetX: 0, // X轴偏移量
            offsetY: 0 // Y轴偏移量
          });
        }
      }
      .scrollBar(BarState.Off) // 关闭滚动条
      .clip(false); // 不裁剪超出部分，这里是允许内部组件阴影可以向父布局外扩散
    }
    .height('100%') // 设置高度为100%
    .width('100%') // 设置宽度为100%
    .backgroundColor("#f4f8fb"); // 设置背景色
  }

}