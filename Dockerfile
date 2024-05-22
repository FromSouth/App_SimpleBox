FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install -y xinetd gcc-multilib g++-multilib build-essential vsftpd &&\
    useradd -m xxyolo &&\
    useradd -m user && echo "user:password" | chpasswd &&\
    mkdir /home/ftp && chown nobody:nogroup /home/ftp

COPY ./Data/xxyolo_xinet.conf /etc/xinetd.d/xxyolo
COPY ./Data/vsftpd.conf /etc/vsftpd.conf
COPY ./Data/xxyolo /home/xxyolo
COPY ./Data/xxyolo /home/ftp
COPY ./Data/libc.so.6 /home/xxyolo
COPY ./Data/libc.so.6 /home/ftp
COPY ./Data/flag.txt /home/xxyolo/flag.txt

RUN chown xxyolo:xxyolo /home/xxyolo/xxyolo /home/xxyolo/libc.so.6 &&\
    chown nobody:nogroup /home/ftp/xxyolo /home/ftp/libc.so.6 &&\
    chmod 555 /home/xxyolo/xxyolo /home/xxyolo/libc.so.6 &&\
    chmod 777 /home/ftp/xxyolo /home/ftp/libc.so.6 &&\
    chmod 444 /home/xxyolo/flag.txt &&\
    echo "xxyolo" | tee -a /etc/vsftpd.userlist &&\
    chmod u+s /bin/cp

EXPOSE 21 4470 40000-40100

CMD ["bash", "-c", "service vsftpd start && xinetd -dontfork"]
