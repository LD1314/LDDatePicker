//
//  LDDatePickerView.h
//  demo-DatePicker
//
//  Created by iOS Tedu on 16/8/9.
//  Copyright © 2016年 huaxu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DatePickBlock)(NSDate *date);

@interface LDDatePickerView : UIView

- (void)getDateWithBlock:(DatePickBlock)block;

- (void)show;

@end
