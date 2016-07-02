//
//  MainViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "MainViewController.h"
#import "People.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *peopleArray;
}
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation MainViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
    
    peopleArray=[[NSMutableArray alloc]init];
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
   NSString *accessToken= [userdefaults valueForKey:@"accessToken"];
    
    NSString *url=[NSString stringWithFormat:@"http://IP:Port/st/scommand=ST_FL&access_token=%@",accessToken];
    NSURL *urlStr=[NSURL URLWithString:url];
    NSURLRequest *request=[NSURLRequest requestWithURL:urlStr];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"====%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
        peopleArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
    }];
    
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return peopleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    NSDictionary *peopleDic=[peopleArray objectAtIndex:indexPath.row];
    
    People *people=[People getWithDic:peopleDic];
    cell.textLabel.text=people.nickName;
    cell.detailTextLabel.text=people.email;
    
    
    return cell;
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
