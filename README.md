# Softcenter for AARCH64

本软件中心是基于hnd/axhnd平台路由器的软件中心,仅适用于linux内核为4.1.27/4.1.51的armv8架构（aarch64）的路由器！

## 兼容机型

支持的机型：
1. 华硕hnd：`RT-AC86U` `GT-AC5300` `GT-AC2900` `RT-AX68U` `RT-AX86U` `RT-AX88U` `GT-AX11000` `GT-AXE11000` 
3. 网件：`R8000P` `R7900P` `RAX80` `RAX200` 

## 开发须知：

如果你是开发者，想要开发新的插件，并用离线包的方式进行传播，请了解以下内容：

1. 在程序方面：由于固件采用了版本为4.1.27/4.1.51的linux内核，和armv8的编译器，所以请确保你编译的程序是armv8架构的。
2. [工具链等](https://github.com/SWRT-dev/softcenter_tools)
3. 因为本软件中心同时支持了ROG和非ROG两种不同皮肤的固件，所以插件的制作需要考虑到两个不同风格的UI，建议可以用css或者定制不同的asp文件，但是后台脚本而二进制保持一致。

**软件中心各架构列表：**

|  软件中心   |                        mips软件中心                        |                 arm软件中心                  |                      arm64软件中心                       |                    armng软件中心                    |            mipsle软件中心             |
| :---------: | :----------------------------------------------------------: | :---------------------------------------------: | :----------------------------------------------------------: | :-----------------------------------------------: |:-----------------------------------------------: |
|  项目名称   | [softcenter](https://github.com/SWRT-dev/softcenter) | [softcenterarm](https://github.com/SWRT-dev/softcenterarm) |       [softcenterarm64](https://github.com/SWRT-dev/softcenterarm64)        | [softcenterarmng](https://github.com/SWRT-dev/softcenterarmng) |[softcentermipsle](https://github.com/SWRT-dev/softcentermipsle) |
|  适用架构   |                            mips                            |                     armv7l                      |                       aarch64                     |                        armv7l                        |                mipsle             |
|  linux内核  |               3.10.104                |                2.6.36.4             |             4.1.x            |             4.x.x/3.x.x            |         3.10.14          |
|     CPU     |                          grx500                           |                    bcm4708/9                    |                          bcm490x                           |                     [bcm675x][ipq4/5/6/80xx][mt7622/3/9]                    |               mtk7621              |
|     FPU     |                          soft                          |                    no                    |                         hard                           |                     hard                     |               soft              |
|  固件版本   |                    MerlinR 5.0.0+                     |              MerlinR 5.0.0+              |                     MerlinR 5.0.0+                      |                  MerlinR 5.0.0+                    |                MerlinR 5.0.0+                    |
| 软件中心api |                          **1.1/1.5** 代                          |                   **1.1/1.5** 代                    |                          **1.1/1.5** 代                          |                    **1.1/1.5** 代                     |                **1.1/1.5** 代                     |
| 代表机型-1  | [BLUECAVE](https://github.com/SWRT-dev/bluecave-asuswrt) |              [RT-AC68U](https://github.com/SWRT-dev/rtac68u)               | [RT-AC86U](https://github.com/SWRT-dev/86u-asuswrt) |                         [TUF-AX3000](https://github.com/SWRT-dev/tuf-ax3000)                        |          [RT-AC85P](https://github.com/SWRT-dev/ac85p-asuswrt) | 
| 代表机型-2  | [K3C](https://github.com/SWRT-dev/K3C-merlin) |              [K3](https://github.com/SWRT-dev/K3-merlin.ng)              | [GT-AC2900](https://github.com/SWRT-dev/gt-ac2900) |                         [RT-AX58U](https://github.com/SWRT-dev/rt-ax58u)                        |         RT-ACRH26
| 代表机型-3  | [RAX40](https://github.com/SWRT-dev/rax40-asuswrt) |         [SBRAC1900P](https://github.com/SWRT-dev/sbrac1900p)                                        | [R8000P](https://github.com/SWRT-dev/r8000p) |                        [RT-AX89X](https://github.com/SWRT-dev/rtax89x)                         |         TUF-AC1750         |
| 代表机型-4  | DIR2680 |  [RT-AC5300](https://github.com/SWRT-dev/rt-ac5300)                              | RAX80 |                       [RT-ACRH17](https://github.com/SWRT-dev/acrh17-asuswrt)                         |            [RM-AC2100](https://github.com/SWRT-dev/ac85p-asuswrt)              |


