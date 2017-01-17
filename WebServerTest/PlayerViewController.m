//
//  PlayerViewController.m
//  AVPlayer
//
//  Created by 钟 超 on 14-1-7.
//  Copyright (c) 2014年 LightOnUs.com. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"testVideo.m3u8"];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:filePath]) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:9998/testVideo.m3u8"]];
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = self.view.bounds;
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.view.layer addSublayer:self.playerLayer];
        [self.player play];
    }else {
        NSLog(@"文件不存在");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
