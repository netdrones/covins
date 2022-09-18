LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

PROJ_ROOT_REL := ../orb_slam3/Thirdparty/DBoW2
PROJ_ROOT_ABS := $(LOCAL_PATH)/../orb_slam3/Thirdparty/DBoW2

LOCAL_C_INCLUDES := \
	$(PROJ_ROOT_ABS)

LOCAL_SRC_FILES := \
	$(PROJ_ROOT_REL)/DBoW2/BowVector.cpp \
	$(PROJ_ROOT_REL)/DBoW2/FORB.cpp \
	$(PROJ_ROOT_REL)/DBoW2/FeatureVector.cpp \
	$(PROJ_ROOT_REL)/DBoW2/ScoringObject.cpp \
	$(PROJ_ROOT_REL)/DUtils/Random.cpp \
	$(PROJ_ROOT_REL)/DUtils/Timestamp.cpp \

LOCAL_STATIC_LIBRARIES := \
	boost_system \
	boost_serialization \

LOCAL_SHARED_LIBRARIES := \
	opencv_core \

LOCAL_CPP_FEATURES := \
    exceptions \
    rtti \

LOCAL_ARM_MODE := arm

LOCAL_MODULE := DBoW2

include $(BUILD_STATIC_LIBRARY)