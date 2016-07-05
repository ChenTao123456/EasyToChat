//
//  FileViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "FileViewController.h"
#import "CustomCollectionViewCell.h"
@interface FileViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UIScrollView *_scrollView;
    
    NSDictionary *Dicss;
}
@property (nonatomic ,strong)UICollectionView *collectionView;

@end

@implementation FileViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.view.backgroundColor=[UIColor whiteColor];
   
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    flowLayout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
   

    NSArray *segArray=[[NSArray alloc]initWithObjects:@"公共资源",@"个人资源", nil];
    UISegmentedControl *segmentedControl=[[UISegmentedControl alloc]initWithItems:segArray];
    
    segmentedControl.frame=CGRectMake(0, 0, 200, 30);
    segmentedControl.selectedSegmentIndex=0;

    [segmentedControl addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
     [self.navigationController.navigationBar.topItem setTitleView:segmentedControl];
   
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"download_button@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem=right;
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *string= [userDefault objectForKey:@"access_token"];
    
    NSString *Str=[NSString stringWithFormat:@"http://192.168.1.225:8080/st/s?command=ST_F_FL&access_token=%@",string];

    
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes=[manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"text/html", nil]];
        [manager GET:Str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic=(NSDictionary *)responseObject;
            //        NSLog(@"++++%@",dic);
            
            Dicss=[dic objectForKey:@"filelist"];
            
            NSLog(@"***%@",Dicss);
             [self.view addSubview:self.collectionView];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    
    
    NSLog(@"======%@",Dicss);

}

-(void)segAction:(UISegmentedControl *)seg{
   
//    公共资源
    if (seg.selectedSegmentIndex==0) {
        NSLog(@"0000");
       
        
        
    }else{
        //            个人资源
        NSLog(@"11111");
    }
    
 
}

-(void)rightAction:(UIBarButtonItem *)right{
    
}

#pragma mark-UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[Dicss objectForKey:@"pub_file"]count];
}

//每个UICollectionView展示的内容
- (CustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *cellidentifier=@"cell";
    CustomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellidentifier forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
 
    NSArray *pubArray=[Dicss objectForKey:@"pub_file"];
    NSString *Str= [pubArray[indexPath.row] objectForKey:@"image_url"];
    NSURL *url=[NSURL URLWithString:Str];
    [cell.CustomIMG sd_setImageWithURL:url];
    
    NSString *Strlabel=[pubArray [indexPath.row]objectForKey:@"name"];
    cell.CustomLabel.adjustsFontSizeToFitWidth=YES;
    cell.CustomLabel.text=Strlabel;
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }

    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    int dex=(kScreenWidth-180)/4;
    return UIEdgeInsetsMake(dex,dex,dex,dex);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    cell.backgroundColor = [UIColor greenColor];
    NSLog(@"item======%ld",indexPath.item);
    NSLog(@"row=======%ld",indexPath.row);
    NSLog(@"section===%ld",indexPath.section);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 100);
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
