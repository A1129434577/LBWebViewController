//
//  AuthsManageViewController.h
//  MBP_MAPP
//
//  Created by 刘彬 on 16/5/13.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface LBWebViewController : UIViewController<WKNavigationDelegate>
@property (nonatomic,strong)NSString *customTitle;//如果不设置，将获取webView的title
@property (nonatomic,assign)BOOL showSource;
@property (nonatomic,strong,readonly)WKWebView *webView;
@property (nonatomic,strong,readonly)UIProgressView *loadingProgressView;

@end
