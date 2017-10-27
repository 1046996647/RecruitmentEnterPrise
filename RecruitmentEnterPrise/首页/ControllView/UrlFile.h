//
//  UrlFile.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#ifndef UrlFile_h
#define UrlFile_h

// 服务器
#define BaseUrl  @"http://api.52ykjob.com:8080/52dyjob/indexComp.php"

// 调试

// 注册
#define Regist  [NSString stringWithFormat:@"%@/User/regist",BaseUrl]

// 登录
#define Login  [NSString stringWithFormat:@"%@/User/login",BaseUrl]

// 6.1    短信验证码
#define VerifyCode  [NSString stringWithFormat:@"%@/Tool/verify",BaseUrl]

// 1.6    忘记密码
#define Forget_passwd  [NSString stringWithFormat:@"%@/User/forget_passwd",BaseUrl]


// 2.2    选择项获取分站信息
#define Get_sites  [NSString stringWithFormat:@"%@/QuickGet/get_sites",BaseUrl]

// 选择项行业分类
#define Get_jobs_cate  [NSString stringWithFormat:@"%@/QuickGet/get_company_cate",BaseUrl]

// 选择项(个人信息)
#define Get_setting  [NSString stringWithFormat:@"%@/Tool/get_setting",BaseUrl]

// 注册时个人信息
#define Add_company_info  [NSString stringWithFormat:@"%@/User/add_company_info",BaseUrl]

// 修改公司介绍
#define Edit_info  [NSString stringWithFormat:@"%@/User/edit_info",BaseUrl]

// 1.10    企业信息预览
#define Preview_company_info  [NSString stringWithFormat:@"%@/User/preview_company_info",BaseUrl]

// 1.10    获取基本信息
#define Get_company_info  [NSString stringWithFormat:@"%@/User/get_company_info",BaseUrl]

// 1.3    修改基本信息
#define Update_company_info  [NSString stringWithFormat:@"%@/User/update_company_info",BaseUrl]

// 6.1    个人信息是否填写过
#define Is_complete  [NSString stringWithFormat:@"%@/User/is_complete",BaseUrl]

// 6.1    首页显示信息
#define Get_ui_info  [NSString stringWithFormat:@"%@/User/get_ui_info",BaseUrl]

// 1.16	上传头像
#define Upload_company_logo  [NSString stringWithFormat:@"%@/User/upload_company_logo",BaseUrl]


#endif /* UrlFile_h */
