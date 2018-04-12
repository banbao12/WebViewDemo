//
//  ViewController.m
//  WebView_Demo
//
//  Created by Banbao12 on 29/03/2018.
//  Copyright © 2018 Banbao12. All rights reserved.
//

#import "ViewController.h"
#import "UCWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 200.f, 150.f, 50.f);
    [button setTitle:@"Click" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)btnClick:(id)sender {
    UCWebViewController *webviewController = [[UCWebViewController alloc] init];
    webviewController.requestUrl = @"Default.html";
    [self.navigationController pushViewController:webviewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
