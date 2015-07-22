#简单实现输入框下拉选择输入内容
## 实现思路
- UITableView和UITextField

##运行效果
- [shoot](http://ww1.sinaimg.cn/large/987b958agw1eubmy4tthbg208w0gaabp.gif)

##使用方法
```NSArray *list = [NSArray arrayWithObjects:@"管理员",@"开发人员",@"游客",@"用户", nil];
    _dropdownList = [[LSDropdownList alloc] initWithFrame:CGRectMake(100, 50, 150, 30) list:list];
    _dropdownList.delegate = self;
    [self.view addSubview:_dropdownList];