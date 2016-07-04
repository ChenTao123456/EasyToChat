//
//  ThreeImgTableViewCell.h
//  EasyToChat
//
//  Created by mac on 16/7/2.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeImgTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *threeImg1;
@property (weak, nonatomic) IBOutlet UIImageView *threeImg2;
@property (weak, nonatomic) IBOutlet UIImageView *threeImg3;


@property (weak, nonatomic) IBOutlet UILabel *threeLabel1;

@property (weak, nonatomic) IBOutlet UIButton *threeButton;

@end
