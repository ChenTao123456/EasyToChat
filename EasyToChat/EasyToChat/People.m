//
//  People.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "People.h"

@implementation People
+(People *)getWithDic:(NSDictionary *)Dic{
    
    People *people=[[People alloc]init];
    people.name=[Dic objectForKey:@"name"];
    people.log=[Dic objectForKey:@"email"];
    
    return people;
}
@end
