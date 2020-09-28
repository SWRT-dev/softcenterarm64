# Softcenter for AARCH64

本软件中心是基于hnd/axhnd平台路由器的软件中心,仅适用于linux内核为4.1.27/4.1.51的armv8架构（aarch64）的路由器！

## 兼容机型

支持的机型：
1. 华硕hnd：`RT-AC86U` `GT-AC5300` `GT-AC2900`
2. 华硕axhnd：`RT-AX88U` `GT-AX11000` 
3. 网件：`R8000P` `R7900P` `RAX80` `RAX200` 

## 开发须知：

如果你是开发者，想要开发新的插件，并用离线包的方式进行传播，请了解以下内容：

1. 在程序方面：由于固件采用了版本为4.1.27/4.1.51的linux内核，和armv8的编译器，所以请确保你编译的程序是armv8架构的。或者可以使用[hnd/axhnd平台官方工具链](https://github.com/RMerl/am-toolchains/tree/master/brcm-arm-hnd)机型编译。
2. 使用[hnd/axhnd平台官方工具链](https://github.com/RMerl/am-toolchains/tree/master/brcm-arm-hnd)编译二进制程序，建议使用32位的工具链编译32位的程序，因为hnd/axhnd平台的这些机器都是使用的64位内核（kernel），和32位的用户空间（userspace），当然编译64位程序也是能够正常运行的，不过可能消耗更多的路由器ram
3. hnd平台二进制编译使用：**crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25**，axhnd平台二进制编译使用：**crosstools-arm-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1**，不过一般来说不论使用哪个工具链，编译出来的二进制都能在两个平台上同时使用。
4. 因为本软件中心同时支持了ROG和非ROG两种不同皮肤的固件，所以插件的制作需要考虑到两个不同风格的UI，建议可以用css或者定制不同的asp文件，但是后台脚本而二进制保持一致。

**软件中心各架构列表：**

|  软件中心   |                        mips软件中心                        |                 arm软件中心                  |                      hnd/axhnd软件中心                       |                    armng软件中心                    |            mipsle软件中心             |
| :---------: | :----------------------------------------------------------: | :---------------------------------------------: | :----------------------------------------------------------: | :-----------------------------------------------: |:-----------------------------------------------: |
|  项目名称   | [softcenter](https://github.com/paldier/softcenter) | [softcenterarm](https://github.com/paldier/softcenterarm) |       [softcenterarm64](https://github.com/paldier/softcenterarm64)        | [softcenterarmng](https://github.com/paldier/softcenterarmng) |[softcentermipsle](https://github.com/paldier/softcentermipsle) |
|  适用架构   |                            mips                            |                     armv7l                      |                       aarch64                     |                        armv7l                        |                mipsle             |
|    平台     |                             mips                              |                       arm                       |                          hnd/axhnd                           |                     arm                      |            mipsle             |
|  linux内核  |               3.10.104                |                2.6.36.4             |             4.1.27/4.1.51            |             4.1.49/4.1.52/3.14            |         3.10.14          |
|     CPU     |                          grx500                           |                    bcm4708/9                    |                          bcm490x                           |                     bcm675x/ipq4019                     |               mtk7621              |
|     FPU     |                          soft                          |                    no                    |                         hard                           |                     hard                     |               soft              |
|  固件版本   |                    MerlinR 5.0.0                     |              MerlinR 5.0.0              |                     MerlinR 5.0.0                      |                  MerlinR 5.0.0                    |                MerlinR 5.0.0                    |
| 软件中心api |                          **1.1/1.5** 代                          |                   **1.1/1.5** 代                    |                          **1.1/1.5** 代                          |                    **1.1/1.5** 代                     |                **1.1/1.5** 代                     |
| 代表机型-1  | [BLUECAVE](https://github.com/paldier/bluecave-merlin) |              [RT-AC68U](https://github.com/paldier/rtac68u)               | [RT-AC86U](https://github.com/paldier/86u-merlin) |                         [TUF-AX3000](https://github.com/paldier/tuf-ax3000)                        |          [RT-AC85P](https://github.com/paldier/ac85p-merlin) | 
| 代表机型-2  | [K3C](https://github.com/paldier/K3C-merlin) |              [K3](https://github.com/paldier/K3-merlin.ng)              | [GT-AC2900](https://github.com/paldier/gt-ac2900) |                         RT-AX58U                        |         RT-ACRH26
| 代表机型-3  | [RAX40](https://github.com/paldier/rax40-merlin) |         [SBRAC1900P](https://github.com/paldier/sbrac1900p-merlin)                                        | [R8000P](https://github.com/paldier/r8000p-merlin) |                        RAX20                         |         TUF-AC1750         |
| 代表机型-4  | DIR2680 |  RT-AC5300                              | RAX80 |                       [RT-ACRH17](https://github.com/paldier/acrh17-merlin)                         |            /              |


