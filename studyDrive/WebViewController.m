//
//  WebViewController.m
//  studyDrive
//
//  Created by GDaYao on 2017/5/27.
//  Copyright © 2017年 GDaYao. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    UIWebView * _webView;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (instancetype)initWithUrl:(NSString *)url{
    self=[super init];
    if(self){
        _webView =[[UIWebView alloc]initWithFrame:self.view.frame];
//        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//        [_webView loadRequest:request];
        [_webView loadHTMLString:@"<body>报名须知／新手上路</body>" baseURL:nil];
        [self.view addSubview:_webView];
    }
    return  self;
}


@end
