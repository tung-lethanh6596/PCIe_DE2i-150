#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/ioctl.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
#include <asm/io.h>

#define MAJOR_NUMBER 			91

#define IOCTL_SET_REGMASK 		0
#define IOCTL_GET_START	  		1
#define IOCTL_IS_READY    		2

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Driver PCIeHello");
MODULE_AUTHOR("TungLT");

//-- Hardware Handles

static void *ramsrc;  // handle to 32-bit output PIO
static void *ramdes;   // handle to 16-bit input PIO
static void *regmask;
static void *status;

//-- Char Driver Interface
static int   access_count =  0;

static int     char_device_open    ( struct inode * , struct file *);
static int     char_device_release ( struct inode * , struct file *);
static ssize_t char_device_read    ( struct file * , char *,       size_t , loff_t *);
static ssize_t char_device_write   ( struct file * , const char *, size_t , loff_t *);
static long char_device_ioctl(struct file *file, unsigned int ioctl_num, unsigned long ioctl_param);

static struct file_operations file_opts = {
	.read = char_device_read,
	.open = char_device_open,
	.write = char_device_write,
	.release = char_device_release,
	.unlocked_ioctl = char_device_ioctl
};

static int char_device_open(struct inode *inodep, struct file *filep) {
	access_count++;
	printk(KERN_ALERT "altera_driver: opened %d time(s)\n", access_count);
	return 0;
}

static int char_device_release(struct inode *inodep, struct file *filep) {
	printk(KERN_ALERT "altera_driver: device closed.\n");
	return 0;
}

static ssize_t char_device_read(struct file *filep, char *buf, size_t len, loff_t *off) {
	int data;
	size_t count = len;
	void *start_addr = ramdes;
	while (len > 0) {
		data = ioread32(start_addr);
		copy_to_user(buf, &data, sizeof(data)); 
		len -= 4;
		buf += 4;
		start_addr += 0x0004;
	}
	
	return count;
}

static ssize_t char_device_write(struct file *filep, const char *buf, size_t len, loff_t *off) {
	char *ptr = (char *) buf;
	size_t count = len;
	short b = 0;
	void *start_addr = ramsrc;
	while (b <  len) {
		int k = *((int *) ptr);
		ptr += 4;
		b   += 4;
		iowrite32(k, start_addr);
		start_addr += 0x0004;
	}
	return count;
}

static long char_device_ioctl(struct file *file,           
					   unsigned int ioctl_num,
                       unsigned long ioctl_param)
{
	int k;
	char i;
	switch(ioctl_num) {
		case IOCTL_SET_REGMASK:
			k = *((int *) ioctl_param);
			iowrite32(k, regmask);
			break;
		case IOCTL_GET_START:
			i = *((char *) ioctl_param);
			iowrite8(i, status);
			break;
		case IOCTL_IS_READY:
			i = ioread8(status);
			copy_to_user((char*)ioctl_param, &i, sizeof(i));
			break;
	}
	return 0;
}

//-- PCI Device Interface

static struct pci_device_id pci_ids[] = {
	{ PCI_DEVICE(0x1172, 0x0004), },
	{ 0, }
};
MODULE_DEVICE_TABLE(pci, pci_ids);

static int pci_probe(struct pci_dev *dev, const struct pci_device_id *id);
static void pci_remove(struct pci_dev *dev);

static struct pci_driver pci_driver = {
	.name     = "alterahello",
	.id_table = pci_ids,
	.probe    = pci_probe,
	.remove   = pci_remove,
};

static unsigned char pci_get_revision(struct pci_dev *dev) {
	u8 revision;

	pci_read_config_byte(dev, PCI_REVISION_ID, &revision);
	return revision;
}

static int pci_probe(struct pci_dev *dev, const struct pci_device_id *id) {
	int vendor;
	int retval;
	unsigned long resource;

	retval = pci_enable_device(dev);

	if (pci_get_revision(dev) != 0x01) {
		printk(KERN_ALERT "altera_driver: cannot find pci device\n");
		return -ENODEV;
	}

	pci_read_config_dword(dev, 0, &vendor);
	printk(KERN_ALERT "altera_driver: Found Vendor id: %x\n", vendor);

	resource = pci_resource_start(dev, 0);
	printk(KERN_ALERT "altera_driver: Resource start at bar 0: %lx\n", resource);

	ramsrc =  ioremap(resource +  0X0000C000, 0x1000);
	ramdes =  ioremap(resource +  0X0000D000, 0x1000);
	regmask = ioremap(resource +  0X0000E000, 0x0004);
	status =  ioremap(resource +  0X0000E008, 0x0001);
	
	return 0;
}

static void pci_remove(struct pci_dev *dev) {
	iounmap(ramsrc);
	iounmap(ramdes);
	iounmap(regmask);
	iounmap(status);
}


//-- Global module registration

static int __init altera_driver_init(void) {
	int t = register_chrdev(MAJOR_NUMBER, "de2i150_altera", &file_opts);
	t = t | pci_register_driver(&pci_driver);

	if(t<0)
		printk(KERN_ALERT "altera_driver: error: cannot register char or pci.\n");
	else
		printk(KERN_ALERT "altera_driver: char+pci drivers registered.\n");

	return t;
}

static void __exit altera_driver_exit(void) {
	printk(KERN_ALERT "Goodbye from de2i150_altera.\n");

	unregister_chrdev(MAJOR_NUMBER, "de2i150_altera");
	pci_unregister_driver(&pci_driver);
}

module_init(altera_driver_init);
module_exit(altera_driver_exit);
