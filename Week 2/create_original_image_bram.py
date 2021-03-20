import cv2
import numpy as np
import os

bram = open("original_image.txt", mode = 'w')

img_temp = cv2.imread('test.jpg')
print('shape:', img_temp.shape)

img = cv2.resize(src=img_temp, dsize=(120 , 50))
print('shape:', img.shape)

height, width, deep = img.shape

for height_index in range(height):
	for width_index in range(width):
		blue = hex(img[height_index, width_index, 0]) 
		green = hex(img[height_index, width_index, 1]) 
		red = hex(img[height_index, width_index, 2])
		data = blue[2 : 7] + green[2 : 7] + red[2 : 7] + "\n"
		print(data)
		bram.write(data)
bram.close()