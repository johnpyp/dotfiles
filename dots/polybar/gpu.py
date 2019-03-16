#!/usr/bin/env python3
import subprocess

util = subprocess.Popen(['nvidia-settings', '-t','-q','[gpu:0]/GPUUtilization'], stdout=subprocess.PIPE).communicate()[0]
temp = subprocess.Popen(['nvidia-settings', '-t','-q','[gpu:0]/GPUCoreTemp'], stdout=subprocess.PIPE).communicate()[0]
util = util.decode("utf-8").strip().split(',')[0].split('=')[1]
print(f'{int(util):02d}% {int(temp.decode("utf-8").strip()):02d}°')