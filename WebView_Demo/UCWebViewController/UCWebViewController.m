//
//  UCWebViewController.m
//  WebView_Demo
//
//  Created by Banbao12 on 29/03/2018.
//  Copyright © 2018 Banbao12. All rights reserved.
//

#import "UCWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIWebView+UCCategories.h"
#import "UCJavascriptBridge.h"

@interface UCWebViewController ()<UIWebViewDelegate>
/*!
 *  @author 半饱, 16-06-01
 *
 *  @brief javascript桥
 */
@property (nonatomic,strong) UCJavascriptBridge *javascriptBridge;

@property (nonatomic,strong) JSContext *jsContext;

@property (nonatomic,strong) NSURLRequest *originRequest;
@end

@implementation UCWebViewController

- (void)dealloc {
    NSLog(@"- (void)dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView =[[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self loadRequest];
}

- (void)loadRequest {
    NSURL  *url ;
    if (!_requestUrl || [ _requestUrl isEqualToString:@""]) {
        return;
    }
    if ([_requestUrl hasPrefix:@"http://"] || [_requestUrl hasPrefix:@"https://"]) {
        url = [NSURL URLWithString:_requestUrl];
    }
    else if([_requestUrl isEqualToString:@"about:blank"]){
        url = [NSURL URLWithString:_requestUrl];
    }
    else {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_requestUrl ofType:nil];
        url = [[NSURL alloc] initFileURLWithPath:filePath];
    }
    _originRequest= [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    [_webView loadRequest:_originRequest];
}

- (UCJavascriptBridge*)javascriptBridge {
    if (!_javascriptBridge) {
        _javascriptBridge = [[UCJavascriptBridge alloc] init];
    }
    return _javascriptBridge;
}

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)context  {
    self.jsContext = context;
    [self.jsContext evaluateScript:@"function iosfunc(){return 'ios function'}"];
    self.jsContext[@"UC_Client_Handle"] = self.javascriptBridge;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
