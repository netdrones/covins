LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

PROJ_ROOT_REL := ../orb_slam3/Thirdparty/g2o
PROJ_ROOT_ABS := $(LOCAL_PATH)/../orb_slam3/Thirdparty/g2o

EIGEN3_INCLUDE_DIR := $(LOCAL_PATH)/../../include/eigen3

LOCAL_C_INCLUDES := \
	$(EIGEN3_INCLUDE_DIR) \

LOCAL_SRC_FILES := \
	$(PROJ_ROOT_REL)/g2o/types/types_sba.cpp \
	$(PROJ_ROOT_REL)/g2o/types/types_six_dof_expmap.cpp \
	$(PROJ_ROOT_REL)/g2o/types/types_seven_dof_expmap.cpp \
	$(PROJ_ROOT_REL)/g2o/core/hyper_graph_action.cpp \
	$(PROJ_ROOT_REL)/g2o/core/hyper_graph.cpp \
	$(PROJ_ROOT_REL)/g2o/core/marginal_covariance_cholesky.cpp \
	$(PROJ_ROOT_REL)/g2o/core/matrix_structure.cpp \
	$(PROJ_ROOT_REL)/g2o/core/batch_stats.cpp \
	$(PROJ_ROOT_REL)/g2o/core/parameter.cpp \
	$(PROJ_ROOT_REL)/g2o/core/cache.cpp \
	$(PROJ_ROOT_REL)/g2o/core/optimizable_graph.cpp \
	$(PROJ_ROOT_REL)/g2o/core/solver.cpp \
	$(PROJ_ROOT_REL)/g2o/core/optimization_algorithm_factory.cpp \
	$(PROJ_ROOT_REL)/g2o/core/estimate_propagator.cpp \
	$(PROJ_ROOT_REL)/g2o/core/factory.cpp \
	$(PROJ_ROOT_REL)/g2o/core/sparse_optimizer.cpp \
	$(PROJ_ROOT_REL)/g2o/core/hyper_dijkstra.cpp \
	$(PROJ_ROOT_REL)/g2o/core/parameter_container.cpp \
	$(PROJ_ROOT_REL)/g2o/core/optimization_algorithm.cpp \
	$(PROJ_ROOT_REL)/g2o/core/optimization_algorithm_with_hessian.cpp \
	$(PROJ_ROOT_REL)/g2o/core/optimization_algorithm_levenberg.cpp \
	$(PROJ_ROOT_REL)/g2o/core/optimization_algorithm_gauss_newton.cpp \
	$(PROJ_ROOT_REL)/g2o/core/jacobian_workspace.cpp \
	$(PROJ_ROOT_REL)/g2o/core/robust_kernel.cpp \
	$(PROJ_ROOT_REL)/g2o/core/robust_kernel_factory.cpp \
	$(PROJ_ROOT_REL)/g2o/core/robust_kernel_impl.cpp \
	$(PROJ_ROOT_REL)/g2o/stuff/timeutil.cpp \
	$(PROJ_ROOT_REL)/g2o/stuff/os_specific.c \
	$(PROJ_ROOT_REL)/g2o/stuff/string_tools.cpp \
	$(PROJ_ROOT_REL)/g2o/stuff/property.cpp \

LOCAL_CPP_FEATURES := \
    exceptions \
    rtti \

LOCAL_ARM_MODE := arm

LOCAL_MODULE := g2o

include $(BUILD_STATIC_LIBRARY)