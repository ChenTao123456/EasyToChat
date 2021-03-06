//
//  MainViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "MainViewController.h"
#import "People.h"
#import "ChatTableViewCell.h"
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
        [_tableView registerNib:[UINib nibWithNibName:@"ChatTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title=@"主页";
    
    peopleArray=[[NSMutableArray alloc]init];
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
   NSString *accessToken= [userdefaults objectForKey:@"access_token"];
    
    NSString *url=[NSString stringWithFormat:@"http://192.168.1.225:8080/st/s?command=ST_FL&access_token=%@",accessToken];
    NSURL *urlStr=[NSURL URLWithString:url];
    NSURLRequest *request=[NSURLRequest requestWithURL:urlStr];
    
    NSURLSessionConfiguration *confi=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:confi];
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"====%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
            peopleArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"%@",peopleArray);
        });
    }];
    
    [task resume];
    
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return peopleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic=[peopleArray objectAtIndex:indexPath.row];
    cell.MainName.text=[dic objectForKey:@"name"];
    cell.MainShuoShuo.text=@"说说：其实就是一个心情，时好时坏";
    cell.MainIMG.image=[UIImage imageNamed:@"head"];
    

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
