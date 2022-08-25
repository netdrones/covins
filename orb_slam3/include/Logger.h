// Copyright 2022 NetDrones Inc. All rights reserved.

#pragma once

#if defined(__ANDROID__)

#include <android/log.h>

#define ANDROID_LOG_TAG "covins"

#define  LOGV(format, ...)  __android_log_print(ANDROID_LOG_VERBOSE, ANDROID_LOG_TAG , "[%s:%d/%s] " format, basename(__FILE__), __LINE__, __FUNCTION__, ##__VA_ARGS__)
#define  LOGD(format, ...)  __android_log_print(ANDROID_LOG_DEBUG, ANDROID_LOG_TAG , "[%s:%d/%s] " format, basename(__FILE__), __LINE__, __FUNCTION__, ##__VA_ARGS__)
#define  LOGI(format, ...)  __android_log_print(ANDROID_LOG_INFO, ANDROID_LOG_TAG , "[%s:%d/%s] " format, basename(__FILE__), __LINE__, __FUNCTION__, ##__VA_ARGS__)
#define  LOGW(format, ...)  __android_log_print(ANDROID_LOG_WARN, ANDROID_LOG_TAG , "[%s:%d/%s] " format, basename(__FILE__), __LINE__, __FUNCTION__, ##__VA_ARGS__)
#define  LOGE(format, ...)  __android_log_print(ANDROID_LOG_ERROR, ANDROID_LOG_TAG , "[%s:%d/%s] " format, basename(__FILE__), __LINE__, __FUNCTION__, ##__VA_ARGS__)

#else

#include <cstdio>

#define  LOGV(format, ...)
#define  LOGD(format, ...)
#define  LOGI(format, ...)
#define  LOGW(format, ...)
#define  LOGE(format, ...)

#endif