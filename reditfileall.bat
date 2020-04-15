cd images
@echo off
@ren *Fastboot*.bin  00-00110000-Fastboot.bin
@ren *M3Boot*.bin  01-00200000-M3Boot_R11.bin
@ren *M3Boot-ptable*.bin  02-00010000-M3Boot-ptable.bin
@ren *Kernel*.bin  03-00090000-Kernel_R11.bin
@ren *VxWorks*.bin  04-00220000-VxWorks_R11.bin
@ren *M3Image*.bin  05-00230000-M3Image_R11.bin
@ren *DSP*.bin  06-00240000-DSP_R11.bin
@ren *Nvdload*.bin  07-00250000-Nvdload_R11.bin
@ren *System*.bin  08-00590000-System.bin
@ren *APP*.bin 09-005a0000-APP.bin
@ren *Oeminfo*.bin 10-000a0000-Oeminfo.bin
@ren *CDROMISO*.bin 11-000b0000-CDROMISO.bin
@ren *WEBUI*.bin 12-005b0000-WEBUI.bin
cd ..
exit

