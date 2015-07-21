//
//  ViewController.m
//  LSDropDownList
//
//  Created by Shawn Li on 15/7/21.
//  Copyright (c) 2015年 Shawn Li. All rights reserved.
//

#import "ViewController.h"
#import "LSDropdownList.h"

@interface ViewController ()
@property (nonatomic, strong) LSDropdownList  *dropdownList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dropdownList = [[LSDropdownList alloc] initWithFrame:CGRectMake(100, 50, 150, 30)];
    _dropdownList.borderStyle = UITextBorderStyleRoundedRect;
    _dropdownList.listBGColor = [UIColor redColor];
    NSLog(@"_downdrop %@",NSStringFromCGRect(_dropdownList.frame));
    [self.view addSubview:_dropdownList];
}

@end
