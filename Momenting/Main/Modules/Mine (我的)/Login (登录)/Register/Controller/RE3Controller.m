/**
 * 注册
 * @author xiaobai zhang 2018-12-22 创建文件
 */

#import "RE3Controller.h"
#import "LOGIN_NOTIFICATION.h"
#import "MTUserInfoDefault.h"


#pragma mark - 声明
@interface RE3Controller()

@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UITextField *pass1Field;
@property (weak, nonatomic) IBOutlet UITextField *pass2Field;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passConstraintR;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;

@end


#pragma mark - 实现
@implementation RE3Controller


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:({
        NSString *str;
        if (_index == 0) {
            str = @"注册";
        } else if (_index == 1) {
            str = @"找回密码";
        } else if (_index == 2) {
            str = @"绑定账号";
        }
        str;
    })];
    [self.view setBackgroundColor:kColor_BG];
    [self.nameLab1 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab1 setTextColor:kColor_Text_Black];
    [self.nameLab2 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab2 setTextColor:kColor_Text_Black];
    [self.pass1Field setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.pass1Field setTextColor:kColor_Text_Black];
    [self.pass2Field setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.pass2Field setTextColor:kColor_Text_Black];
    [self buttonCanTap:false];
    [self.pass1Field addTarget:self action:@selector(pass1ValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pass2Field addTarget:self action:@selector(pass2ValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tipLab setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.tipLab setTextColor:kColor_Text_Gary];
    [self.registerBtn.layer setCornerRadius:3];
    [self.registerBtn.layer setMasksToBounds:true];
    
    [self.passConstraintL setConstant:countcoordinatesX(15)];
    [self.passConstraintR setConstant:countcoordinatesX(15)];
    [self.passConstraintH setConstant:countcoordinatesX(45)];
}


#pragma mark - 请求
// 注册
- (void)registerRequest {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.phone, @"account",
                           self.pass1Field.text, @"password", nil];
    [self.view endEditing:true];
    
    NSDictionary *user = @{@"phone":self.phone, @"password" : self.pass1Field.text};
    
    [MTUserInfoDefault saveUser:user];
    [UIView showToastInKeyWindow:@"注册成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}
// 忘记密码
- (void)forgetRequest {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.phone, @"account",
                           self.pass1Field.text, @"password", nil];
    [self.view endEditing:true];
    NSDictionary *user = @{@"phone":self.phone, @"password" : self.pass1Field.text};
    [MTUserInfoDefault saveUser:user];
    [UIView showToastInKeyWindow:@"注册成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
   
}
// 绑定手机
- (void)bindPhoneRequest {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.phone, @"account",
                           self.openid, @"openid",
                           self.pass1Field.text, @"password", nil];
    [self.view endEditing:true];
}


#pragma mark - 点击
// 注册
- (IBAction)registerBtnClick:(UIButton *)sender {
    if (self.index == 0) {
        [self registerRequest];
    } else if (self.index == 1) {
        [self forgetRequest];
    } else if (self.index == 2) {
        [self bindPhoneRequest];
    }
}
// 按钮是否可以点击
- (void)buttonCanTap:(BOOL)tap {
    if (tap == true) {
        [self.registerBtn setUserInteractionEnabled:YES];
        [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [self.registerBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [self.registerBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
        self.registerBtn.backgroundColor = kColor_Main_Color;
    } else {
        [self.registerBtn setUserInteractionEnabled:NO];
        [self.registerBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
        [self.registerBtn setTitleColor:kColor_Text_Gary forState:UIControlStateNormal];
        [self.registerBtn setTitleColor:kColor_Text_Gary forState:UIControlStateHighlighted];
        self.registerBtn.backgroundColor = kColor_Line_Color;
    }
}


- (void)pass1ValueChange:(UITextField *)pass {
    if (pass.text.length > 15) {
        pass.text = [pass.text substringToIndex:14];
    }
    
    if ([_pass1Field.text isEqualToString:_pass2Field.text] && _pass1Field.text.length != 0) {
        [self buttonCanTap:true];
    } else {
        [self buttonCanTap:false];
    }
}
- (void)pass2ValueChange:(UITextField *)pass {
    if (pass.text.length > 15) {
        pass.text = [pass.text substringToIndex:14];
    }
    
    if ([_pass1Field.text isEqualToString:_pass2Field.text] && _pass1Field.text.length != 0) {
        [self buttonCanTap:true];
    } else {
        [self buttonCanTap:false];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
