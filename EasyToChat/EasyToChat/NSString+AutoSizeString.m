//
//  NSString+AutoSizeString.m
//  EasyToChat
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "NSString+AutoSizeString.h"

@implementation NSString (AutoSizeString)

-(CGRect)autoSizeWith:(NSString *)Str{
    
    CGRect rect=[Str boundingRectWithSize:CGSizeMake(kScreenWidth, 500) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:17]} context:nil];
    
    return rect;
}

@end
