# Makefile
BUILD:=../build
WINBUILD:=..\build

SOURCECODEDIR:=D:/QQQQQ/Quantum-OS
SRC:=.

QEMU:=D:/Qemu

CYGWIN:=D:/QQQQQ/Cygwin/bin

ENTRYPOINT:=0x10000

CFLAGS:= -m64
CFLAGS+= -fno-builtin 			# 不需要gcc内置函数
CFLAGS+= -nostdinc 				# 不需要标准头文件
CFLAGS+= -fno-pic 				# 不需要位置无关代码
CFLAGS+= -fno-pie 				# 不需要位置无关可执行程序
CFLAGS+= -nostdlib 				# 不需要标准库
CFLAGS+= -fno-stack-protector	# 不需要栈保护
CFLAGS+= -mcmodel=large			# 更大内存空间
CFLAGS:=$(strip ${CFLAGS})

DEBUG:= -g

INCLUDE:=-I$(SRC)/include

ifeq ($(OS),Windows_NT)
RM:=-rd /s /q $(WINBUILD)
else
RM:=-rm -rf $(BUILD)
endif

# 如果要变量请到上面修改

$(BUILD)/boot/%.bin: $(SRC)/boot/%.asm
	nasm -f bin $< -o $@

$(BUILD)/kernel/%.o: $(SRC)/kernel/%.asm
	nasm -f elf64 $< -o $@

$(BUILD)/kernel/%.o: $(SRC)/kernel/%.c
	gcc $(CFLAGS) $(DEBUG) $(INCLUDE) -c $< -o $@

$(BUILD)/kernel.bin: $(BUILD)/kernel/start.o
	ld -b elf64-x86-64 $(BUILD)/kernel/main.o -o $<
	ld -b elf64-x86-64 $< -o $@
$(BUILD)/system.bin: $(BUILD)/kernel.bin
	objcopy -I elf64-x86-64 -S -R ".eh_frame" -R ".comment" -O binary $< $@

$(BUILD)/system.map: $(BUILD)/kernel.bin
	nm $< | sort > $@

$(BUILD)/vhd/System.vhd: $(BUILD)/vhd/System.vhd
	qemu-img create $< 1G
	qemu-img convert -pO vmdk $< $@

# boot.bin
.PHONY: boot.bin
boot.bin: $(BUILD)/boot/boot.bin
# loader.bin
.PHONY: loader.bin
loader.bin: $(BUILD)/boot/loader.bin
# start.o
.PHONY: start.o
start.o: $(BUILD)/kernel/start.o
# main.o
.PHONY: main.o
main.o: $(BUILD)/kernel/main.o
# kernel.bin
.PHONY: kernel.bin
kernel.bin: $(BUILD)/kernel.bin
# system.bin
.PHONY: system.bin
system.bin: $(BUILD)/system.bin
# system.map
.PHONY: system.map
system.map: $(BUILD)/system.map
# System.vhd
.PHONY: System.vhd
System.vhd: $(BUILD)/vhd/System.vhd
# 模式处理

NewFolder:
	mkdir "$(BUILD)"
	mkdir "$(BUILD)/vhd"
	mkdir "$(BUILD)/boot"
	mkdir "$(BUILD)/kernel"
compile:\
	NewFolder \
	boot.bin \
	loader.bin \
	start.o \
	main.o \
	kernel.bin \
	system.bin \
	system.map								# 手写编译(写的时候累，编译时轻松)
CreateDisk: compile 						# 创建系统硬盘和光盘映像文件
	qemu-img create $(BUILD)/Quantum-OS.img 512M
writeData: CreateDisk \
	$(BUILD)/boot/boot.bin \
	$(BUILD)/boot/loader.bin \
	$(BUILD)/system.bin \
	$(BUILD)/system.map						# 写入数据
# 	dd -> Quantum-OS.img
	$(CYGWIN)/dd if=$(BUILD)/boot/boot.bin of=$(BUILD)/Quantum-OS.img bs=512 count=1 conv=notrunc
	$(CYGWIN)/dd if=$(BUILD)/boot/loader.bin of=$(BUILD)/Quantum-OS.img bs=512 count=4 seek=2 conv=notrunc
	$(CYGWIN)/dd if=$(BUILD)/system.bin of=$(BUILD)/Quantum-OS.img bs=512 count=200 seek=10 conv=notrunc
ConvertImgToVhd: \
	writeData \
	System.vhd									# 将外部介质转换成硬盘文件
qemu: ConvertImgToVhd 							# 启动Qemu
	qemu-system-x86_64 -hda $(BUILD)/vhd/System.vhd -fda $(BUILD)/Quantum-OS.img -boot a -m 32M
clean: qemu 								# 清理无用文件(爱用就用,懒得写，自己搞去，不搞去死)
#	$(RM)
	rm -rf $(BUILD)
	clear
run: clean 									# 启动点


# 调试点
.PHONY: text0
text0:
	mkdir "$(BUILD)"
	mkdir "$(BUILD)/vhd"
	mkdir "$(BUILD)/boot"
	mkdir "$(BUILD)/kernel"
	mkdir "$(BUILD)/media"
.PHONY: text1
text1:
	qemu-img create $(BUILD)/vhd/system.vhd 512M
	qemu-img create $(BUILD)/boot.img 1474560B
	nasm $(SRC)/boot/boot.asm -o $(BUILD)/boot/boot.bin
	nasm $(SRC)/boot/loader.asm -o $(BUILD)/boot/loader.bin
	dd if=$(BUILD)/boot/boot.bin of=$(BUILD)/boot.img bs=512 count=1 conv=notrunc
	dd if=$(BUILD)/boot/loader.bin of=$(BUILD)/boot.img bs=512 count=4 seek=2 conv=notrunc
#	mount -o loop $(SOURCECODEDIR)/build/boot.img $(SOURCECODEDIR)/media
#	cp $(BUILD)/boot/loader.bin $(SOURCECODEDIR)/media
#	sync
#	umount $(SOURCECODEDIR)/media
	qemu-img convert -pO vmdk $(BUILD)/vhd/system.vhd $(BUILD)/vhd/system.vhd
	qemu-system-x86_64 -hda $(BUILD)/vhd/system.vhd -fda $(BUILD)/boot.img -boot a -m 32M
.PHONY: text2
text2:
	rm -rf $(BUILD)
.PHONY: text3
text3:
	$(QEMU)/qemu-system-x86_64 -hda $(BUILD)/vhd/System.vhd -boot c -m 32M -s -S
