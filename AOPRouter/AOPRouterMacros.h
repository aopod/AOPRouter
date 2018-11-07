//
//  AOPMacros.h
//  AOPRouter
//
//  Copyright © 2017 aopod ( http://www.aopod.com ). All rights reserved.
//

#import "AOPmetamacros.h"

#define aop_metamacro_concat_with_macro0(MACRO,CONTEXT)
#define aop_metamacro_concat_with_macro1(MACRO,CONTEXT,VAL) VAL
#define aop_metamacro_concat_with_macro2(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro1(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro3(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro2(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro4(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro3(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro5(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro4(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro6(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro5(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro7(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro6(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro8(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro7(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro9(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro8(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro10(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro9(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro11(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro10(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro12(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro11(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro13(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro12(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro14(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro13(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro15(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro14(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro16(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro15(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro17(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro16(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro18(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro17(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro19(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro18(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro20(MACRO,CONTEXT,VAL,...) \
    MACRO(CONTEXT,VAL,aop_metamacro_concat_with_macro19(MACRO,CONTEXT,__VA_ARGS__))
#define aop_metamacro_concat_with_macro(MACRO,CONTEXT,...) \
    metamacro_concat(aop_metamacro_concat_with_macro,metamacro_argcount(__VA_ARGS__))(MACRO,CONTEXT,__VA_ARGS__)

#define aop_metamacro_concat_macro_(CONTEXT,A,B) metamacro_concat(A,B)
#define aop_metamacro_concat(...) \
    aop_metamacro_concat_with_macro(aop_metamacro_concat_macro_,,__VA_ARGS__)

#define aop_metamacro_concat_with_sep_macro_(SEP,A,B) metamacro_concat(A##SEP,B)
#define aop_metamacro_concat_with_sep(SEP,...) \
    aop_metamacro_concat_with_macro(aop_metamacro_concat_with_sep_macro_,SEP,__VA_ARGS__)

#define aop_metamacro_concat_with_dot_macro_(CONTEXT,A,B) A.B
#define aop_metamacro_concat_with_dot(...) \
    aop_metamacro_concat_with_macro(aop_metamacro_concat_with_dot_macro_,,__VA_ARGS__)

#define aop_metamacro_concat_with_slash_macro_(CONTEXT,A,B) A/B
#define aop_metamacro_concat_with_slash(...) \
    aop_metamacro_concat_with_macro(aop_metamacro_concat_with_slash_macro_,,__VA_ARGS__)

#ifdef DEBUG
#define _AOPRouterDuplicationCheck(SCHEME,HOST,...) \
    int metamacro_concat(_aop_router$checker$##SCHEME##$##HOST##$,aop_metamacro_concat_with_sep($,__VA_ARGS__)) __attribute((used, section("__DATA,AOPRouterChecker ")));
#define _AOPRouterMissHandlerDuplicationCheck(...) \
    int metamacro_concat(_aop_router$miss_handler$checker$,aop_metamacro_concat_with_sep($,__VA_ARGS__)) __attribute((used, section("__DATA,AOPRouterChecker ")));
#endif

#ifndef _AOPRouterDuplicationCheck
    #define _AOPRouterDuplicationCheck(...)
#endif

#ifndef _AOPRouterMissHandlerDuplicationCheck
    #define _AOPRouterMissHandlerDuplicationCheck(...)
#endif

/**
 Declare a route
 
 @param SCHEME scheme in lowercase
 @param HOST host
 @param ... paths
 */
#define AOPRouterMethodName(SCHEME,HOST,...) \
    property(nonatomic,strong,readonly) NSString *metamacro_concat(SCHEME##_,aop_metamacro_concat_with_sep(_,HOST,##__VA_ARGS__))

/**
 Define an implementation, will do duplication check in DEBUG mode
 
 @param VISIBILITY +/-, stands for public/private access
 @param SCHEME scheme in lowercase
 @param HOST host
 @param ... paths
 */
#define AOPRouterMethodImpl(VISIBILITY,SCHEME,HOST,...) \
    (NSString *)metamacro_concat(SCHEME##_,aop_metamacro_concat_with_sep(_,HOST,##__VA_ARGS__)) { \
        return @#SCHEME "://" #HOST "/" \
        metamacro_stringify(aop_metamacro_concat_with_slash(__VA_ARGS__)); \
    } \
_AOPRouterDuplicationCheck(SCHEME,HOST,##__VA_ARGS__) \
    VISIBILITY (void)route_##SCHEME:(AOPRouterContext *)context aop_metamacro_concat_with_sep($,HOST,##__VA_ARGS__):_

/**
 Define a miss handler, will do duplication check in DEBUG mode
 
 @param SCHEME shceme in lowercase
 @param ... host and paths
 */
#define AOPRouterMissHandler(SCHEME,...) \
    _AOPRouterMissHandlerDuplicationCheck(SCHEME,##__VA_ARGS__) \
    + (BOOL)missHandler:(AOPRouterContext *)context aop_metamacro_concat_with_sep($,SCHEME,##__VA_ARGS__):_

/**
 Get URL string through property (Need to import corresponding class header)
 
 @param PATH Property name specifies a url
 */
#define kAOPRouterPath(PATH) [AOPRouterHandler shared].PATH

/**
 Call `open` method using propery (Need to import corresponding class header)
 
 @param PATH Property name specifies a url
 */
#define AOPRouterOpen(PATH) AOPRouter.open(kAOPRouterPath(PATH))

#define AOPRouterHandleVC self.class context:context

#define AOPRouterDeprecated(REPLCAEMENT) NS_DEPRECATED(1_0,1_0,2_0,2_0,REPLCAEMENT)

