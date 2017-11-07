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


// 1.7    验证旧手机验证码
#define Check_phone  [NSString stringWithFormat:@"%@/User/check_phone",BaseUrl]

// 1.8    确认修改手机
#define Alter_phone  [NSString stringWithFormat:@"%@/User/alter_phone",BaseUrl]

// 2.2    选择项获取分站信息
#define Get_sites  [NSString stringWithFormat:@"%@/QuickGet/get_sites",BaseUrl]

// 选择项行业分类
#define Get_jobs_cate  [NSString stringWithFormat:@"%@/QuickGet/get_company_cate",BaseUrl]

// 选择项职位类别
#define Get_jobs_cate1  [NSString stringWithFormat:@"%@/QuickGet/get_jobs_cate",BaseUrl]

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

// 1.8    修改密码
#define Alter_passwd  [NSString stringWithFormat:@"%@/User/alter_passwd",BaseUrl]

// 6.1    个人信息是否填写过
#define Is_complete  [NSString stringWithFormat:@"%@/User/is_complete",BaseUrl]

// 6.1    首页显示信息
#define Get_ui_info  [NSString stringWithFormat:@"%@/User/get_ui_info",BaseUrl]

// 3.1    获取全部联系人
#define Get_contact  [NSString stringWithFormat:@"%@/Contact/get_contact",BaseUrl]

// 3.2    添加联系人
#define Add_contact  [NSString stringWithFormat:@"%@/Contact/add_contact",BaseUrl]

// 3.2    删除联系人
#define Delete_contact  [NSString stringWithFormat:@"%@/Contact/delete_contact",BaseUrl]

// 3.2    修改联系人
#define Update_contact  [NSString stringWithFormat:@"%@/Contact/update_contact",BaseUrl]

// 2.1    发布职位
#define Post_position  [NSString stringWithFormat:@"%@/Jobs/post_position",BaseUrl]

// 2.2    获取已发布职位
#define Get_position  [NSString stringWithFormat:@"%@/Jobs/get_position",BaseUrl]

// 2.3    获取职位详情
#define Get_position_detail  [NSString stringWithFormat:@"%@/Jobs/get_position_detail",BaseUrl]

// 2.7    刷新职位
#define Refresh_position  [NSString stringWithFormat:@"%@/Jobs/refresh_position",BaseUrl]

// 2.8    职位显示顺序修改
#define Update_order  [NSString stringWithFormat:@"%@/Jobs/update_order",BaseUrl]

// 2.4    修改职位
#define Update_position  [NSString stringWithFormat:@"%@/Jobs/update_position",BaseUrl]


// 2.5    删除职位
#define Delete_position  [NSString stringWithFormat:@"%@/Jobs/delete_position",BaseUrl]

// 2.6    更改职位状态
#define Alter_position_status  [NSString stringWithFormat:@"%@/Jobs/alter_position_status",BaseUrl]

// 5.6    获取热门关键字
#define Get_hot_keyword  [NSString stringWithFormat:@"%@/QuickGet/get_hot_keyword",BaseUrl]

// 4.1    搜索简历
#define Search_resume  [NSString stringWithFormat:@"%@/Resume/search_resume/",BaseUrl]

// 4.2    获取简历详情
#define Resume_detail  [NSString stringWithFormat:@"%@/Resume/resume_detail",BaseUrl]

// 4.3    面试邀请
#define Interview_invite  [NSString stringWithFormat:@"%@/Resume/interview_invite",BaseUrl]

// 1.16	上传头像
#define Upload_company_logo  [NSString stringWithFormat:@"%@/User/upload_company_logo",BaseUrl]


#endif /* UrlFile_h */
