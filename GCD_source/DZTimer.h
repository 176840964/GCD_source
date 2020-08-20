//
//  DZTimer.h
//  GCD_source
//
//  Created by zxl on 2020/8/20.
//  Copyright © 2020 DragonetZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZTimer : NSObject

@property (nonatomic, assign) BOOL isRunning;

- (instancetype)initWithStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats handler:(dispatch_block_t)handler;
- (void)start;
- (void)suspend;

@end

NS_ASSUME_NONNULL_END
