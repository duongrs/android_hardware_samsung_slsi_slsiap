ifeq ($(BOARD_HAS_CAMERA),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_C_INCLUDES += \
	frameworks/native/include \
	system/media/camera/include \
	system/core/include \
	external/jpeg \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/../libcamerasensor \
	$(LOCAL_PATH)/../include

LOCAL_SRC_FILES := \
	NXCameraSensor.cpp \
	NXSensorThread.cpp \
	NXCommandThread.cpp \
	NXStream.cpp \
	NXStreamThread.cpp \
	NXZoomController.cpp \
	Exif.cpp \
	NXExifProcessor.cpp \
	ScalerZoomController.cpp \
	PreviewThread.cpp \
	CallbackThread.cpp \
	CaptureThread.cpp \
	RecordThread.cpp \
	NXStreamManager.cpp \
	NXCameraHWInterface2.cpp

LOCAL_SHARED_LIBRARIES := liblog libutils libcutils libnxutil libion-nexell libv4l2-nexell libion libhardware \
	libcamera_client libcamera_metadata libNX_Jpeg libjpeg libNX_Jpeghw

LOCAL_STATIC_LIBRARIES := libcamera-$(TARGET_BOOTLOADER_BOARD_NAME) libcamerasensor

# use system timestamp
LOCAL_CFLAGS += -DUSE_SYSTEM_TIMESTAMP

ifeq ($(TARGET_CPU_VARIANT2),s5p4418)
LOCAL_SRC_FILES += W128BAScalerZoomController.cpp
LOCAL_CFLAGS += -DWORKAROUND_128BYTE_ALIGN
endif

ifeq ($(TARGET_CPU_VARIANT2),s5p6818)
LOCAL_CFLAGS += -DARCH_S5P6818
endif

ANDROID_VERSION_STR := $(subst ., ,$(PLATFORM_VERSION))
ANDROID_VERSION_MAJOR := $(firstword $(ANDROID_VERSION_STR))
ifeq "5" "$(ANDROID_VERSION_MAJOR)"
#@echo This is LOLLIPOP!!!
LOCAL_C_INCLUDES += system/core/libion/include
LOCAL_CFLAGS += -DLOLLIPOP
endif


# use scaler zoom
# LOCAL_CFLAGS += -DUSE_SCALER_ZOOM

LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
# for test
LOCAL_SRC_FILES := test/verify.cpp
LOCAL_SHARED_LIBRARIES := libcutils libutils libv4l2-nexell libion-nexell libion
LOCAL_C_INCLUDES := frameworks/native/include \
	system/core/include \
	$(LOCAL_PATH)/../include
LOCAL_CFLAGS += -DLOG_TAG=\"camera_verify\"

ANDROID_VERSION_STR := $(subst ., ,$(PLATFORM_VERSION))
ANDROID_VERSION_MAJOR := $(firstword $(ANDROID_VERSION_STR))
ifeq "5" "$(ANDROID_VERSION_MAJOR)"
#@echo This is LOLLIPOP!!!
LOCAL_C_INCLUDES += system/core/libion/include
LOCAL_CFLAGS += -DLOLLIPOP
endif

LOCAL_MODULE := camera_verify
LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
# for test
LOCAL_SRC_FILES := test/test-decimator.cpp
LOCAL_SHARED_LIBRARIES := libcutils libutils libv4l2-nexell libion-nexell libion
LOCAL_C_INCLUDES := frameworks/native/include \
	system/core/include \
	$(LOCAL_PATH)/../include
LOCAL_CFLAGS += -DLOG_TAG=\"test-decimator\"

ANDROID_VERSION_STR := $(subst ., ,$(PLATFORM_VERSION))
ANDROID_VERSION_MAJOR := $(firstword $(ANDROID_VERSION_STR))
ifeq "5" "$(ANDROID_VERSION_MAJOR)"
#@echo This is LOLLIPOP!!!
LOCAL_C_INCLUDES += system/core/libion/include
LOCAL_CFLAGS += -DLOLLIPOP
endif

LOCAL_MODULE := test_decimator
LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
# for test
LOCAL_SRC_FILES := test/test-decimator-render.cpp
LOCAL_SHARED_LIBRARIES := libcutils libutils libv4l2-nexell libion-nexell libion
LOCAL_C_INCLUDES := frameworks/native/include \
	system/core/include \
	$(LOCAL_PATH)/../include
LOCAL_CFLAGS += -DLOG_TAG=\"test-decimator\"

ANDROID_VERSION_STR := $(subst ., ,$(PLATFORM_VERSION))
ANDROID_VERSION_MAJOR := $(firstword $(ANDROID_VERSION_STR))
ifeq "5" "$(ANDROID_VERSION_MAJOR)"
#@echo This is LOLLIPOP!!!
LOCAL_C_INCLUDES += system/core/libion/include
LOCAL_CFLAGS += -DLOLLIPOP
endif

LOCAL_MODULE := test_decimator_render
LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)

endif
