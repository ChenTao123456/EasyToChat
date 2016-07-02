//
//  MyViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "MyViewController.h"

#define  kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface MyViewController (){
    UIImageView *_img;
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    

    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 50)];
    UIImageView *bgimageView=[[UIImageView alloc]initWithFrame:footView.bounds];
    bgimageView.image=[UIImage imageNamed:@"chatinputbg"];
    [self.view addSubview:footView];
    [footView addSubview:bgimageView];
    
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
      
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]] forState:UIControlStateNormal];
        
        btn.frame=CGRectMake(i*kScreenWidth/4, 0, kScreenWidth/4, 50);
        [footView addSubview:btn];
        
    }
   
    
    
    
}

-(void)btnAction:(UIButton *)button{
    _img.frame=CGRectMake(button.tag*kScreenWidth/5, 0, kScreenWidth/5, 50);
    self.selectedIndex=button.tag;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
