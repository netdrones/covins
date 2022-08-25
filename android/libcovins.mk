LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CPP_EXTENSION := .cpp .cc

ROOT_REL := ../
ROOT_ABS := $(LOCAL_PATH)/../
SRC_REL := $(ROOT_REL)/orb_slam3
SRC_ABS := $(ROOT_ABS)/orb_slam3

EIGEN3_INCLUDE_DIR := $(LOCAL_PATH)/../../include/eigen3
COVINS_COMM_INCLUDE_DIR := $(LOCAL_PATH)/../covins_comm/include
COVINS_COMM_SRC := $(SRC_REL)/../covins_comm

LOCAL_C_INCLUDES := \
	$(SRC_ABS) \
	$(SRC_ABS)/include \
	$(SRC_ABS)/include/CameraModels \
	$(SRC_ABS)/../include \
	$(EIGEN3_INCLUDE_DIR) \
	$(COVINS_COMM_INCLUDE_DIR) \
	$(SRC_ABS)/include/comm \
	$(SRC_ABS)/ThirdParty \
	$(SRC_ABS)/../covins_comm/include/covins

# ORB_SLAM3
LOCAL_SRC_FILES := \
	$(SRC_REL)/src/System.cc \
	$(SRC_REL)/src/Tracking.cc \
	$(SRC_REL)/src/LocalMapping.cc \
	$(SRC_REL)/src/LoopClosing.cc \
	$(SRC_REL)/src/ORBextractor.cc \
	$(SRC_REL)/src/ORBmatcher.cc \
	$(SRC_REL)/src/FrameDrawer.cc \
	$(SRC_REL)/src/Converter.cc \
	$(SRC_REL)/src/MapPoint.cc \
	$(SRC_REL)/src/KeyFrame.cc \
	$(SRC_REL)/src/Atlas.cc \
	$(SRC_REL)/src/Map.cc \
	$(SRC_REL)/src/Optimizer.cc \
	$(SRC_REL)/src/Frame.cc \
	$(SRC_REL)/src/KeyFrameDatabase.cc \
	$(SRC_REL)/src/Sim3Solver.cc \
	$(SRC_REL)/src/Initializer.cc \
	$(SRC_REL)/src/ImuTypes.cc \
	$(SRC_REL)/src/G2oTypes.cc \
	$(SRC_REL)/src/CameraModels/Pinhole.cpp \
	$(SRC_REL)/src/CameraModels/KannalaBrandt8.cpp \
	$(SRC_REL)/src/OptimizableTypes.cpp \
	$(SRC_REL)/src/MLPnPsolver.cpp \
	$(SRC_REL)/src/TwoViewReconstruction.cc \

# COVINS
LOCAL_SRC_FILES += \
	$(SRC_REL)/src/comm/communicator.cpp \
	$(COVINS_COMM_SRC)/src/covins_base/communicator_base.cpp \
	$(COVINS_COMM_SRC)/src/covins_base/config_comm.cpp \
	$(COVINS_COMM_SRC)/src/covins_base/utils_base.cpp \
	$(COVINS_COMM_SRC)/src/covins_base/msgs/msg_keyframe.cpp \
	$(COVINS_COMM_SRC)/src/covins_base/msgs/msg_landmark.cpp \

LOCAL_SRC_FILES += \
	$(SRC_REL)/src/md5.c \

LOCAL_STATIC_LIBRARIES := \
    boost_serialization \
	DBoW2 \
	g2o \

LOCAL_SHARED_LIBRARIES := \
    opencv_core \
    opencv_features2d \
    opencv_imgproc \
    opencv_calib3d \
    opencv_video \
    opencv_dnn \
    opencv_flann \

LOCAL_CFLAGS := \
    -Wno-undef \
    -Wno-unused-parameter \
    -Wno-reorder-ctor \
    -Wno-delete-abstract-non-virtual-dtor \
    -Wno-delete-non-abstract-non-virtual-dtor \
    -Wno-shadow \
    -Wno-sign-compare \
    -Wno-deprecated-copy \
    -Wno-deprecated-declarations \
    -Wno-unused-variable \
    -Wno-unused-function \
    -Wno-unused-but-set-variable \
    -Wno-missing-prototypes \

LOCAL_EXPORT_C_INCLUDES := \
	$(SRC_ABS) \
	$(SRC_ABS)/include \
	$(SRC_ABS)/include/CameraModels \
	$(EIGEN3_INCLUDE_DIR) \
	$(COVINS_COMM_INCLUDE_DIR) \
	$(SRC_ABS)/include/comm \
	$(SRC_ABS)/ThirdParty \
	$(ROOT_ABS)/covins_comm/include \

LOCAL_EXPORT_LDLIBS := \
    -llog \

LOCAL_CPP_FEATURES := \
    exceptions \
    rtti \

LOCAL_MODULE := covins

include $(BUILD_STATIC_LIBRARY)