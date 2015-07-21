//
//  LSDropdownList.m
//  LSDropDownList
//
//  Created by Shawn Li on 15/7/21.
//  Copyright (c) 2015年 Shawn Li. All rights reserved.
//

#import "LSDropdownList.h"

@interface LSDropdownList ()<UITableViewDataSource,UITableViewDelegate>
{
    CGRect  oldFrame;//整个控件的矩形frame，下拉框出现前
    CGRect  newFrame;//弹出下拉框后，新的矩形frame
}
@end

@implementation LSDropdownList
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化控件
        //设置默认下拉列表数据
        self.list = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
        self.borderStyle = UITextBorderStyleRoundedRect;
        _showDropList = NO;//默认不显示下拉列表
        oldFrame = frame;//未下拉时控件的初始大小
        //当下拉框显示时，计算出控件的大小。
        newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height * 4);
        self.lineColor = [UIColor grayColor];//默认列表框边框线为灰色.
        self.listBGColor = [UIColor whiteColor];//默认列表框背景色为白色。
        self.borderWidth = 1;//默认列表框边框宽度为1。
        //把背景色设为透明色，否则会有一个黑色的边
        self.backgroundColor = [UIColor clearColor];
        [self drawView];//调用方法绘制控件
    }
    
    return self;
}

- (void)drawView {
    //文本框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, oldFrame.size.width, oldFrame.size.height)];
    self.textField.borderStyle = self.borderStyle;//设置文本框边框风格
    [self addSubview:self.textField];
    //添加触摸事件
    [self.textField addTarget:self action:@selector(dropDownAction) forControlEvents:UIControlEventAllTouchEvents];//增加文本框的触摸事件响应
    
    //下拉列表
    self.listView = [[UITableView alloc] initWithFrame:CGRectMake(self.borderWidth, oldFrame.size.height + self.borderWidth, oldFrame.size.width - 2 * self.borderWidth, oldFrame.size.height * 3 - 2 * self.borderWidth)];
    self.listView.dataSource = self;
    self.listView.delegate = self;
    self.listView.backgroundColor = self.listBGColor;
    self.listView.separatorColor = self.lineColor;
    //self.listView.separatorInset = UIEdgeInsetsMake(0,  -50, 0, 0);
    //为了实现UITableView的分割线从最左边开始绘制
    if ([self.listView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.listView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.listView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.listView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.listView.hidden = !_showDropList;//默认listView隐藏，后面根据showDroplist判断
    [self addSubview:self.listView];
}

#pragma mark - 文本框触摸事件响应方法 
- (void)dropDownAction {
    [self.textField resignFirstResponder];//触摸文本框，不弹出键盘
    
    if (_showDropList) {//下拉框已显示
        return;
    } else {//如果下拉框没有显示，则显示
        //把下拉框放在前面，防止被其他控件遮挡住
        [self.superview bringSubviewToFront:self];
        [self setShowDropList:YES];//显示下拉框
    }
}

#pragma mark - UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"listviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //文本标签
    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    cell.textLabel.font = self.textField.font;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return oldFrame.size.height;
}

//当选择下拉列表中的某一行时，设置文本框中得值，隐藏下拉列表
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select index %ld",(long)indexPath.row);
    self.textField.text = (NSString *)[self.list objectAtIndex:indexPath.row];
    [self setShowDropList:NO];//隐藏下拉框
}

//实现UITableView的分割线从最左边开始。
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - 设置属性方法
- (BOOL)showDropList {
    return  _showDropList;
}

- (void)setShowDropList:(BOOL)showDropList {
    _showDropList = showDropList;
    if (_showDropList) {
        self.frame = newFrame;
        [self setNeedsDisplay];
    } else {
        self.frame = oldFrame;
    }
    self.listView.hidden = !showDropList;
}

#pragma mark - 私有方法
//为下拉框加上一个矩形边框
//收到setNeedsDisplay方法时调用
- (void)drawRect:(CGRect)rect {
    NSLog(@"rect - %@",NSStringFromCGRect(rect));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGRect drawRect;
    if (_showDropList) {
        CGContextSetStrokeColorWithColor(contextRef, [self.lineColor CGColor]);
        drawRect = self.listView.frame;
        CGContextStrokeRect(contextRef, drawRect);//画矩形
        //CGContextStrokeRectWithWidth(contextRef, drawRect, self.borderWidth);
    } else {//下拉框不显示
        return;
    }
}
@end
