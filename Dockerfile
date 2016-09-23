# BUILD-USING:    docker build -t jasondebolt/base .
# RUN-USING:      docker run --rm -it jasondebolt/base
# To become berkeleyman user, do 'su berkeleyman'

# Pull base image.
FROM buildpack-deps:trusty

RUN apt-get update -qq

# Install Git
RUN apt-get -y install git

# Install Stress
RUN apt-get -y install stress

# Install Python Basics
RUN apt-get install -y python-minimal

# Define default command.
CMD ["bash"]

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes
ENV TERM linux
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# ADD berkeleyman user
RUN useradd berkeleyman
RUN rm -rf ~berkeleyman && cp -a ~root ~berkeleyman && chown -R berkeleyman:berkeleyman ~berkeleyman
