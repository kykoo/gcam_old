#!/usr/bin/env python3
import time
import gatt

manager = gatt.DeviceManager(adapter_name='hci0')

strDateTime = ''

class AnyDevice(gatt.Device):
        
    def connect_succeeded(self):
        super().connect_succeeded()
        print("[%s] Connected" % (self.mac_address))
        print('stage 2')
    def connect_failed(self, error):
        super().connect_failed(error)
        print("[%s] Connection failed: %s" % (self.mac_address, str(error)))
    def disconnect_succeeded(self):
        super().disconnect_succeeded()
        print("[%s] Disconnected" % (self.mac_address))
        manager.stop()
    def services_resolved(self):
        print('stage 3')
        super().services_resolved()
        print("[%s] Resolved services" % (self.mac_address))
        for service in self.services:
            print("[%s]  Service [%s]" % (self.mac_address, service.uuid))
            for characteristic in service.characteristics:
                characteristic.read_value()
                print("[%s]    Characteristic [%s]" % (self.mac_address, characteristic.uuid))
                #print('----{}'.format(a[0]))
        print('stage 4')
        #manager.stop()
        print('stage 5')
        return
    
    def characteristic_value_updated(self, characteristic, value):
        global strDateTime

        strDateTime = value.decode("utf-8")
        print("Firmware version:", strDateTime)
        manager.stop()


print('stage 1')    
device = AnyDevice(mac_address='24:0A:C4:C7:0B:BE', manager=manager)
#device = AnyDevice(mac_address='24:0A:C4:C7:C2:2A', manager=manager)
print('stage 1-2')
device.connect()
print('stage 1-3')
manager.run()
#time.sleep(5)
print("stage end")

import os
print(strDateTime)
os.system('sudo date --set="{}"'.format(strDateTime))
