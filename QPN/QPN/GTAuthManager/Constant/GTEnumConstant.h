//
//  GTEnumConstant.h
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#ifndef GTEnumConstant_h
#define GTEnumConstant_h


typedef enum : NSUInteger {
    URL,
    JSON
} ParameterEncoding;

typedef enum : NSUInteger {
    GT_FINISHED,
    GT_LOADING,
    GT_FAILED
} GTRequestStatus;


#endif /* GTEnumConstant_h */
