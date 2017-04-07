//
//  WebViewController.m
//  iOS与H5的交互理解
//
//  Created by dingping on 2017/4/6.
//  Copyright © 2017年 dingping. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createWebView];

}

- (void)createWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = NO;
    webView.navigationDelegate = self;
    
    [self.view addSubview:webView];
    webView.scrollView.scrollsToTop = YES;
    
    self.webView = webView;
    
    [self loadWebView];
    
    //JS调用OC 添加处理脚本
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"Share"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 因此这里要记得移除handlers
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"Share"];
}

- (void)loadWebView
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0){
        NSSet *websiteDataTypes
        = [NSSet setWithArray:@[
                                WKWebsiteDataTypeDiskCache,
                                WKWebsiteDataTypeMemoryCache,
                                ]];
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
        }];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
}

#pragma mark - WKNavigationDelegate -
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"Share"]) {
        NSLog(@"%@",message.body);
    }
}

@end
