//
//  NewViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "NewViewController.h"
#import "OneImgTableViewCell.h"
#import "ThreeImgTableViewCell.h"
@interface NewViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *dataArray;
    NSDictionary *dic;
    NSDictionary *ImageDic;
}
@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation NewViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"OneImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:@"ThreeImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
        
        _tableView.rowHeight=120;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.title=@"新闻";
    
   
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.171:8080/st/news/news_list.json"]];

    
    NSURLSessionConfiguration *confi=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:confi];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"======%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
            [self.view addSubview:self.tableView];
            
            NSDictionary *Dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
        dataArray= [Dic objectForKey:@"news_list"];
        });
    }];
    [task resume];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    dic=[dataArray objectAtIndex:indexPath.row];
    
    if ([[dic objectForKey:@"images"]count] ==1) {
        
        OneImgTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.oneLabel.text=[dic objectForKey:@"news_title"];
        cell.OneLabel2.text=[dic objectForKey:@"intro"];
        [cell.oneButton setTitle:[dic objectForKey:@"source"] forState:UIControlStateNormal];
        
        NSArray *array=[dic objectForKey:@"images"];
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.171:8080%@",[array [0] objectForKey:@"url"]]]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"%@",data);
            cell.OneImg.image=[UIImage imageWithData:data];
            
        }];
        return cell;
    }else{
        
        ThreeImgTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell1.threeLabel1.text=[dic objectForKey:@"news_title"];
        [cell1.threeButton setTitle:[dic objectForKey:@"source"] forState:UIControlStateNormal];
        
//        NSDictionary *imgDic=[dic1 objectForKey:@"images"];
        
        return cell1;
    }
    return 0;
    
    
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
