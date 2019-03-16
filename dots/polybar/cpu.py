#!/usr/bin/env python3
import subprocess
idle = subprocess.Popen(["top","-b", "-n", "1" ],stdout=subprocess.PIPE).communicate()[0]
idle = idle.decode("utf-8").strip()
temp = subprocess.Popen(['sensors'], stdout=subprocess.PIPE).communicate()[0]
temparr = temp.decode("utf-8").split('\n')
temparr =temparr[3:7]
# util = 1-float(idle.decode("utf-8").strip())
print(f'{temparr[0].split()[2][1:3]}° {temparr[1].split()[2][1:3]}° {temparr[2].split()[2][1:3]}° {temparr[3].split()[2][1:3]}°')
