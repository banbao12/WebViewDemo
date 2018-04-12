/****************************************************************************************************
 * 项目名称：WebView_Demo
 * 文件名称：UCJavascriptBridgeProtocol.h
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

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol UCJavascriptBridgeProtocol <JSExport>
/*!
 *  @author 半饱
 *
 *  @brief 异步调用方法
 *
 *  @param parameterJSON json参数
 */
- (void)javascriptBridge:(NSString *)parameterJSON;
/*!
 *  @author 半饱
 *
 *  @brief 同步调用方法
 *
 *  @param parameterJSON      json参数
 *
 *  @return 返回id类型
 */
- (id)javascriptBridgeSync:(NSString *)parameterJSON;

@end
