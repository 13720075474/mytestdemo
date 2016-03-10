//
//  ViewController.swift
//  AllinpayTest_Swift
//
//  Created by allinpay-shenlong on 14-10-22.
//  Copyright (c) 2014年 Allinpay.inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APayDelegate {

    @IBOutlet var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:
    
    @IBAction func callPayPlugin(AnyObject) {
        println("!!! 调起支付插件 !!!");
        
        //订单数据
        
        let payData: NSString? = PaaCreater.randomData()
        
        //@param mode
        //00 生产环境
        //01 测试环境
        
        //在测试与生产环境之间切换的时候请注意修改mode参数
        
        APay.startPay(payData as! String, viewController: self, delegate: self, mode: "01")//针对最新语法修改
    }
   
    func APayResult(result: String!) {
        println(result)
        let parts: NSArray = result.componentsSeparatedByString("=")
        var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
        let jsonStr: NSString = parts.lastObject as! NSString
        let data: NSData? = jsonStr.dataUsingEncoding(NSUTF8StringEncoding)
        let dic: NSDictionary? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
        let payResult = dic?.valueForKey("payResult")?.integerValue
        let format_string = "支付结果::支付"
        var ret_string: String?
        if payResult == 0 {
            ret_string = "成功"
        } else if payResult == 1 {
            ret_string = "失败"
        } else if payResult == -1 {
            ret_string = "取消"
        }
        let str = format_string + ret_string!
        println(str)
        let version: NSString = UIDevice.currentDevice().systemVersion
        if version.floatValue < 8.0 {
            var alertView = UIAlertView(title: nil, message: str, delegate: nil, cancelButtonTitle: "确定")
            alertView.show()
            return;
        }
        var alertController = UIAlertController(title: "", message: str, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true) { () -> Void in
            println("弹出警告窗口")
        }
    }
    
}

