//
//  DZTimer.m
//  GCD_source
//
//  Created by zxl on 2020/8/20.
//  Copyright © 2020 DragonetZ. All rights reserved.
//

#import "DZTimer.h"

@interface DZTimer ()
@property (nonatomic, strong) dispatch_source_t mySource;
@property (nonatomic, assign) BOOL isRepeats;
@property (nonatomic, copy) dispatch_block_t handler;
@end

@implementation DZTimer
- (instancetype)initWithStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats handler:(dispatch_block_t)handler{

    self = [super init];
    if (self) {
        self.isRepeats = repeats;
        self.handler = handler;
        
        self.mySource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(self.mySource, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(self.mySource, ^{
            [self start];
        });
        
        dispatch_resume(self.mySource);
        self.isRunning = YES;
    }
    
    return self;
}

- (void)start {
    if (!self.isRunning) {
        self.isRunning = YES;
        dispatch_resume(self.mySource);
    } else {
        self.handler();

        if (!self.isRepeats) {
            [self cancel];
        }
    }

}

- (void)suspend {
    self.isRunning = NO;
    dispatch_suspend(self.mySource);
}

- (void)cancel {
    self.isRunning = NO;
    dispatch_source_cancel(self.mySource);
}

@end
