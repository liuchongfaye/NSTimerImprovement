//
//  NSTimerInprovement.h
//  NSTimerInprovement
//
//  Created by 刘冲 on 2018/7/30.
//  Copyright © 2018年 lc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimerInprovement : NSObject

+ (instancetype)ns_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

@property (nonatomic, strong, readonly) NSTimer *timer;



@end
