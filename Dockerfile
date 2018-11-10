FROM baikangwang/tf_opencv_contrib:gpu_3.5
MAINTAINER Baker Wang <baikangwang@hotmail.com>

### docker respository ###
# reference: https://hub.docker.com/r/davvdg/darkflow-docker
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

# prepare
RUN sudo apt update && apt install -y \
	cython
#
# Yolo - Darkflow
#
RUN cd "/" && \
	git clone https://github.com/thtrieu/darkflow.git &&\
	cd darkflow && \
	pip install . && \
	cd "/" && \
	rm -rf darkflow

CMD ["/bin/bash"]