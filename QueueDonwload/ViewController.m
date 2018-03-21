//
//  ViewController.m
//  QueueDonwload
//
//  Created by LV on 2018/3/1.
//  Copyright © 2018年 LV. All rights reserved.
//

#import "ViewController.h"
#import "LoadSourceManager.h"

@interface ViewController()
@property UIView * v_view;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) UITextView * tx;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Private Method

- (void)p_showPropertyMethod {
    unsigned int outCount;
    objc_property_t * propertys = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = propertys[i];
        NSString * key = [NSString stringWithUTF8String:property_getName(property)];
        NSLog(@"%d. %@ - %@",i+1,key, [self valueForKey:key]);
    }
    free(propertys);
    
    NSLog(@"\n");
    
    Method * methodList = class_copyMethodList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Method temp_m = methodList[i];
        NSLog(@"- %@",[NSString stringWithUTF8String:sel_getName(method_getName(temp_m))]);
    }
    free(methodList);
    
    NSLog(@"\n");
    
    Method * meta_methodList = class_copyMethodList([objc_getMetaClass(object_getClassName(self)) class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Method temp_m = meta_methodList[i];
        NSLog(@"+ %@",[NSString stringWithUTF8String:sel_getName(method_getName(temp_m))]);
    }
    free(meta_methodList);
}

- (void)serialQueueSynchronize {
    dispatch_queue_t queue_t = dispatch_queue_create("com.lvSerialSynchronize.render", DISPATCH_QUEUE_SERIAL);
    NSLog(@"串行队列【同步任务】 - %@",[NSThread currentThread]);
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【1】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【2】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【3】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【4】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【5】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【6】 - %@",[NSThread currentThread]);
    });
}

- (void)serialQueueAsynchronize {
    dispatch_queue_t queue_t = dispatch_queue_create("com.lvSerialAsychronize.render", DISPATCH_QUEUE_SERIAL);
    NSLog(@"串行队列【异步任务】 - %@",[NSThread currentThread]);
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【1】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【2】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【3】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【4】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【5】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【6】 - %@",[NSThread currentThread]);
    });
}

- (void)concurrentQueueSychronize {
    dispatch_queue_t queue_t = dispatch_queue_create("com.lvConcurrentSychronize.render", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"并发队列【同步】 - %@",[NSThread currentThread]);
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【1】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【2】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【3】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【4】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【5】 - %@",[NSThread currentThread]);
    });
    dispatch_sync(queue_t, ^{
        [self loadPic];
        NSLog(@"【6】 - %@",[NSThread currentThread]);
    });
}

- (void)concurrentQueueAsychronize {
    dispatch_queue_t queue_t = dispatch_queue_create("com.lvConcurrentAsychronize.render", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"并发队列【异步】 - %@",[NSThread currentThread]);
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【1】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【2】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【3】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【4】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【5】 - %@",[NSThread currentThread]);
    });
    dispatch_async(queue_t, ^{
        [self loadPic];
        NSLog(@"【6】 - %@",[NSThread currentThread]);
    });
}

- (void)asychronizeBackToMainQueue {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1.当前线程: %@",[NSThread currentThread]);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"主线程sleep10秒");
            sleep(10);
            NSLog(@"2.当前线程: %@",[NSThread currentThread]);
        });
        NSLog(@"3.当前线程 %@",[NSThread currentThread]);
    });
}

- (void)loadPic {
    NSURL * url = [NSURL URLWithString:@"http://img.taopic.com/uploads/allimg/120727/201995-120HG1030762.jpg"];
    NSURLResponse * rp = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url]
                          returningResponse:&rp error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        _photo.image = [UIImage imageWithData:data];
    });
}

- (void)setTargetQueueOne {
    
}

- (void)setTargetQueueTwo {
    
}

#pragma mark - Target Action

- (IBAction)segmentAction:(UISegmentedControl *)sender {
    NSLog(@"\n");
    if (sender == _segment2) {
        switch (sender.selectedSegmentIndex) {
            case 0:
                [self setTargetQueueOne];
                break;
            case 1:
                [self setTargetQueueTwo];
                break;
            default:
                break;
        }
        sender.selectedSegmentIndex = -1;
    }else if (sender == _segment) {
        _photo.image = nil;
        switch (sender.selectedSegmentIndex) {
            case 0:
                [self serialQueueSynchronize];
                break;
            case 1:
                [self serialQueueAsynchronize];
                break;
            case 2:
                [self concurrentQueueSychronize];
                break;
            case 3:
                [self concurrentQueueAsychronize];
                break;
            case 4:
                [self asychronizeBackToMainQueue];
                break;
            default:
                break;
        }
        sender.selectedSegmentIndex = -1;
    }
}

@end
