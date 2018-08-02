//
//  NSTimerInprovement.m
//  NSTimerInprovement
//
//  Created by lc on 2018/7/30.
//  Copyright © 2018年 lc. All rights reserved.
//

#import "NSTimerInprovement.h"

@interface NSProxyInprovement : NSProxy

@property (nonatomic, weak) id aTarget;

@end

@implementation NSProxyInprovement

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.aTarget methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.aTarget];
}

@end

@interface NSTimerInprovement ()

@property (nonatomic, strong) NSProxyInprovement *proxy;
@property (nonatomic, strong) NSTimer *aTimer;

@end

@implementation NSTimerInprovement

#pragma mark - Init

+ (instancetype)ns_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    NSTimerInprovement *timerInprovement = [[NSTimerInprovement alloc] init];
    timerInprovement.proxy = [self proxyWithTarget:aTarget];
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:timerInprovement.proxy selector:aSelector userInfo:userInfo repeats:yesOrNo];
    timerInprovement.aTimer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timerInprovement;
}

+ (instancetype)ns_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    return [self ns_timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

+ (instancetype)ns_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block {
    NSTimerInprovement *timerInprovement = [[NSTimerInprovement alloc] init];
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval repeats:repeats block:block];
    timerInprovement.aTimer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timerInprovement;
}

+ (instancetype)ns_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block {
    return [self ns_timerWithTimeInterval:interval repeats:repeats block:block];
}

+ (instancetype)ns_scheduledTimerWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block {
    NSTimerInprovement *timerInprovement = [[NSTimerInprovement alloc] init];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:date interval:interval repeats:repeats block:block];
    timerInprovement.aTimer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timerInprovement;
}

+ (instancetype)ns_scheduledTimerWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(id)ui repeats:(BOOL)rep {
    NSTimerInprovement *timerInprovement = [[NSTimerInprovement alloc] init];
    timerInprovement.proxy = [self proxyWithTarget:t];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:date interval:ti target:timerInprovement.proxy selector:s userInfo:ui repeats:rep];
    timerInprovement.aTimer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timerInprovement;
}

- (void)dealloc {
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
}

#pragma mark - Override Methods

- (NSTimer *)timer {
    return self.aTimer;
}

#pragma mark - NSProxy

+ (NSProxyInprovement *)proxyWithTarget:(id)aTarget {
    NSProxyInprovement *proxy = [NSProxyInprovement alloc];
    proxy.aTarget = aTarget;
    
    return proxy;
}

@end
