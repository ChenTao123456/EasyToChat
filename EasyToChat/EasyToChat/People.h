//
//  People.h
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *log;

+(People *)getWithDic:(NSDictionary *)Dic;
@end
