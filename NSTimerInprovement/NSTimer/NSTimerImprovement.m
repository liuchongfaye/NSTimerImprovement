//
//  NSTimerImprovement.m
//  NSTimerImprovement
//
//  Created by lc on 2018/7/30.
//  Copyright © 2018年 lc. All rights reserved.
//

#import "NSTimerImprovement.h"

@interface NSProxyImprovement : NSProxy

@property (nonatomic, weak) id aTarget;

@end

@implementation NSProxyImprovement

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.aTarget methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.aTarget];
}

@end

@interface NSTimerImprovement ()

@property (nonatomic, strong) NSProxyImprovement *proxy;
@property (nonatomic, strong) NSTimer *aTimer;

@end

@implementation NSTimerImprovement

#pragma mark - Init

+ (instancetype)ns_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    NSTimerImprovement *timerImprovement = [[NSTimerImprovement alloc] init];
    timerImprovement.proxy = [self proxyWithTarget:aTarget];
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:timerImprovement.proxy selector:aSelector userInfo:userInfo repeats:yesOrNo];
    timerImprovement.aTimer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timerImprovement;
}

+ (instancetype)ns_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    return [self ns_timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

+ (instancetype)ns_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block {
    NSTimerImprovement *timerImprovement = [[NSTimerImprovement alloc] init];
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval repeats:repeats block:block];
    timerImprovement.aTimer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timerImprovement;
}

+ (instancetype)ns_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block {
    return [self ns_timerWithTimeInterval:interval repeats:repeats block:block];
}

+ (instancetype)ns_scheduledTimerWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block {
    NSTimerImprovement *timerImprovement = [[NSTimerImprovement alloc] init];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:date interval:interval repeats:repeats block:block];
    timerImprovement.aTimer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timerImprovement;
}

+ (instancetype)ns_scheduledTimerWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(id)ui repeats:(BOOL)rep {
    NSTimerImprovement *timerImprovement = [[NSTimerImprovement alloc] init];
    timerImprovement.proxy = [self proxyWithTarget:t];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:date interval:ti target:timerImprovement.proxy selector:s userInfo:ui repeats:rep];
    timerImprovement.aTimer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timerImprovement;
}

- (void)dealloc {
    if ([self.aTimer isValid]) {
        [self.aTimer invalidate];
    }
    self.aTimer = nil;
}

#pragma mark - Override Methods

- (NSTimer *)timer {
    return self.aTimer;
}

#pragma mark - NSProxy

+ (NSProxyImprovement *)proxyWithTarget:(id)aTarget {
    NSProxyImprovement *proxy = [NSProxyImprovement alloc];
    proxy.aTarget = aTarget;
    
    return proxy;
}

@end
