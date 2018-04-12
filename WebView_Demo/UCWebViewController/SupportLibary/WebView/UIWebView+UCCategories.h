/****************************************************************************************************
 * 项目名称：WebView_Demo
 * 文件名称：UIWebView+UCCategories.h
 * 版权所有： Copyright (c) 2018年 半饱
 * 内容摘要：<#Description#>
 * 作        者： 半 饱（Banbao）
 * 创建日期： 29/03/2018
 *
 * 修改记录1：
 *     修改日期 ：<#ModifyDate#>
 *     修 改  人 ： <#Author#>
 *     修改内容：<#Description#>
 *
 *
 ****************************************************************************************************/

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol UCWebViewDelegate <UIWebViewDelegate>

@optional

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)context;

@end


@interface UIWebView(UCCategories)

@property (nonatomic, readonly) JSContext *jsContext;

@end
