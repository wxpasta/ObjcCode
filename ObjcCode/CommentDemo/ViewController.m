//
//  ViewController.m
//  CommentDemo
//
//  Created by AngieMIta on 2017/8/18.
//  Copyright © 2017年 AngieMIta. All rights reserved.
//

#import "ViewController.h"
#import "BulletView.h"
#import "BulletManager.h"


@interface ViewController ()

@property (nonatomic, strong) BulletManager *manager;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [[BulletManager alloc]init];
    
    __weak typeof (self) myself = self;
    self.manager.generateViewBlock = ^(BulletView *view) {
        [myself addBulletView:view];
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickBtn:(id)sender {
    
    [self.manager start];
}

- (void)addBulletView:(BulletView *)view{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory * 60, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
    
}
- (IBAction)clickStopBtn:(id)sender {
    [self.manager stop];
}

@end
