本项目是基于TS编程的“简易文本编辑器”，主要可实现文本的输入、输出、查找、删除等功能。
main code存放位置：MyApplication Pro max pro\MyApplication\entry\src\main\ets\pages









简易文本编辑器


目  录
1. 内容提要	4
1.1 项目主题	4
2. 设计内容	4
2.1 文件操作	4
2.2 UI界面的设计	4
2.3 文本编辑功能	4
2.4 OpenHarmony开发板上的运行	4
3. 本设计所使用的数据结构	4
3.1 KMP算法（The Knuth-Morris-Pratt Algorithm）	4
3.1.1 查找	4
3.1.2 删除	5
3.2 顺序表（Sequence List）	5
3.2.1 文件读取	5
3.2.2 删除和插入	5
4. 功能模块详细设计	5
4.1 文件功能	5
4.1.1 创建文件	5
4.1.2 编辑文件	6
4.1.3 只读文件	7
4.1.4 删除文件	8
4.1.5 查看所有文件	11
4.1.6 清空所有文件	13
4.2 文本编辑功能	16
4.2.1 查找文本	16
4.2.2 删除文本	20
4.2.3 替换文本	26
4.2.4 插入文本	29
4.2.5 统计文本	32
4.3 UI界面设计	36
4.3.1 初始界面	36
4.3.2 导航栏	38
4.3.3 轮播图	40
4.4 运行在OpenHarmony开发板	41
5. 程序整体流程	42
参考文献	42

1.
内容提要
1.1 项目主题
设计一个简单好用的文本编辑器，能够实现文本文件的创建功能和对文本的编辑和保存，能够有效执行用户想要执行的内容，并为用户提供可视化和简便的文本操作。
2.设计内容
2.1 文件操作
文件操作包括但不局限于文件是创建与打开；文件的读取与写入，文件的修改与关闭，文件的正确存盘和取盘。
2.2 UI界面的设计
包括优化操作流程，弹窗，警告提示以及更接近用户的个性化服务，切合用户的个人需求，符合大多数用户对UI界面的印象，使文本编辑器界面更加自然和有条有理。
2.3 文本编辑功能
简易文本编辑器内设示例，查找，删除，替换，清空，插入等诸多用户所需功能，可满足一般用户的日常生活需要，操作灵活，且容易上手。
2.4 OpenHarmony开发板上的运行
简易文本编辑器通过连接OpenHarmony开发板，实现文本编辑器在硬件板上的正确运行，保障用户能够通过开发板实现个性化操作而不需要模拟器。通过在真机上的运行，能够更一步检测软件功能，更加符合生活实际。
3.本设计所使用的数据结构
3.1 KMP算法（The Knuth-Morris-Pratt Algorithm）
3.1.1 查找
KMP算法的时间复杂度为O(m*n),通过获取查找字符串的next值，通过next的值移动对应字符串使其成功匹配。并继续查找操作，最终返回次数。
3.1.2 删除
KMP算法在这段代码中的核心作用是高效地在字符串中查找子串的位置，并与业务逻辑结合，用于判断输入的合法性以及执行后续的子串删除操作。通过 KMP 的引入，代码在处理字符串匹配问题时能够兼顾效率和准确性。
3.2 顺序表（Sequence List）
3.2.1 文件读取
由于顺序表是基于数组的因此可以快速地通过索引访问任意位置的元素，并将被访问文件中的字符串传至编辑器进行编辑，该过程的时间复杂度为O(1)。
3.2.2 删除和插入
顺序表在删除和插入中的作用主要体现在两个方面： 
·用于存储匹配结果（positions 数组）。
·用于存储部分匹配信息（lps 数组）和最终处理结果（result 字符串）。

4.功能模块详细设计
4.1 文件功能
4.1.1 创建文件
·详细设计思想
·核心功能：文件创建与管理
1、文件操作：
使用 fs.openSync() 方法尝试打开或创建指定的文件。如果文件不存在，则根据传入的 fs.OpenMode.CREATE 模式创建文件。如果文件存在，则根据传的fs.OpenMode.READ_WRITE模式以读写模式打开文件。文件路径由 “filesDir+name”拼接而成，确保文件路径的动态生成。调用 fs.closeSync(file) 关闭文件句柄，防止资源泄漏。
2、用户交互：弹窗提示
弹窗组件设计：使用 AlertDialog.show()进行模块化设计
反馈机制：成功创建文件后，通过弹窗反馈操作结果，告知用户文件已成功创建，并显示文件的具体路径。
消息内容：通过 message 属性展示文件路径，增强用户的直观体验。
位置与样式：设置 alignment 为 DialogAlignment.Center，将弹窗居中展。通过 offset 属性调整弹窗的位置偏移，以优化视觉布局。按钮交互：提供一个“确定”按钮，绑定 action 回调函数用于确认操作。

·核心代码
function createFile(name:string):
void {
  // 文件不存在时创建并打开文件，文件存在时打开文件
  // let str:string=''
  let file = fs.openSync(filesDir + '/'+name, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  console.log(filesDir+'/'+name)

  call=name;
  fs.closeSync(file);
  // // 关闭文件
}
createFile(this.message)
4.1.2 编辑文件
·详细设计思想
·核心功能：文件操作与用户界面操作
1、文件操作
文件打开与读取：通过 let file = fs.openSync(文件地址+名字, 操作文件方式)获取文件地址，并尝试打开文件，并进行后续的读写。
文件编辑逻辑：如果文件不存在，通过if-else语句判断err.code出现的问题及原因： "ENOENT"--'打开文件时出现了未知错误'或是 "EACCES"--'没有权限打开该文件，请检查文件权限设置'。若文件可以正常打开，则通过router.pushUrl语句进行页面跳转，跳转到“编辑文件”的页面，进行查找、删除、替换等操作。
文件关闭：使用 fs.closeSync() 及时关闭文件句柄，释放资源，避免文件句柄泄漏。
·核心代码
function open(name:string): void {
  // 文件不存在时创建并打开文件，文件存在时打开文件
  try {
    let file = fs.openSync(filesDir + '/'+name, fs.OpenMode.READ_WRITE     | fs.OpenMode.NONBLOCK);
    console.log(filesDir+'/'+name)
    router.pushUrl({
      url:'pages/second',
      params: {
        username:name
      }
    })
    fs.closeSync(file);
  }
  } // 关闭文件
}

4.1.3 只读文件
·详细设计思想
·核心功能：文件操作与用户界面操作
1、文件操作
文件打开与读取：通过 let file = fs.openSync(文件地址+名字, 操作文件方式)获取文件地址，并尝试打开文件，并进行只读文件。
文件读取逻辑：如果文件不存在，通过if-else语句判断err.code出现的问题及原因：若文件可以正常打开，则通过router.pushUrl语句进行页面跳转，跳转到“编辑文件”的页面，进行文件只读。
文件关闭：使用 fs.closeSync() 及时关闭文件句柄，释放资源，避免文件句柄泄漏。
2、用户界面交互
触发条件：当 fs.openSync() 抛出异常（如文件不存在或路径错误）时触发弹窗。通过 title 明确告知用户当前操作为“只读文件”。展示提示消息“指定的文件不存在，请检查文件路径和文件名是否正确”。
如果文件打开成功，使用 router.pushUrl语句跳转到跳转到“只读文件”的页面，提示消息“该文件目前只支持可读权限，如需编辑请至菜单栏进行操作”。

·核心代码
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
 
    fs.closeSync(file);
  }

4.1.4 删除文件
·详细设计思想
这段代码的核心目的是删除指定文件，并根据删除操作的结果通过弹窗提示用户。以下是代码的详细设计思想及分析：
·核心功能：文件操作与用户界面操作
1、文件操作
文件打开与读取：通过let path: string = filesDir + '/' + name 动态构建待删除文件的完整路径，其中 filesDir 是目录路径，name 是待删除文件的名称。
文件存在性检查：使用 fs.listFileSync(filesDir, listFileOption) 列出 filesDir 目录下的文件。listFileOption 配置中设置了 recursion: false，表明不进行递归查找文件。listNum: 0 表示返回所有文件，结果存储在 files 数组中。使用 for 循环遍历文件列表，查找与传入的文件名 name 相匹配的文件。

2、用户界面交互
如果文件被成功删除，通过 AlertDialog.show() 展示弹窗，提示用户“删除成功”。如果没有找到匹配的文件，或者文件删除失败，弹出提示框，显示“删除失败，请检查文件名是否正确”。
弹窗包括：
title: 设置弹窗标题为“删除文件”。
message: 设置弹窗信息为“删除成功”。
secondaryButton: 设置“确定”按钮，点击后执行相应回调。

·核心代码
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

4.1.5 查看所有文件
·详细设计思想
这段代码的主要功能是列出指定目录中的所有文件，并通过弹窗展示给用户。以下是其详细设计思想：
·核心功能：文件列表展示
1、文件操作
文件列表获取：使用 fs.listFileSync 方法列出 filesDir 目录下的文件。配置 ListFileOptions：recursion: false：表示不进行递归，只列出当前目录下的文件。listNum: 0：表示列出目录中所有文件，而不限制数量。将文件名存储到 files 数组中，便于后续处理。
文件路径拼接：使用一个字符串 path 存储文件名列表，并在每个文件名后追加换行符 \n，以便弹窗中展示每个文件名占一行。
2、用户交互：弹窗展示
弹窗设计：
标题：设置为“查看所有文件”，清晰指明弹窗的功能和用途。
内容：将拼接的文件名列表 path 作为 message 属性的值，展示在弹窗中，供用户查看。
交互控制：autoCancel: true：允许用户点击遮罩层关闭弹窗，提升交互体验。secondaryButton：提供“确定”按钮，供用户主动关闭弹窗。绑定按钮的 action 回调，记录用户的点击操作。
弹窗位置与样式：alignment: DialogAlignment.Center：将弹窗居中展示，确保视觉居中。offset: { dx: 0, dy: -20 }：调整弹窗的显示位置，使其稍微偏离中心，优化布局。

·核心代码
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

4.1.6 清空所有文件
·详细设计思想
该模块的主要功能是删除指定目录下的所有文件，并在操作完成后通过弹窗提示用户。以下是代码的详细设计思想：
1. 获取文件列表
使用 fs.listFileSync() 方法列出 filesDir 目录中的文件。ListFileOptions 的配置：recursion: false：仅列出当前目录的文件，不递归子目录。listNum: 0：列出目录中所有文件，没有数量限制。文件名存储在 files 数组中，用于后续处理。
2. 文件删除逻辑
遍历文件列表：每次从 files 中取出一个文件名，并拼接成完整路径：filesDir + '/' + path。
删除操作：路径有效性检查：如果 filesDir 长度为 0，直接返回，防止对非法目录进行操作。使用 fs.rmdir() 删除文件。
3. 用户反馈：弹窗展示
当所有文件处理完毕后，显示弹窗告知用户文件已全部删除，标题：设置为“删除所有文件”。内容：显示“文件已全部删除”。
交互控制：autoCancel: false：用户必须通过点击按钮关闭弹窗。按钮：“确定”按钮：绑定操作回调并记录日志。遮罩层点击取消：绑定取消回调并记录关闭操作。

·核心代码
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

4.2 文本编辑功能
4.2.1 查找文本
·详细设计思想
该代码的主要目标是通过KMP 算法在用户输入的文本中查找指定的模式串（子字符串），并显示匹配结果。具体设计思想可以分为以下几部分：
1、用户交互模块
用户输入：inputValue: 用户输入的模式串（要查找的内容）。inputText: 用户提供的文本（被搜索的内容）。用户确认输入后，执行子字符串查找逻辑。
弹窗交互：匹配结果通过弹窗的形式反馈给用户。用户可以选择确认或取消操作。使用 CustomDialogExample 来实现弹窗组件，支持动态输入和交互操作。提供 cancel 和 confirm 回调方法：取消：调用 onCancel()，允许用户退出操作。
确认：调用 onAccept()，用于进一步操作。
2、KMP 算法的实现细节
(1) 构建 LPS 表
针对模式串，计算每个字符位置的前后缀最大长度。提供一个回退机制，在匹配失败时快速跳转到合适位置。初始化一个长度为模式串的数组 lps，初始值为 0。使用两个指针：i: 当前处理的字符。length: 当前前缀的匹配长度。遍历模式串：如果字符匹配，更新 lps 数组值，并移动指针。如果字符不匹配，使用 LPS 表回退，直到找到可能的匹配位置或将 length 置为 0。
(2) KMP 匹配过程
在文本中寻找模式串的所有匹配位置。使用 LPS 表优化回退操作，减少重复匹配的耗时。实现步骤：初始化两个指针：i: 文本中的当前字符位置。j: 模式串的当前字符位置。遍历文本：如果字符匹配，同时移动两个指针。如果字符不匹配：如果模式串指针 j 不为 0，根据 LPS 表跳转到新的匹配位置。如果 j 为 0，则仅移动文本指针。如果匹配到模式串末尾，记录匹配起始位置，并根据 LPS 表更新 j 的位置。返回所有匹配位置的数组 positions。
3、 结果展示模块
将匹配结果通过弹窗形式展示给用户。提供明确的结果信息：如果找到匹配，显示匹配次数。如果未找到，提示“文中不存在要查找的内容”。
利用匹配结果 positions，动态生成结果文本：匹配次数通过 positions.length 计算。若 positions 为空，直接提示未找到匹配。调用 showAlertDialog() 显示结果弹窗。

·核心代码
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
})

4.2.2 删除文本
·详细设计思想
这段代码实现了一个通过KMP 算法查找并删除指定子字符串的功能。主要设计思想可以从以下几个方面进行分析：
1. 用户交互与验证模块
通过弹窗接收用户输入，用户输入的是待删除的字符串（inputValue）。用户输入值进行校验，验证输入是否符合预期：字符串类型和非空。如果输入无效，进行错误提示或退出操作。
弹窗通过 CustomDialogExample 构造，提供输入框让用户输入。用户确认输入后，执行 Value 函数逻辑，验证 inputText 和 inputValue 的类型。输入值为空或类型不符合预期时，进行错误提示并停止操作。若输入有效，进行进一步的查找和删除操作。
2. 删除条件与错误处理
输入校验：验证 inputText 和 inputValue 是否为字符串，避免类型错误。
检查输入值是否为空字符串，避免无效操作。
错误捕获：在执行查找和删除操作时，使用 try...catch 捕获潜在错误，确保代码稳定。
在进行字符串处理前进行充分的输入验证，避免不必要的错误。若在 KMP 查找过程中未找到匹配内容，弹出提示框告知用户“非法删除”。
3. KMP 算法模块
（1）KMP 算法： 使用 KMP（Knuth-Morris-Pratt）算法高效地在文本中查找模式串。kmpSearch 函数：执行模式匹配，返回所有匹配的起始位置。computeLPSArray 函数：构建模式串的 LPS（最长前缀后缀）数组，以便在匹配失败时跳过部分重复匹配，优化查找过程。
（2）KMP 算法流程：计算 LPS 数组：通过 computeLPSArray 函数计算模式串的最长前后缀匹配信息，以便在匹配过程中跳过重复的字符。查找匹配： kmpSearch 函数使用 LPS 数组帮助文本与模式串进行匹配，返回所有匹配的起始位置。匹配成功：若有匹配，继续进行字符串的删除操作。匹配失败：若没有匹配，弹出提示框提示用户删除操作无效。
（3）LPS 数组的作用：LPS 数组记录了模式串每个位置的最长前后缀长度，能够帮助算法在匹配失败时跳过已经匹配过的部分，避免重复检查，提高匹配效率。LPS 数组有效地将时间复杂度降低至 O(n + m)，其中 n 为文本长度，m 为模式串长度。
4. 删除操作模块
删除匹配的子字符串： 如果通过 KMP 算法找到匹配项，删除所有匹配的子字符串。removeOccurrences 函数： 遍历文本，删除所有匹配的子串，返回新的文本。
字符串遍历删除： removeOccurrences 通过循环遍历文本，将所有匹配的模式串删除，并构建新的文本。删除过程中：每次发现模式串匹配时，跳过模式串的字符。未匹配的字符添加到结果字符串中。
效率与稳定性：通过 substring 比较文本片段的方式，简化了删除逻辑。
在删除过程中不改变原始文本的结构，保证了操作的正确性。
5. 弹窗与结果反馈模块
若匹配成功，删除所有匹配的子字符串后更新 inputText 并返回结果。
若匹配失败，弹出提示框告知用户删除无效。
成功删除：删除操作完成后，更新 inputText，使用户能够看到删除后的结果。操作提示：若未找到匹配项，通过 AlertDialog 弹窗反馈给用户“非法删除”信息。

·核心代码
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

4.2.3 替换文本
·详细设计思想
这段代码实现了一个 字符串替换功能，用户通过输入一个待替换字符串和替换后的字符串，在目标文本中执行替换操作。以下是代码设计思想的详细分析：
1、用户交互与输入校验模块
用户通过弹窗输入：val: 待查找和替换的字符串。val1: 替换后的字符串。对用户输入的值进行校验，确保输入合法性：输入不能为空。输入的 val 和 val1 必须为字符串。
使用 CustomDialogController 生成替换弹窗，通过 Value 回调函数接收用户输入。校验用户输入，避免空字符串或非法值导致的无效操作。
2、替换逻辑模块
在 inputText 中查找所有匹配的 inputValue（待替换字符串），并替换为 inreplace（替换后的字符串）。遍历整个字符串，确保多次出现的匹配字符串都能被替换。如果未找到匹配项，弹出提示框告知用户。
替换逻辑：使用 indexOf 查找待替换字符串在目标文本中的位置。将查找到的部分替换为目标字符串，并调整索引继续查找剩余部分。若未找到匹配项，直接终止替换并弹出提示框。
高效性：避免逐字符遍历，而是利用字符串的 indexOf 方法高效查找匹配位置。使用 slice 方法分割字符串并拼接新内容，保证操作直观且性能稳定。
替换成功标记：通过布尔变量 isReplaced 记录是否完成过替换，用于后续判断是否需要弹窗提示。
3. 弹窗反馈模块
替换成功后更新文本内容，无需额外提示。替换失败时，通过 AlertDialog 弹窗反馈信息，提示用户不存在待替换的内容。
成功反馈：替换成功直接更新 inputText，无需提示，优化用户体验。失败反馈：使用 AlertDialog 显示标题为“替换”的弹窗，提示用户“不存在要查找的内容”。弹窗支持按钮交互，提供次要按钮和取消操作。

·核心代码
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

4.2.4 插入文本
·详细设计思想
这段代码实现了在指定字符串前插入内容的功能，用户通过输入 待查找的字符串和插入的内容，在目标文本中插入内容。以下是代码的详细设计思想：
1、用户交互与输入校验模块
用户通过弹窗输入两个值：val: 待查找的目标字符串。val1: 插入到目标字符串前的内容。对输入值进行合法性校验，避免无效或错误操作：校验输入值不能为空。校验值的类型是否为字符串。
弹窗设计：使用 CustomDialogController 创建一个插入操作的弹窗，调用 Value 回调获取用户输入。输入校验：判断 val 和 val1 是否为空，若为空则直接返回，避免继续执行无意义操作。
2、插入逻辑模块
在目标文本 inputText 中查找所有与 val 匹配的字符串，并在其前插入 val1 的内容。如果未找到 val，提示用户不存在目标字符串。
匹配与插入：遍历 inputText，使用 indexOf 查找目标字符串的起始位置。每次找到匹配的目标字符串，在其前拼接插入内容 val1。调整索引继续查找，确保多次出现的目标字符串都被处理。
无匹配处理：通过标志位 isReplaced 判断是否执行了插入操作。若未找到匹配项，使用弹窗提示用户“不存在要插入的内容”。高效实现：使用 slice 分割字符串并拼接插入内容，减少遍历次数，保证性能。
3、反馈模块
插入成功后，更新目标文本 inputText，无需额外提示。
插入失败时，弹出提示框告知用户原因。
插入成功：替换后的结果存储在变量 result 中，最后赋值给 inputText，不需要额外提示，直接完成操作。
插入失败：使用 AlertDialog 显示“插入”的弹窗，提示用户目标字符串不存在。弹窗提供确定按钮，支持用户确认后关闭。

·核心代码
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

4.2.5 统计文本
·详细设计思想
这段代码实现了目标字符串统计功能，通过遍历文本内容，统计目标字符串的 行号、出现次数及其在每行中的起始和结束位置，并以弹窗形式展示统计结果。以下是代码的详细设计思想：
1、输入校验模块
检查用户输入是否有效：确保用户提供了非空的目标字符串（val）。
如果输入为空，直接返回，避免执行后续无意义操作。
用户通过弹窗输入目标字符串。使用简单的 if (val == '') 条件检查输入有效性，确保代码安全性。
2、数据结构设计
使用合适的数据结构记录统计结果：positions: 存储每次匹配的详细信息，包括：行号（currentRow）目标字符串在当前行出现的次数匹配起始位置和结束位置其他辅助变量：matchProgress: 当前匹配进度，记录已匹配的目标字符串长度。currentRow: 当前行号，用于分行处理。occurrenceCountInRow: 当前行内目标字符串出现的次数。totalOccurrences: 统计目标字符串在整个文本中的总匹配次数。
用数组记录多个匹配项的详细信息（便于后续格式化展示）。使用简单的计数变量跟踪匹配次数和当前行号。
3、字符匹配逻辑
遍历目标文本 inputText，逐字符检查是否与目标字符串 inputValue 匹配。如果匹配成功，记录相关统计信息并重置匹配进度。
逐字符遍历：遍历整个文本，按字符处理，支持多行文本的解析。逐字符匹配：使用 matchProgress 跟踪目标字符串的匹配进度。完全匹配目标字符串后，将当前匹配的信息（行号、位置）记录到 positions 数组。
换行符处理：遇到换行符时更新行号并重置当前行的匹配次数。
4、结果格式化与展示
格式化统计结果为清晰的文本字符串，展示以下信息：匹配的行号。匹配次数及其起始和结束位置。总的匹配次数。使用弹窗展示统计结果，方便用户查看。
格式化文本：遍历 positions 数组，将每次匹配的信息转化为人类可读的描述。添加总匹配次数作为总结。弹窗展示：使用 AlertDialog 显示统计结果：标题设置为“统计”。内容为格式化的统计结果。提供确定按钮和遮罩层关闭支持，增强用户交互体验。
5、弹窗交互设计
提供确认按钮，让用户关闭弹窗。支持点击遮罩层关闭弹窗的功能。
通过 AlertDialog 配置按钮回调：确定按钮触发日志记录（如 console.log）。取消按钮触发自定义关闭回调。

·核心代码
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

4.3 UI界面设计
4.3.1 初始界面
·详细设计思想
调用一个计时器，为要操作的文字添加透明度变量监控，用于记录透明度是否增大，若是，则在透明度达到最大后将变量改至相反状况，进行透明度的减小，并记录此时字符串数组的索引下标，每次透明度减少至0，则访问下一个数组元素，并再一次显示和隐去，直至数组中的所有字符被显示完毕停止。
·核心代码
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
  }, 70); // 每70ms更新一次
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
  }, 70); // 每70ms更新一次
}

4.3.2 导航栏
·详细设计思想
在进行应用界面开发时，利用 ArkUI 框架所自带的导航栏模板能够极大地提升开发效率并确保导航栏的稳定性与兼容性。具体的操作步骤如下：从 ArkUI 的组件库中准确地找到导航栏模板，并将其完整地添加至该页面的代码结构之中。在添加过程中，要确保所有相关的依赖项和配置都已正确设置，以保证导航栏能够正常地渲染和工作。完成上述步骤后，只需运行项目，即可顺利地完成导航栏 UI 的创建和生成，为用户提供便捷、美观且功能完善的导航体验，进一步提升整个应用的用户界面友好度和操作便捷性。
·核心代码
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

4.3.3 轮播图
·详细设计思想
创建列组件，在ArkUI组件库中得到轮播图的展示模版，并将想要展示的图片添加至项目文件。最后在代码框架中添加导入好的图片的名称，再次点击运行，即可实现轮播图的创建和生成。
·核心代码
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
  )

4.4 运行在OpenHarmony开发板
简易文本编辑器通过连接OpenHarmony开发板，实现文本编辑器在硬件板上的正确运行，保障用户能够通过开发板实现个性化操作而不需要模拟器。通过在真机上的运行，能够更一步检测软件功能，更加符合生活实际。
本次在OpenHarmony开发板上的运行环境为：Harmony5.1.0
5.程序整体流程

参考文献
[1] 李云清，杨庆红.数据结构（C语言版）.北京：人民邮电出版社，2004.
[2] 严蔚敏，吴伟民.数据结构（C语言版）.北京：清华大学出版.1997.
[3] 苏光奎，李春葆.数据结构导学.北京:清华大学出版.2002.
[4] 周海英，马巧梅，靳雁霞.数据结构与算法设计.北京：国防工业出版社，2007.
[5] 张海藩. 软件工程导论. 北京：清华大学出版社.2003.
