# NSTimerInprovement
NSTimerInprovement这个库解决了定时器循环应用bug并结合了NSRunloop技术（NSTimer的苹果官方文档提到过），同时还管理了NSTimer的生命周期，丝毫不用关心NSTimer什么时候释放问题

## How to use
在使用到定时器的对象声明一个属性，比如：
```
@property (nonatomic, strong) NSTimerInprovement *timerInprovement;   // 必须要如此才行，否则会导致崩溃
```
使用定NSTimerInprovement代替定时器时，有6种方法，分别对应着NSTimer的六种创建定时器的方法，分别是：
方法1：
```
// 此方法等同于 NSTimer 的 "+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo"
self.timerInprovement = [NSTimerInprovement ns_timerWithTimeInterval:1.0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
```
方法2：
```
// 此方法等同于 NSTimer 的"+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo"
self.timerInprovement = [NSTimerInprovement ns_scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
```
方法3：
```
// 此方法等同于 NSTimer 的"+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block",但是仅适用于iOS 10.0以上的系统
// 注意内存泄漏
__weak typeof(self) weakSelf = self;
self.timerInprovement = [NSTimerInprovement ns_timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *timer) {
    [weakSelf timerFire:timer];
 }];
```
方法4：
```
// 此方法等同于 NSTimer 的 "+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block",但是仅适用于iOS 10.0以上的系统
// 注意内存泄漏
__weak typeof(self) weakSelf = self;
self.timerInprovement = [NSTimerInprovement ns_scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *timer) {
    [weakSelf timerFire:timer];
}];
```
方法5：
```
// 此方法等同于 NSTimer 的 "- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(nullable id)ui repeats:(BOOL)rep"
NSDate *date = [[NSDate date] dateByAddingTimeInterval:10.0];
    self.timerInprovement = [NSTimerInprovement ns_scheduledTimerWithFireDate:date interval:1.0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
```
方法6：
```
// 此方法等同于 NSTimer 的 "- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block",但是仅限于iOS 10.0以上
// 注意内存泄露
__weak typeof(self) weakSelf = self;
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:10.0];
    self.timerInprovement = [NSTimerInprovement ns_scheduledTimerWithFireDate:date interval:1.0 repeats:YES block:^(NSTimer *timer) {
        [weakSelf timerFire:timer];
    }];
```
除此之外，NSTimer 还有两个方法，是基于 NSInvocation 来实现的，这里就懒得实现了。

加入要对NSTimer对象进行操作，比如执行'invalidate'操作，那么只需要可以从 NSTimerInprovement 的对象的.h中获取到NSTimer对象(为了安全考虑，此属性是只读的），类似下面代码：
```
[self.timerInprovement.timer invalidate];
```

### Installation(安装）

可以下载此工程，将NSTimerInprovement这个类的 .h 与 .m 拖到自己的项目当中，也可以使用Cocoapods来管理，只需要在Podfile文件里写上下面代码再执行'pod install'就可以了：
```
pod 'NSTimerInprovement'
```



