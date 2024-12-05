# Ubuntu 22.04 기반 이미지 사용
FROM ubuntu:22.04

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    gdb \
    wget \
    git \
    sudo \
    vim \
    python3 \
    python3-pip \
    socat  # socat 설치 추가

# pwndbg 설치
RUN git clone https://github.com/pwndbg/pwndbg /opt/pwndbg && \
    cd /opt/pwndbg && ./setup.sh

# 사용자 생성
RUN useradd -m -s /bin/bash user && \
    echo "user:user" | chpasswd && \
    usermod -aG sudo user

# pip 및 pwntools 설치
RUN python3 -m pip install --upgrade pip
RUN pip3 install pwntools

# 작업 디렉토리 생성 및 파일 복사
RUN mkdir -p /home/user/Downloads/ctf
COPY ./problem2.c /home/user/Downloads/ctf/problem2.c
COPY ./problem2_1 /home/user/Downloads/ctf/problem2_1
COPY ./README.txt /home/user/Downloads/ctf/README.txt
COPY ./canid.txt /home/user/Downloads/ctf/canid.txt
COPY ./exploit_f.py /home/user/Downloads/ctf/exploit_f.py

# vim에 setuid 비트 설정 (권한 상승을 위한 설정)
RUN chown root:root /usr/bin/vim && chmod u+s /usr/bin/vim

# 파일 권한 설정
RUN chown root:root /home/user/Downloads/ctf/canid.txt && chmod 600 /home/user/Downloads/ctf/canid.txt
RUN chown user:user /home/user/Downloads/ctf/problem2.c /home/user/Downloads/ctf/README.txt /home/user/Downloads/ctf/problem2_1 /home/user/Downloads/ctf/exploit_f.py && \
    chmod 755 /home/user/Downloads/ctf/problem2_1 && \
    chmod 755 /home/user/Downloads/ctf/problem2.c && \
    chmod 755 /home/user/Downloads/ctf/exploit_f.py && \
    chmod 644 /home/user/Downloads/ctf/README.txt

# pwndbg 설정을 자동으로 로드되도록 .gdbinit 파일 생성
RUN echo "source /opt/pwndbg/gdbinit.py" >> /home/user/.gdbinit && \
    echo "source /opt/pwndbg/gdbinit.py" >> /root/.gdbinit

# 초기에는 user 권한으로 실행
USER user
WORKDIR /home/user/Downloads/ctf

EXPOSE 1234
# socat을 사용해 problem2_1을 1234 포트에서 서비스
CMD ["socat", "TCP-LISTEN:1234,reuseaddr,fork", "EXEC:/home/user/Downloads/ctf/problem2_1"]

