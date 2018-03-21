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
    NSURL * url = [NSURL URLWithString:@"http://img.taopic.com/uploads/allimg/140729/240450-140HZP45790.jpg"];
    NSURLResponse * rp = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url]
                          returningResponse:&rp error:&error];
    NSLog(@"%@",[NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            UIAlertController * vc = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:cancelAction];
            [self presentViewController:vc animated:YES completion:nil];
            return ;
        }
        _photo.image = [UIImage imageWithData:data];
    });
}

- (void)setTargetQueueOne {
    dispatch_queue_t queue1 = dispatch_queue_create("com.test.1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("com.test.2", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(queue1, queue2);
    
    dispatch_async(queue1, ^{
        for (int i =0; i < 10; i ++) {
            NSLog(@"1.queue1:%@,%d",[NSThread currentThread], i);
            [NSThread sleepForTimeInterval:0.5];
            if (i == 5) {
                //dispatch_suspend(queue2);
            }
        }
    });
    dispatch_async(queue1, ^{
        for (int i = 0; i < 100; i ++) {
            [NSThread sleepForTimeInterval:0.1];
            NSLog(@"2.queue1:%@,%d",[NSThread currentThread], i);
        }
    });
    dispatch_async(queue2, ^{
        for (int i = 0; i < 100; i ++) {
            [NSThread sleepForTimeInterval:0.1];
            NSLog(@"queue2:%@,%d",[NSThread currentThread], i);
        }
    });
}

- (void)setTargetQueueTwo {
    //1.创建目标队列
    dispatch_queue_t targetQueue = dispatch_queue_create("test.target.queue", DISPATCH_QUEUE_SERIAL);
    
    //2.创建3个串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("test.1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("test.2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("test.3", DISPATCH_QUEUE_SERIAL);
    
    //3.将3个串行队列分别添加到目标队列
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    dispatch_set_target_queue(queue3, targetQueue);
    
    
    dispatch_async(queue1, ^{
        NSLog(@"1 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"1 out");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"2 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"2 out");
    });
    dispatch_async(queue3, ^{
        NSLog(@"3 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"3 out");
    });
}

#pragma mark - Target Action

- (IBAction)segment2Action:(UISegmentedControl *)sender {
    NSLog(@"\n");
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
}

- (IBAction)segmentAction:(UISegmentedControl *)sender {
    NSLog(@"\n");
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

@end
