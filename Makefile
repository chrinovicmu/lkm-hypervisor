
ifeq($(KERNELRELEASE), )
	
	KERNELDIR ?= /lib/modules/$(shell uname -r)/build 
	PWD := $(shell pwd)
	
modules:

	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules EXTRA_CFLAGS=" -g -DDEBUG"


modules_install:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install

clean:

	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c *.tmp_versions

.PHONY:

else

	obj-m := hypervisor.o 

endif 
