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
#import "ResultViewController.h"
@interface NewViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *dataArray;
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
        
        _tableView.rowHeight=150;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.title=@"新闻";
    self.view.backgroundColor=[UIColor whiteColor];
   
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"text/plain", nil]];
    [manager GET:@"http://192.168.1.225:8080/st/news/news_list.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *Dic=(NSDictionary *)responseObject;
         [self.view addSubview:self.tableView];
        dataArray= [Dic objectForKey:@"news_list"];
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.225:8080/st/news/news_list.json"]];
//  
//    NSURLSessionConfiguration *confi=[NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session=[NSURLSession sessionWithConfiguration:confi];
//    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"======%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//            
//            [self.view addSubview:self.tableView];
//            
//            NSDictionary *Dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            
//        dataArray= [Dic objectForKey:@"news_list"];
//        });
//    }];
//    [task resume];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = dataArray[indexPath.row];
    if ([[dataArray[indexPath.row] objectForKey:@"images"]count] ==1) {
        
        OneImgTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.oneLabel.text=[dic objectForKey:@"news_title"];
        cell.OneLabel2.text=[dic objectForKey:@"intro"];
        [cell.oneButton setTitle:[dic objectForKey:@"source"] forState:UIControlStateNormal];
        
        NSArray *array=[dic objectForKey:@"images"];
        NSURL *img=[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.225:8080%@",[array [0] objectForKey:@"url"]]];
        [cell.OneImg sd_setImageWithURL:img];

        return cell;
        
    }else if ([[dataArray[indexPath.row] objectForKey:@"images"]count]==2){
        ThreeImgTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell1.threeLabel1.text=[dic objectForKey:@"news_title"];
        [cell1.threeButton setTitle:[dic objectForKey:@"source"] forState:UIControlStateNormal];
        NSArray *array=[dic objectForKey:@"images"];
        NSURL * img1=[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.225:8080%@",[array [0] objectForKey:@"url"]]];
        [cell1.threeImg1 sd_setImageWithURL:img1];
        
        NSURL *img2=[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.225:8080%@",[array [1] objectForKey:@"url"]]];
        [cell1.threeImg2 sd_setImageWithURL:img2];

        return cell1;
        
    }else{
        ThreeImgTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell1.threeLabel1.text=[dic objectForKey:@"news_title"];
        [cell1.threeButton setTitle:[dic objectForKey:@"source"] forState:UIControlStateNormal];
        
        NSArray *array=[dic objectForKey:@"images"];
        NSURL * img1=[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.225:8080%@",[array [0] objectForKey:@"url"]]];
        [cell1.threeImg1 sd_setImageWithURL:img1];
        
        NSURL *img2=[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.225:8080%@",[array [1] objectForKey:@"url"]]];
        [cell1.threeImg2 sd_setImageWithURL:img2];
        
        
        
        NSURL *img3=[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.225:8080%@",[array [2] objectForKey:@"url"]]];
        [cell1.threeImg3 sd_setImageWithURL:img3];
        return cell1;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ResultViewController *resultVC=[[ResultViewController alloc]init];
    resultVC.dataDic=dataArray[indexPath.row];
    
    [self.navigationController pushViewController:resultVC animated:YES];
    
    
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
