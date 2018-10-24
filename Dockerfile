FROM baikangwang/tf_opencv_contrib:gpu_3.5
MAINTAINER Baker Wang <baikangwang@hotmail.com>

### docker respository ###
# reference: https://hub.docker.com/r/takuyatakeuchi/yolo-darknet/
#
# run
# $ sudo nvidia-docker run --rm -i -t <new_image_name> /bin/bash
#
# In container,
# $ cd /tmp/darknet
# $ wget wget https://pjreddie.com/media/files/yolov3.weights
# $./darknet detect cfg/yolov3.cfg yolov3.weights data/dog.jpg
#
### docker file ###
# reference: https://github.com/takuya-takeuchi/Demo/blob/master/Dockerfiles/yolo-darknet/9.1-cudnn7-devel-ubuntu16.04/Dockerfile 
#
# RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# config path
RUN LD_LIBRARY_PATH=/usr/local/lib:/usr/lib; export LD_LIBRARY_PATH
RUN ldconfig

#
# Yolo V3 & Yolo V2
#
# Get source from github
RUN cd /projects && \
    git clone https://github.com/pjreddie/darknet.git && \
    # Compile
    cd darknet && \
    sed -ie "s/GPU=0/GPU=1/g" Makefile && \
    sed -ie "s/CUDNN=0/CUDNN=1/g" Makefile && \
    sed -ie "s/OPENCV=0/OPENCV=1/g" Makefile && \
    sed -ie "s/OPENMP=0/OPENMP=1/g" Makefile && \
    make
WORKDIR /projects/darknet

CMD ["/bin/bash"]