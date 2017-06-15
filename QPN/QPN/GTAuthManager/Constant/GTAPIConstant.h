//
//  GTAPIConstant.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#ifndef GTAPIConstant_h
#define GTAPIConstant_h


// Site's API

//#define BASE_URL @"http://45.55.184.52"
#define BASE_URL @"http://qpn.qa"
#define API_SIGNUP @"/api/v1/sign_up"
#define API_LOGIN @"/api/v1/login"
#define API_SMS_CODE_APPROVAL  @"/api/v1/sms_approval"
#define API_USER_APPROVED @"/api/v1/is_sms_approved"
#define API_USER_AUTHENTICATE @"/api/v1/authenticate"
#define API_USER_INFO @"/api/v1/user"
#define API_USER_LOGOUT @"/api/v1/logout"
#define API_USER_UPDATE @"/api/v1/user/update"

#define API_CREATE_POST @"/api/v1/posts"
#define API_LIKE_POST @"/api/v1/posts"
#define API_UNLIKE_POST @"/api/v1/posts"
#define API_ADD_COMMENT_POST @"/api/v1/posts"
#define API_DELETE_POST @"/api/v1/posts"
#define API_EDIT_POST @"/api/v1/posts"
#define API_GET_ALL_COMMENTS_POST @"/api/v1/posts"

#define API_GET_TIMELINE_POST @"/api/v1/posts"
#define API_GET_NEWS_FEED_POST @"/api/v1/news_feed_posts"

#define API_SEARCH_POST @"/api/v1/search"

#define API_USER_GETCOUNTRY @"/api/v1/countries"
#define API_USER_GET_INDUSTERIES @"/api/v1/industries"

#define API_USER_GET_EDUCATIONS @"/api/v1/educations"
#define API_USER_UPDATE_EDUCATIONS @"/api/v1/educations"

#define API_USER_GET_EXPERINCES @"/api/v1/experiences"
#define API_UPDATE_USER_EXPERINCES @"/api/v1/experiences"
#define API_USER_GET_ACHIEVEMENTS @"/api/v1/achievements"
#define API_UPDATE_USER_ACHIEVEMENTS @"/api/v1/achievements"
#define API_USER_GET_SKILLS @"/api/v1/skills"
#define API_UPDATE_USER_SKILLS @"/api/v1/skills"

#define API_USER_SET_EDUCATIONS @"/api/v1/educations"
#define API_USER_SET_EXPERINCES @"/api/v1/experiences"
#define API_USER_SET_ACHIEVEMENTS @"/api/v1/achievements"
#define API_USER_SET_SKILLS @"/api/v1/skills"


#define API_DEL_AVATAR @"/api/v1/destroy/avatar"
#define API_DEL_COVER @"/api/v1/destroy/cover_img"
#define API_DEL_VIDEO @"/api/v1/destroy/video"


#define API_USER_GET_COUNTRY_DCODE @"/api/v1/country_code"




#endif /* GTAPIConstant_h */
