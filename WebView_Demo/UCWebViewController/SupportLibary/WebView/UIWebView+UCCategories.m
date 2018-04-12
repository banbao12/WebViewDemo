/****************************************************************************************************
 * 项目名称：WebView_Demo
 * 文件名称：UIWebView+UCCategories.m
 * 版权所有： Copyright (c) 2018年 半饱
 * 内容摘要：<#Description#>
 * 作        者： 半 饱（Banbao）
 * 创建日期：29/03/2018
 *
 * 修改记录1：
 *     修改日期 ：<#ModifyDate#>
 *     修 改  人 ： <#Author#>
 *     修改内容：<#Description#>
 *
 *
 ****************************************************************************************************/
#import "UIWebView+UCCategories.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>

static const char UCJavaScriptContext[] = "UCJSContext";

static NSHashTable* UC_WebViews = nil;

@interface UIWebView(UCCategories_Private)
- (void)didCreateJavaScriptContext:(JSContext *)context;
@end

@protocol UCWebFrame <NSObject>
- (id)parentFrame;
@end

@implementation NSObject(UCCategories)

- (void)webView:(id)unused didCreateJavaScriptContext:(JSContext *)context forFrame:(id<UCWebFrame>) frame {
    NSParameterAssert( [frame respondsToSelector: @selector( parentFrame )] );
    if ( [frame respondsToSelector: @selector( parentFrame) ] && [frame parentFrame] != nil )
        return;
    void (^notifyDidCreateJavaScriptContext)() = ^{
        for ( UIWebView *webView in UC_WebViews ) {
            NSString *cookie = [NSString stringWithFormat: @"UCWebView_%lud", (unsigned long)webView.hash ];
            [webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat: @"var %@ = '%@'", cookie, cookie ]];
            if ( [context[cookie].toString isEqualToString:cookie] ) {
                [webView didCreateJavaScriptContext:context];
                return;
            }
        }
    };
    
    if ( [NSThread isMainThread] ) {
        notifyDidCreateJavaScriptContext();
    }
    else {
        dispatch_async( dispatch_get_main_queue(), notifyDidCreateJavaScriptContext );
    }
}
@end


@implementation UIWebView (UCCategories)

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UC_WebViews = [NSHashTable weakObjectsHashTable];
    });
    NSAssert([NSThread isMainThread], @"uh oh - why aren't we on the main thread?");
    id webView = [super allocWithZone: zone];
    [UC_WebViews addObject: webView];
    return webView;
}

- (void)didCreateJavaScriptContext:(JSContext *)context {
//    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    // 服务器的响应对象,服务器接收到请求返回给客户端的
    NSURLResponse *respnose = nil;
    [NSURLConnection sendSynchronousRequest:self.request returningResponse:&respnose error:NULL];
    NSString *urlPath = [self.request.URL.absoluteString lowercaseString];
    if (![urlPath hasSuffix:@".pdf"]) {
        [self willChangeValueForKey: @"UCJavaScriptContext"];
        objc_setAssociatedObject( self, UCJavaScriptContext, context, OBJC_ASSOCIATION_RETAIN);
        [self didChangeValueForKey: @"UCJavaScriptContext"];
        if ([self.delegate respondsToSelector: @selector(webView:didCreateJavaScriptContext:)]) {
            id<UCWebViewDelegate> delegate = ( id<UCWebViewDelegate>)self.delegate;
            [delegate webView: self didCreateJavaScriptContext:context];
        }
    }
}

- (JSContext *)jsContext {
    JSContext *javaScriptContext = objc_getAssociatedObject(self, UCJavaScriptContext);
    return javaScriptContext;
}

@end
