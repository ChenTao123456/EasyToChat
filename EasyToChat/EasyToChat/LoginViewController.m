//
//  LoginViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MyViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordText;

- (IBAction)loginButton:(UIButton *)sender;
- (IBAction)registerButton:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title=@"登录";
    
    
    
    
}

- (IBAction)loginButton:(UIButton *)sender { NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:@"http://192.168.1.171:8080/st/s"]];
    
    [request setHTTPMethod:@"post"];
    NSString *bodyStr=[NSString stringWithFormat:@"command=ST_L&name=%@&psw=%@",self.nameTextField.text,self.PasswordText.text];
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSDictionary *infoDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if ([[infoDic objectForKey:@"result"] isEqualToString:@"0"]) {
            NSLog(@"%@",infoDic[@"error"]);
        }else{
            NSUserDefaults *useDefault=[NSUserDefaults standardUserDefaults];
            [useDefault setObject:infoDic[@"access_token"] forKey:@"access_token"];
            
            MyViewController *myView=[[MyViewController alloc]init];
            self.view.window.rootViewController=myView;
            

        }
        
    }];
    
    
}

- (IBAction)registerButton:(UIButton *)sender {
    
    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
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
