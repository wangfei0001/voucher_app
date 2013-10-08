//
//  BaseController.m
//  voucher
//
//  Created by fei wang on 13-8-23.
//  Copyright (c) 2013年 fei wang. All rights reserved.
//

#import "BaseController.h"

#import "MapController.h"

#import "Voucher.h"

#import "UIImageView+AFNetworking.h"


@interface BaseController (){
    
    BOOL voucherViewMoving;
    
    Voucher *voucher;
    
    UIImageView *notFoundImageView;

}

@end

@implementation BaseController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor redColor];
    
    self.appDelegate = APP_DELEGATE;
    
    voucherViewMoving = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 填充数据
*/
- (void)fillData: (id)data
{
    voucher = [[Voucher alloc] initWithData:data];
    
    id merchant = [data objectForKey:@"merchant"];
    
    self.voucherView.merchantName.text = [merchant objectForKey:@"company"];
    
    self.voucherView.voucherTitle.text = [data objectForKey:@"name"];
    
    NSURL *url = [NSURL URLWithString:@"http://voucher/uploads/logo/1.jpeg"];
    [self.voucherView.merchantLogo setImageWithURL:url placeholderImage:nil];
    /*
     * 更新是否属于收藏
     */
    id id_favourite = [data objectForKey:@"id_favourite"];
    if(id_favourite && [id_favourite boolValue] == YES){
        [self.voucherView updateView:YES];
    }
    
    [Api getVoucherDetail:[[data objectForKey:@"id_voucher"] intValue]
                  success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
                      
                      //update UI
                      if(!voucher.reusable){
                          self.voucherView.redeemBut.hidden = NO;
                      }
                  }];
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"");
//}

- (void)showVoucherView: (id)data
{
    if(voucherViewMoving) return;
    
    voucherViewMoving = YES;
    
    self.voucherView = (VoucherView *)[[[NSBundle mainBundle] loadNibNamed:@"VoucherView" owner:self options:nil] objectAtIndex:0];
    
    
    
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    
    CGRect oriRect = CGRectMake(320, statusBarHeight, 320, self.appDelegate.window.frame.size.height - statusBarHeight);
    
    self.voucherView.frame = oriRect;
    
    //fill data
    [self fillData: data];
    

    //[[self.appDelegate window] addSubview:self.voucherView];
    [self.tabBarController.view addSubview:self.voucherView];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGRect finalRect = self.voucherView.frame;
                         finalRect.origin.x = 0;
                         [self.voucherView setFrame:finalRect];
                     }
                     completion:^(BOOL finished) {
                         voucherViewMoving = NO;
                     }];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0){     

    }else if(buttonIndex == 1){   

    }else if(buttonIndex == 2){     //新浪
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kRedirectURI;
        request.scope = @"all";
        request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        [WeiboSDK sendRequest:request];
    }else if(buttonIndex == 3){
        if(self.appDelegate.qqwbapi == nil)
        {
            self.appDelegate.qqwbapi = [[WeiboApi alloc]initWithAppKey:QQWeiboAppKey andSecret:QQWeiboAppSecret andRedirectUri:QQWeiboRedirectURI] ;
        }
        [self.appDelegate.qqwbapi loginWithDelegate:self andRootController:self];
    }else{                          //cancel
        [actionSheet dismissWithClickedButtonIndex:4 animated:YES];
    }
    
}

#pragma Voucher Cell delegate
-(void)merchantClick: (id)sender merchantId: (int)merchantId
{
    NSLog(@"merchant id = %d", merchantId);
    [self performSegueWithIdentifier:@"ShowMerchant" sender:self];
}

#pragma Voucher View delegate 

-(void)shareClick: (id)sender
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"微信给好友"
                                  otherButtonTitles:@"Facebook", @"新浪微博", @"腾讯微博", nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)favouriteClick: (id)sender
{

    [self.appDelegate ShowLoading:self.voucherView];
    if(![voucher isMyFavourite]){
        [Api addFavouriteVocher:voucher.id success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
            voucher.id_favourite = [JSON intValue];
            [self.voucherView updateView:YES];
            [self.appDelegate HideLoading];
        }];
    }else{
        [Api removeFavouriteVocher:voucher.id_favourite success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
            voucher.id_favourite = 0;
            [self.voucherView updateView:NO];
            [self.appDelegate HideLoading];
        }];
    }
}

- (void)showMerchantOnMapClick:(id)sender
{
    [self performSegueWithIdentifier:@"ShowMerchantOnMap" sender:self];
}

- (void)redeemVoucherClick:(id)sender
{
    NSLog(@"test");
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMerchantOnMap"])
    {
        MapController *vc = [segue destinationViewController];
        
        
        vc.startCoord = [[voucher.merchant.addresses objectAtIndex:0] getCoordinate2D];
    }
}

#pragma mark 没有找到Voucher显示/移除提示

- (void)showNotFound
{
    if(!notFoundImageView){
        UIImage *image = [UIImage imageNamed:@"404.png"];
        notFoundImageView = [[UIImageView alloc] initWithImage:image];
    }
    [self.mainTable addSubview:notFoundImageView];
}

- (void)hideNotFound
{
    [notFoundImageView removeFromSuperview];
}


#pragma mark WeiboAuthDelegate

/**
 * @brief   重刷授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthRefreshed:(WeiboApi *)wbapi_
{
    
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r", wbapi_.accessToken, wbapi_.openid, wbapi_.appKey, wbapi_.appSecret];
    
    NSLog(@"result = %@",str);
    
    [self.appDelegate showAlert:str];
    
}

/**
 * @brief   重刷授权失败后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthRefreshFail:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    [self.appDelegate showAlert:str];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
 * @return  无返回
 */
- (void)DidAuthFinished:(WeiboApi *)wbapi_
{
    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r", wbapi_.accessToken, wbapi_.openid, wbapi_.appKey, wbapi_.appSecret];
    
    NSLog(@"result = %@",str);
    
    [self.appDelegate showAlert:str];
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   wbapi   weiboapi 对象，取消授权后，授权信息会被清空
 * @return  无返回
 */
- (void)DidAuthCanceled:(WeiboApi *)wbapi_
{
    
}

/**
 * @brief   授权成功后的回调
 * @param   INPUT   error   标准出错信息
 * @return  无返回
 */
- (void)DidAuthFailWithError:(NSError *)error
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    
    [self.appDelegate showAlert:str];
}


@end
