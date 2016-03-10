//
//  ViewController.m
//  AllinpayTest_ObjC
//
//  Created by allinpay-shenlong on 14-10-27.
//  Copyright (c) 2014年 Allinpay.inc. All rights reserved.
//

#import "ViewController.h"
#import "APay.h"
#import "PaaCreater.h"

@interface ViewController () <APayDelegate>

@property (nonatomic, strong) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"!!!!!!!!!");
     NSLog(@"!!!!!!!!!"); NSLog(@"!!!!!!!!!"); NSLog(@"!!!!!!!!!"); NSLog(@"!!!!!!!!!"); NSLog(@"!!!!!!!!!"); NSLog(@"!!!!!!!!!");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGPoint center = _button.center;
    center.x = self.view.center.x;
    _button.center = center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation NS_DEPRECATED_IOS(2_0, 6_0) {

//    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}

//- (BOOL)shouldAutorotate {

//    return YES;
//}

//- (NSUInteger)supportedInterfaceOrientations {

//    return UIInterfaceOrientationMaskLandscape;
//}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {

//    return UIInterfaceOrientationLandscapeRight;
//}

#pragma mark -

////设备旋转前
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//}

////设备旋转前
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

//    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
//}

////设备旋转完
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {

//    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];//
//}

#pragma mark -

- (IBAction)callPayPlugin:(id)sender {
    
    NSLog(@"!!! 调起支付插件 !!!");
    
    //订单数据
    
    NSString *payData = [PaaCreater randomPaa];
    
    //@param mode
    //00 生产环境
    //01 测试环境
    
    //在测试与生产环境之间切换的时候请注意修改mode参数
    
    [APay startPay:payData viewController:self delegate:self mode:@"01"];
}

- (void)APayResult:(NSString *)result {
    
    NSLog(@"%@", result);
    NSArray *parts = [result componentsSeparatedByString:@"="];
    NSError *error;
    NSData *data = [[parts lastObject] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSInteger payResult = [dic[@"payResult"] integerValue];
    NSString *format_string = @"支付结果::支付%@";
    if (payResult == APayResultSuccess) {
        NSLog(format_string,@"成功");
    } else if (payResult == APayResultFail) {
        NSLog(format_string,@"失败");
    } else if (payResult == APayResultCancel) {
        NSLog(format_string,@"取消");
    }
}

@end
