//
//  UILabel+AutoSize.m
//  EasyToChat
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "UILabel+AutoSize.h"

@implementation UILabel (AutoSize)
-(void)autoSizeLabelWithStr:(NSString *)text{
    
    CGRect rect=[text boundingRectWithSize:CGSizeMake(self.frame.size.width, 500) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:17]} context:nil];
    self.numberOfLines=0;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width, rect.size.height);
    
}
@end
