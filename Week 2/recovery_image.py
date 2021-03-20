import cv2
import numpy as np
import os

path = os.getcwd() + "converted_image.txt"

file = open("converted_image.txt")
data = file.readlines()
file.close()

height = 50
width = 120

img = np.zeros((height , width), np.uint8)

height, width = img.shape

idx = 0

for height_index in range(height):
	for width_index in range(width):
		pixel = data[idx]
		img[height_index, width_index] = int(pixel, 16)
		print(idx)
		if( idx < 6000):
			idx = idx + 1

cv2.imwrite('restored_image.jpg', img)