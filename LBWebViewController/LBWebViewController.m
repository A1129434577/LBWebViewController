//
//  AuthsManageViewController.m
//  MBP_MAPP
//
//  Created by 刘彬 on 16/5/13.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import "LBWebViewController.h"

@interface LBWebViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UILabel *hostLPromptLabel;
@end

@implementation LBWebViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _webView = [[WKWebView alloc] init];
        _webView.scrollView.delegate = self;
        if (@available(iOS 13.0, *)) {
            self.webView.layer.backgroundColor = [UIColor systemGroupedBackgroundColor].CGColor;
        } else {
            self.webView.layer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
        }
        self.webView.navigationDelegate = self;
        [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
        
        _loadingProgressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        self.loadingProgressView.progressTintColor = [UIColor greenColor];
        self.loadingProgressView.trackTintColor = [UIColor whiteColor];

        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.customTitle;
    
    _webView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetMaxY(self.navigationController.navigationBar.frame));
        _loadingProgressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 8);
    [_webView addSubview:_loadingProgressView];
    [self.view addSubview:_webView];
    
    CGFloat safeAreaInsetsTop = 0;
    if (@available(iOS 11, *)) {
        safeAreaInsetsTop = _webView.scrollView.safeAreaInsets.top;
    }
    UILabel *hostLPromptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_webView.bounds), 40)];
    hostLPromptLabel.alpha = 0;
    hostLPromptLabel.backgroundColor = [UIColor clearColor];
    hostLPromptLabel.font = [UIFont systemFontOfSize:12];
    hostLPromptLabel.textColor = [UIColor grayColor];
    hostLPromptLabel.textAlignment = NSTextAlignmentCenter;
    [_webView addSubview:hostLPromptLabel];
    _hostLPromptLabel = hostLPromptLabel;
}
#pragma mark setter
-(void)setCustomTitle:(NSString *)customTitle{
    _customTitle = customTitle;
    self.title = customTitle;
}
#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
        [_loadingProgressView setProgress:_webView.estimatedProgress animated:YES];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark WKNavigationDelegate
//页面开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _loadingProgressView.hidden = NO;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    _loadingProgressView.hidden = YES;
    _loadingProgressView.progress = 0;
    if (!self.customTitle.length) {
        self.title = webView.title;
    }
}
//页面加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    _loadingProgressView.hidden = YES;
    _loadingProgressView.progress = 0;
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] && [[UIApplication sharedApplication] openURL:navigationAction.request.URL]){
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        if (_showSource) {
            _hostLPromptLabel.text = [NSString stringWithFormat:@"网页由 %@ 提供",navigationAction.request.URL.host];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < -CGRectGetHeight(_hostLPromptLabel.frame)) {
        _hostLPromptLabel.alpha = -(scrollView.contentOffset.y/(CGRectGetHeight(_hostLPromptLabel.frame)*5));
    }else{
        _hostLPromptLabel.alpha = 0;
    }
}

-(void)dealloc{
    [_webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}


@end
