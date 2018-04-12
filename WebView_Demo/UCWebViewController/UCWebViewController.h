//
//  UCWebViewController.h
//  WebView_Demo
//
//  Created by Banbao12 on 29/03/2018.
//  Copyright © 2018 Banbao12. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCWebViewController : UIViewController

/**
 加载网页的WebView
 */
@property (nonatomic,strong) UIWebView *webView;

/**
 需要加载的url
 */
@property (nonatomic,strong) NSString *requestUrl;

@end
