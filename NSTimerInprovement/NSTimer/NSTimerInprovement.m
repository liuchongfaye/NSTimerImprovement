//
//  NSTimerInprovement.m
//  NSTimerInprovement
//
//  Created by 刘冲 on 2018/7/30.
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
