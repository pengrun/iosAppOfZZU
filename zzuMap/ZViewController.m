//
//  ZViewController.m
//  OC+JavaScript
//
//  Created by Wangmm on 13-3-22.
//  Copyright (c) 2013年 35.com. All rights reserved.

//  iOS 中国开发者(262091386) 共同探讨技术....

#import "ZViewController.h"

@interface ZViewController ()<UIWebViewDelegate>
{
    BOOL isFirstLoadWeb;
}
@property (nonatomic,retain) UIWebView *webview;

@end

@implementation ZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    _webview.backgroundColor = [UIColor clearColor];
    _webview.scalesPageToFit =YES;
    _webview.delegate =self;
    [self.view addSubview:_webview];
    
    //注意这里的url为手机端的网址 m.baidu.com，不要写成 www.baidu.com。
    //NSURL *url =[[NSURL alloc] initWithString:@"http://m.baidu.com/"];
    NSURL *url =[[NSURL alloc] initWithString:@"http://jw.zzu.edu.cn/"];
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [_webview loadRequest:request];
//    [url release];
//    [request release];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
    //程序会一直调用该方法，所以判断若是第一次加载后就使用我们自己定义的js，此后不在调用JS,否则会出现网页抖动现象
    if (!isFirstLoadWeb) {
        isFirstLoadWeb = YES;
    }else
        return;
    //给webview添加一段自定义的javascript
 
    NSString *str1=@"var script = document.createElement('script');";
    NSString *str2=@"script.type = 'text/javascript';";
    NSString *str3=@"script.text = \"function myFunction() {";
    NSString *str4=@"var field = document.getElementsByName('word')[0];";
    NSString *str5=@"document.loginform.xuehao.value='";
    NSString *str6=str222;
    NSString *str7=@"';";
    NSString *str8=@"document.loginform.mima.value='";
    NSString *str9=@"4344469376";
    NSString *str10=@"';";
    NSString *str11=@"document.loginform.nianji.value='";
    NSString *str12=@"2011";
    NSString *str13=@"';";
    NSString *str14=@"document.loginform.submit();";
    NSString *str15=@"}\";";
    NSString *str16=@"document.getElementsByTagName('head')[0].appendChild(script);";
   
    
  
    
   
    
    NSString *zz=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,str16];
    
    [webView stringByEvaluatingJavaScriptFromString:zz];
    //////////
//    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function myFunction() { "
//     
//    //注意这里的Name为搜索引擎的Name,不同的搜索引擎使用不同的Name
//    //<input type="text" name="word" maxlength="64" size="20" id="word"/> 百度手机端代码
//     "var field = document.getElementsByName('word')[0];"
//     
//     //给变量取值，就是我们通常输入的搜索内容，这里为 code4app.com
//     //"field.value='因为爱情';"
//     "document.loginform.xuehao.value='';"
//     "document.loginform.mima.value='4344469376';"
//     "document.loginform.nianji.value='2011';"
////    "options[loginform.selec.selectedIndex].value='2011';"
//     //"loginform.selec.selectedIndex='0';"
//     
//     "document.loginform.submit();"
//     //"document.forms[0].submit();"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    //开始调用自定义的javascript
    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    
    //以上内容均参考自互联网，再次分享给互联网
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
//    [_webview release];
//    [super dealloc];
}
@end
