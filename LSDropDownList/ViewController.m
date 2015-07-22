//
//  ViewController.m
//  LSDropDownList
//
//  Created by Shawn Li on 15/7/21.
//  Copyright (c) 2015年 Shawn Li. All rights reserved.
//

#import "ViewController.h"
#import "LSDropdownList.h"

@interface ViewController ()<LSDropdownListDelegate>
@property (nonatomic, strong) LSDropdownList  *dropdownList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *list = [NSArray arrayWithObjects:@"管理员",@"开发人员",@"游客",@"用户", nil];
    _dropdownList = [[LSDropdownList alloc] initWithFrame:CGRectMake(100, 50, 150, 30) list:list];
    _dropdownList.delegate = self;
    [self.view addSubview:_dropdownList];
    
}

- (void)dropdownListDidSelectedItem:(NSString *)item {
    NSLog(@"%@",item);
}
@end
