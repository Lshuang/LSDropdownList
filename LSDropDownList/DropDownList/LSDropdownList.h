//
//  LSDropdownList.h
//  LSDropDownList
//
//  Created by Shawn Li on 15/7/21.
//  Copyright (c) 2015年 Shawn Li. All rights reserved.
//  自定义下拉菜单

#import <UIKit/UIKit.h>

@protocol LSDropdownListDelegate <NSObject>
@required
- (void)dropdownListDidSelectedItem:(NSString *)item;
@end

//文本输入框加UITableView来实现
@interface LSDropdownList : UIView
{
        BOOL  _showDropList;/*! 是否弹出下拉框*/
}
@property (nonatomic, weak) id <LSDropdownListDelegate>  delegate;
/*! 文本输入框*/
@property (nonatomic, strong) UITextField  *textField;
/*! 下拉列表数据*/
@property (nonatomic, strong) NSArray  *list;
/*! 下拉列表视图*/
@property (nonatomic, strong) UITableView  *listView;
/*! 下拉框的边框色*/
@property (nonatomic, strong) UIColor  *lineColor;
/*! 下拉框背景色*/
@property (nonatomic, strong) UIColor  *listBGColor;
/*! 文本输入框边框类型*/
@property (nonatomic, assign) UITextBorderStyle  borderStyle;
/*! 下拉框边框粗细*/
@property (nonatomic, assign) CGFloat  borderWidth;

- (void)drawView;
- (instancetype)initWithFrame:(CGRect)frame list:(NSArray *)list;
@end
