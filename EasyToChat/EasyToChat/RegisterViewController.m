//
//  RegisterViewController.m
//  EasyToChat
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 Earl. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ReNameText;
@property (weak, nonatomic) IBOutlet UITextField *RepwTextFirld;
@property (weak, nonatomic) IBOutlet UITextField *SureRePassword;
@property (weak, nonatomic) IBOutlet UITextField *nichengTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)SureRegister:(UIButton *)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=@"注册";
    

}
- (IBAction)SureRegister:(UIButton *)sender {
    
    if ([self.ReNameText.text isEqualToString:@""] &&[self.RepwTextFirld.text isEqualToString:@""] &&[self.SureRePassword.text isEqualToString:@""] &&[self.nichengTextField.text isEqualToString:@""] &&[self.emailTextField.text isEqualToString:@""]) {
        NSLog(@"用户名或密码或昵称或邮箱不能为空");
    }else if (self.SureRePassword.text !=self.RepwTextFirld.text){
        NSLog(@"您输入的两次密码不一致");
    }else if (self.RepwTextFirld.text.length <=3){
        NSLog(@"密码太短");
    }else{
        
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        [request setURL:[NSURL URLWithString:@"http://192.168.1.171:8080/st/s"]];
        [request setHTTPMethod:@"post"];
        
        NSString *bodyStr=[NSString stringWithFormat:@"command=ST_R&name=%@&psw=%@&nickname=%@&email=%@", self.ReNameText.text,self.RepwTextFirld.text,self.nichengTextField.text,self.emailTextField.text];
        [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionConfiguration *confi=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:confi];
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"++++++%@",dic);
                
                if ([[dic objectForKey:@"result"] isEqualToString:@"1"]) {
         
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    NSLog(@"注册失败,用户已存在");
                }

            });
            
        }];
        
        [task resume];
 
    }
 
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
