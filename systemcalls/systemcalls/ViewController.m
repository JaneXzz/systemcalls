//
//  ViewController.m
//  systemcalls
//
//  Created by Jane on 16/6/26.
//  Copyright © 2016年 许珍珍. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) MFMessageComposeViewController *controller;
@property (strong, nonatomic) MFMailComposeViewController *mailController;

@end

@implementation ViewController
#pragma mark --- 打电话
// 两个App之间的通讯 使用NSUrl
- (IBAction)CallPhone:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    //mailto：//  --发邮件
    //sms:// --发短讯
   NSString *strUrl = [NSString stringWithFormat:@"tel://%@",self.myTextField.text];
    NSURL *url = [NSURL URLWithString:strUrl];
    [app openURL:url];
}


#pragma mark -- 发短信 第一种
- (IBAction)SendMessage:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    NSString *strUrl = [NSString stringWithFormat:@"sms://%@",self.myTextField.text];
    NSURL *url = [NSURL URLWithString:strUrl];
    [app openURL:url];
}
#pragma mark -- 发短信 第二种
- (IBAction)SendSMS:(id)sender {
    self.controller.recipients = @[@"18951259609",@"18961358839"];
    self.controller.body = @"每天都开心，不用回复，测试短信";
    [self presentViewController:self.controller animated:YES completion:nil];
}
//判断短信发送是否成功
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"MessageComposeResultCancelled");
            break;
        case MessageComposeResultSent:
            NSLog(@"MessageComposeResultSent");
            break;
        case MessageComposeResultFailed:
            NSLog(@"MessageComposeResultFailed");
            break;
    }
}

#pragma mark -- 发邮件 第一种
- (IBAction)SendMail:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"mailto://415311094@qq.com"];
    [app openURL:url];
}

#pragma mark -- 发邮件 第二种
- (IBAction)SendEmail:(id)sender {
    [self.mailController setToRecipients:@[@"415311094@qq.com",@"18601985782@163.com"]];
    [self.mailController setSubject:@"My name is Jane"];
    [self.mailController setMessageBody:@"I Love You" isHTML:NO];
    [self presentViewController:self.mailController animated:YES completion:nil];
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"MFMailComposeResultCancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"MFMailComposeResultSaved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"MFMailComposeResultSent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"MFMailComposeResultFailed");
            break;
        default:
            break;
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.controller = [[MFMessageComposeViewController alloc] init];
    self.controller.messageComposeDelegate = self;
    
    self.mailController = [[MFMailComposeViewController alloc] init];
    self.mailController.mailComposeDelegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
