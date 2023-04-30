# Quantum-OS

## 编译并使用：make -f Makefile run

## 系统简述

- 名字:

    Quantum-OS = 量子OS

- 名字意义:

    "Quantum"的意思是"量子"，意味着这个操作系统的运行速度和量子矩阵传播速度一样快(虽然几乎不可能)，这个系统从2023-1-1日开始正式开发

- 系统桌面:

    ![](./images/Quantum.jpeg)

- 开发者:

    钢锰Q356-CPP

    ![](./images/Me.png)

    bilibili - <https://space.bilibili.com/1226480503?spm_id_from=333.1007.0.0>

- 系统方面实现的东西:
  - 系统引导 - UEFI安全模式
  - 硬件驱动:
    - 键盘 - 驱动
    - 鼠标 - 驱动
    - 硬盘(串口 and 并口) - 驱动
    - 时钟 - 驱动
    - 显卡 - 驱动
    - 网卡 - 驱动 - DHCP协议栈
  - 显示 - 32位真彩色
  - CPU - 多任务调度
  - 内存管理 - 129G以内
  - 文件系统 - NTFS
  - 内存分页
  - 系统调用
  - shell
  - 64位长模式
  - 硬盘容量 - 128PB(GPT分区)

## 是否开源

  为避免特殊影响，本系统将由我一个人开发，不开源

## 特点

- 兼容的编译器
  - ASM(NASM, TASM)
  - GCC(GCC, CLion)
   - 支持C++和C(最新标准)
  - lua
  - JAVA
   - 支持JAVA最新标准
  - Virtual Basic 和 Basic
- 各种小工具
  - 记事本
  - 计算器
  - 绘图
  - 截图工具
  - 写字板
  - 光盘刻录工具
  - 7z,zip,rar等压缩文件解压软件
  - 系统备份工具
- 自己的编程语言：TZX(编译型)
- 兼容的浏览器: Chrome

## Other

- NTFS官网 - <https://www.ntfs.com/ntfs_basics.htm>

- 简介 - <https://www.baidu.com/link?url=0X9BYypEaZ1tqTGNTMu52NiDb22AiWsK8CUhra_-DasvbQAo6Ab-FDWJZxAvfNae&wd=&eqid=a2b23dba005ff8880000000463b2940c>\
         <https://www.cnblogs.com/yet-another-cnblogs-blog/p/16822573.html>
- 参考 - <https://wiki.osdev.org/Beginner_Mistakes>
