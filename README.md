# 郑州大学汇编语言实验 2026

## 关于平台
正常开启时xfce桌面未完全启动，需要Terminal手动输入
``` bash 
xfwm4 --replace &
```
将仓库拉取到本地,拷贝到检测目录
``` bash
ssh-keygen
apt update && apt install git
git clone https://github.com/baiyunquan/ZZUGAS.git
cd ZZUGAS
cp ./ZZUGAS ~/Desktop/ZZUassembly
```

## 关于实验
评测的预处理会删除换行符并全部小写，所以看到未换行和大小写不同不必惊慌；直接把要求的结果复制一份，然后printf输出。（~~面向结果编程~~)

#### 碎碎念
似乎是阿里云的ECS？source.list用的是阿里云镜像。

``` bash 
root@cg:/mnt/cgshare/ZZUGAS# ls /etc/ | grep release
lsb-release
os-release
root@cg:/mnt/cgshare/ZZUGAS# cat /proc/version 
Linux version 5.14.0-162.12.1.el9_1.0.2.x86_64 (mockbuild@dal1-prod-builder001.bld.equ.rockylinux.org) (gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2), GNU ld version 2.35.2-24.el9) #1 SMP PREEMPT_DYNAMIC Mon Jan 30 22:14:42 UTC 2023
root@cg:/mnt/cgshare/ZZUGAS# cat /etc/lsb-release 
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.6 LTS"
root@cg:/mnt/cgshare/ZZUGAS# cat /etc/os-release 
NAME="Ubuntu"
VERSION="16.04.6 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.6 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```

神秘Ubuntu 16.04，用着5.14.0 kernel，~~完全可以升级到Ubuntu 22.04~~;根证书过期了，浏览器使用不了HTTPS，基本什么网页都访问不了。

前人进行的操作:[History](./Demo/history.txt)
可惜Unix like系统的会绝对贯彻用户操作，没有回收站，~~要不直接还原出答案~~。