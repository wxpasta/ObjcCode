//
//  ViewController.m
//  ExImage
//
//  Created by 巴糖 on 2017/9/27.
//  Copyright © 2017年 巴糖. All rights reserved.
//

#import "ViewController.h"
#import "YYImage.h"

@interface ViewController ()

@property (nonatomic, strong) YYImageDecoder *decoder;

@property (nonatomic, assign)int i;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self roadWebP];
}

- (void)roadWebP{
    NSURL *webUrl = [[NSBundle mainBundle] URLForResource:@"GarfieldWebp" withExtension:@"webp"];
    NSData *data = [NSData dataWithContentsOfURL:webUrl];
    _decoder = [YYImageDecoder decoderWithData:data scale:1.0];
    self.i = 0;
    UIImage *imageWebp = [_decoder frameAtIndex:self.i decodeForDisplay:YES].image;
    UIImageWriteToSavedPhotosAlbum(imageWebp, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error != nil) {
        NSLog(@"error = %@",error);
    }else{
        NSLog(@"success");
        self.i++;
        UIImage *imageWebp = [_decoder frameAtIndex:self.i decodeForDisplay:YES].image;
        if (imageWebp != nil) {
            UIImageWriteToSavedPhotosAlbum(imageWebp, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
