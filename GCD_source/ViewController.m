//
//  ViewController.m
//  GCD_source
//
//  Created by zxl on 2020/8/20.
//  Copyright © 2020 DragonetZ. All rights reserved.
//

#import "ViewController.h"
#import "DZTimer.h"

@interface ViewController ()
@property (nonatomic, strong) dispatch_source_t source;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign) NSUInteger totalComplete;
@property (nonatomic) BOOL isRunning;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    DZTimer *timer = [[DZTimer alloc] initWithStart:0 interval:1 repeats:YES handler:^{
//        NSLog(@"heihei");
//    }];
    
    self.queue = dispatch_queue_create("dispatch_source", NULL);
    self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_event_handler(self.source, ^{
        NSInteger value = dispatch_source_get_data(self.source);
        self.totalComplete += value;
        NSLog(@"进度%.2f", self.totalComplete / 100.0);
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.totalComplete == 0) {//开始
        self.isRunning = YES;
        dispatch_resume(self.source);
        for (NSInteger i = 0; i < 100; i++) {
            dispatch_async(self.queue, ^{
                sleep(1);
                dispatch_source_merge_data(self.source, 1);
            });
        }
    } else {
        if (self.isRunning) {// 暂停
            dispatch_suspend(self.source);
            dispatch_suspend(self.queue);
            self.isRunning = NO;
        }else{//恢复
            dispatch_resume(self.source);
            dispatch_resume(self.queue);
            self.isRunning = YES;
        }
    }
}


@end
