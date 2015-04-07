//
//  WebBrowserView.m
//  ProccesTest
//
//  Created by 西村顕 on 2015/04/06.
//  Copyright (c) 2015年 KenNishimura. All rights reserved.
//

#import "WebBrowserView.h"

static NSString * const InitialURL = @"https://my.fit.ac.jp";

@interface WebBrowserView() <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation WebBrowserView

- (void)loadView {
    [super loadView];
    
    // WebViewのイニシャライズ
    self.webView = [[WKWebView alloc] init];
    // WebViewのフレームサイズを画面サイズに指定
    self.webView.frame = self.view.bounds;
    // WebBrowserViewに貼り付ける
    [self.view addSubview:self.webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 初回画面表示時にIntialURLで指定した Web ページを読み込む
    NSURL *url = [NSURL URLWithString:InitialURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

@end