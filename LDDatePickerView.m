//
//  LDDatePickerView.m
//  demo-DatePicker
//
//  Created by iOS Tedu on 16/8/9.
//  Copyright © 2016年 huaxu. All rights reserved.
//

#import "LDDatePickerView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface LDDatePickerView()
{
    DatePickBlock _block;
}
@property (nonatomic, weak) UIDatePicker *datePicker;
@property (nonatomic, weak) UIView *toolView;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) UIButton *doneBtn;


@end

@implementation LDDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建时间选择器
        [self setupDatePicker];
    }
    return self;
}

/**
 *  创建时间选择器
 */
- (void)setupDatePicker {
    //创建一个时间选择器
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    //设置只显示中文
    [datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    //设置只显示日期
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置时区
    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+0800"]];
    datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker = datePicker;
    [self addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    //创建工具条
    UIView *toolView = [[UIView alloc] init];
    toolView.backgroundColor = Function_Color(238, 238, 238);
    [self addSubview:toolView];
    self.toolView = toolView;
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.datePicker.mas_top).mas_equalTo(0);
    }];
    
    //添加工具条按钮
    UIButton *cancelBtn = [UIButton new];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelBtn sizeToFit];
    CGSize size = cancelBtn.frame.size;
    self.cancelBtn = cancelBtn;
    [self.toolView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *doneBtn = [UIButton new];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [doneBtn sizeToFit];
    size = doneBtn.frame.size;
    self.doneBtn = doneBtn;
    [self.toolView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(0);
    }];
    [doneBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  取消
 */
- (void)cancelClick {
    [UIView animateWithDuration:0.4 animations:^{
        self.datePicker.layer.transform = CATransform3DMakeTranslation(0, 240, 0);
        self.toolView.layer.transform = CATransform3DMakeTranslation(0, 240, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**
 *  完成
 */
- (void)doneClick {
    NSDate *date = self.datePicker.date;
    !_block?:_block(date);
    [self cancelClick];
}

/**
 *  显示时间选择器
 */
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.datePicker.layer.transform = CATransform3DMakeTranslation(0, 240, 0);
    self.toolView.layer.transform = CATransform3DMakeTranslation(0, 240, 0);
    [UIView animateWithDuration:0.4 animations:^{
        self.datePicker.layer.transform = CATransform3DIdentity;
        self.toolView.layer.transform = CATransform3DIdentity;
    }];
}


/**
 *  获得选中的时间
 */
- (void)getDateWithBlock:(DatePickBlock)block {
    _block = [block copy];
}


@end
