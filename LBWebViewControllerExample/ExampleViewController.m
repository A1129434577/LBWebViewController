//
//  ExampleViewController.m
//  LBWebViewControllerExample
//
//  Created by 刘彬 on 2019/9/27.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ExampleViewController.h"
#import "LBWebViewController.h"
@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    LBWebViewController *webVC = [[LBWebViewController alloc] init];
    webVC.showSource = YES;
    webVC.customTitle = @"LBWebViewController";
    [webVC.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
