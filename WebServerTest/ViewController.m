//
//  ViewController.m
//  WebServerTest
//
//  Created by 冯晓国 on 2016/11/3.
//  Copyright © 2016年 冯晓国. All rights reserved.
//

#import "ViewController.h"
#import "GCDWebDAVServer.h"
#import "PlayerViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bntClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self copyFileToDocument:@"testVideo"   type:@"m3u8"];
    [self copyFileToDocument:@"testVideo-0" type:@"ts"];
    [self copyFileToDocument:@"testVideo-1" type:@"ts"];
}

- (void)bntClick{
    PlayerViewController *player = [[PlayerViewController alloc] init];
    [self presentViewController:player animated:YES completion:nil];
}

- (void)copyFileToDocument:(NSString*)fileName type:(NSString *)fileType{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",fileName, fileType]];
    NSFileManager *fm = [NSFileManager defaultManager];
    //判断沙盒下是否存在，把工程的文件复制document目录下
    BOOL isExist = [fm fileExistsAtPath:filePath];
    if (!isExist){
        //获取工程中文件
        NSString *fileBundlePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
        if ([fm copyItemAtPath:fileBundlePath toPath:filePath error:nil]) {
            NSLog(@"%@.%@成功复制到沙盒", fileName, fileType);
        }else {
            NSLog(@"%@.%@复制到沙盒失败", fileName, fileType);
        }
    } else {
        NSLog(@"%@.%@已存在沙盒里", fileName, fileType);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
