FROM baikangwang/tf_opencv_contrib:gpu_3.5
MAINTAINER Baker Wang <baikangwang@hotmail.com>

# RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

#
# Yolo V3 & Yolo V2
#
# Get source from github
# git clone https://github.com/opencv/opencv.git /usr/local/src/opencv && \
# git clone https://github.com/opencv/opencv_contrib.git /usr/local/src/opencv_contrib && \
RUN apt update && \
    cd /projects && \
    git clone https://github.com/pjreddie/darknet.git && \
    # Compile
    cd darknet && \
    rm -rf ./.git && \
    GPU=1 CUDNN=1 CUDNN_HALF=1 OPENCV=1 OPENMP=1 make && \
    #
    # Cleanup
    #
    apt clean && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

    CMD ["/bin/bash"]