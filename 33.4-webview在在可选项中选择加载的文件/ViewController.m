//
//  ViewController.m
//  33.4-webview在在可选项中选择加载的文件
//
//  Created by Mac on 14-10-27.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UIWebView* webView;

@end

@implementation ViewController


//  webView 的懒加载
- (UIWebView *)webView{
   
    if(!_webView ){
    
       _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
       _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    [self loadDataWithURL:self.fileURL];
}




#pragma mark - 加载文档演练


- (void)loadTextFileWithURL:(NSURL *)url
{
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

}




- (void)loadDataWithURL:(NSURL *)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSString *mimeType = [self mimeTypeWithURL:url];
    
    [self.webView loadData:data MIMEType:mimeType textEncodingName:@"UTF8" baseURL:nil];
}




- (NSString *)mimeTypeWithURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response = nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    return response.MIMEType;
}


@end
