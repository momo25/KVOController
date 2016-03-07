//
//  ViewController.m
//  KVOController
//
//  Created by 云冯 on 16/3/7.
//  Copyright © 2016年 冯云. All rights reserved.
//

#import "ViewController.h"
#import "ColorModal.h"
#import <KVOController/FBKVOController.h>
@interface ViewController ()
@property (nonatomic,strong)ColorModal * colorModal;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,strong) FBKVOController * KVOController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.KVOController=[FBKVOController controllerWithObserver:self];
    self.colorModal=[[ColorModal alloc]init];
    [self.KVOController observe:_colorModal keyPath:@"colorString" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionInitial block:^(id observer, id object, NSDictionary *change) {
#pragma mark-发现值发生变化后
        [self changeBackGroundColor];
    }];
    /*
    系统kvo方法
    [self.colorModal addObserver:self forKeyPath:@"colorString" options:NSKeyValueObservingOptionNew context:nil];
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chaneColor) name:UITextFieldTextDidChangeNotification object:nil];
}
/*
 系统KVO 必走的方法，需要去实现
 -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
 {
    [self changeBackGroundColor];
 } 
 */

-(void)chaneColor{
    self.colorModal.colorString=self.textField.text;
}
-(void)changeBackGroundColor{
    if([self.colorModal.colorString isEqualToString:@"red"]){
        self.view.backgroundColor=[UIColor redColor];
    }else if ([self.colorModal.colorString isEqualToString:@"green"]){
        self.view.backgroundColor=[UIColor greenColor];
    }else if ([self.colorModal.colorString isEqualToString:@"black"]){
        self.view.backgroundColor=[UIColor blackColor];
    }else
    {
        self.view.backgroundColor=[UIColor whiteColor];
    }
}

- (void)dealloc
{
    [self.KVOController unobserve:self keyPath:@"colorString"];
    [self.colorModal removeObserver:self forKeyPath:@"colorString"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
