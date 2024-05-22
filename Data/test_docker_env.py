import docker
import time
import pytest
import os
from ftplib import FTP
import socket

@pytest.fixture(scope='module')
def docker_client():
    client = docker.from_env()
    return client

@pytest.fixture(scope='module')
def container(docker_client):
    # 构建镜像
    docker_client.images.build(path='./', tag='dockeryolo')

    # 删除已有的容器，避免名称冲突
    try:
        existing_container = docker_client.containers.get('dockeryolo_container')
        existing_container.stop()
        existing_container.remove()
    except docker.errors.NotFound:
        pass

    # 运行容器
    container = docker_client.containers.run(
        'dockeryolo',
        name='dockeryolo_container',
        ports={'21/tcp': 21, '4470/tcp': 4470, '40000/tcp': 40000, '40001/tcp': 40001},
        detach=True
    )

    # 等待服务启动
    time.sleep(20)  # 增加等待时间
    
    yield container

    # 停止和删除容器
    container.stop()
    container.remove()

def test_ftp_anonymous_login(container):
    """测试是否可以使用匿名用户成功登录 FTP 服务器。"""
    ftp = FTP()
    ftp.connect('localhost', 21)
    try:
        response = ftp.login('anonymous', '')  # 尝试以匿名用户登录
        assert '230' in response  # 230 状态码表示登录成功
    finally:
        ftp.quit()

def test_port_4470_service(container):
    """测试端口4470上的服务是否开启。"""
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(5)
    
    try:
        s.connect(('localhost', 4470))  # 尝试连接到端口4470
        s.close()  # 连接成功，关闭套接字
        assert True  # 测试通过
    except socket.error as e:
        pytest.fail(f"无法连接到localhost的4470端口: {e}")
