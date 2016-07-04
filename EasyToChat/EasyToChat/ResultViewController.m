//
//  ResultViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "ResultViewController.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
#import "ThreeTableViewCell.h"
#import "UILabel+AutoSize.h"
#import "NSString+AutoSizeString.h"

@interface ResultViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSDictionary *dataDic123;
    
}
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation ResultViewController

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, kScreenHeight-108) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_tableView registerNib:[UINib nibWithNibName:@"OneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
        [_tableView registerNib:[UINib nibWithNibName:@"TwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell2"];
        [_tableView registerNib:[UINib nibWithNibName:@"ThreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell3"];
        

    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=[self.dataDic objectForKey:@"channel"];
    
    NSString *source_url=[self.dataDic objectForKey:@"source_url"];
    
    
    
    NSString *Str=[NSString stringWithFormat:@"http://192.168.1.171:8080%@",source_url];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:Str]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue  mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        [self.view addSubview:self.tableView];
        dataDic123=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dataDic123 allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (section==0) {
        return 1;
    }else if (section==1){
        
        return [[dataDic123 objectForKey:@"data"]count];
    }else{
        return [[dataDic123 objectForKey:@"comments"]count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        OneTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        NSDictionary *infoDic=[dataDic123 objectForKey:@"info"];
        cell1.OneTitle.text=[infoDic objectForKey:@"news_title"];
        cell1.OneLabel1.text=[infoDic objectForKey:@"source"];
        cell1.OneLabel2.text=[infoDic objectForKey:@"auther"];
        cell1.OneLabel3.text=[infoDic objectForKey:@"time"];
        return cell1;
    }
    
    if (indexPath.section==1) {
        TwoTableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        NSArray *dataAr=[dataDic123 objectForKey:@"data"];
        if ([[[dataAr objectAtIndex:indexPath.row] objectForKey:@"data_type"] isEqualToString:@"2"]) {
            
            NSDictionary *d=[[dataAr objectAtIndex:indexPath.row]objectForKey:@"image"];
            
            NSURL *urlStr=[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.171:8080%@",[d objectForKey:@"source"]]];
            [cell2.TwoIMG sd_setImageWithURL:urlStr];
            
        }else{
       
            cell2.textLabel.text=[[dataAr objectAtIndex:indexPath.row] objectForKey:@"content"];
            [cell2.textLabel autoSizeLabelWithStr:cell2.textLabel.text];
        }
        return cell2;
        
    }else{
        NSArray *commentsArray=[dataDic123 objectForKey:@"comments"];
        ThreeTableViewCell *cell3=[tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell3.ThreeLabel.text= [commentsArray[indexPath.row] objectForKey:@"name"];
        cell3.ThreeLabel1.text=[commentsArray[indexPath.row]objectForKey:@"info"];
        
        [cell3.ThreeLabel autoSizeLabelWithStr:cell3.ThreeLabel.text];
        [cell3.ThreeLabel1 autoSizeLabelWithStr:cell3.ThreeLabel1.text];
        
        return cell3;
    }

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
   
    if (section==1) {
       
        NSDictionary *introDic=[dataDic123 objectForKey:@"info"];
        NSString *introStr=[introDic objectForKey:@"intro"];
       
        
        return introStr;
    }
    return   nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 130;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 60;
    }else if (indexPath.section==2){
        return 100;
    }
    return 200;
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
