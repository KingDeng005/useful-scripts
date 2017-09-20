#!/usr/bin/env python

import brainstem
import sys

specs = brainstem.discover.findAllModules(brainstem.link.Spec.USB)
if not specs:
    print('usb hub devices not found!')	
    exit()
else:
    for spec in specs:
	stem = brainstem.stem.USBStem()
	a = stem.connect(spec.serial_number)
	usb = brainstem.stem.USB(stem, 0)
	for i in range(8):
		usb.setPortEnable(i)
	stem.system.save()
    stem.disconnect()
exit()
