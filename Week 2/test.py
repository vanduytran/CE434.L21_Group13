import cv2
import numpy as np

img = cv2.imread('test.jpg')

print('shape:', img.shape)

height, width, deep = img.shape

img_temp = np.zeros((height , width), np.uint8)

for height_index in range(height):
	for width_index in range(width):
		img_temp[height_index, width_index] = int(round(0.0820 * img[height_index, width_index, 0] +  0.6094 * img[height_index, width_index, 1] + 0.3086 * img[height_index, width_index, 2]))

print(img_temp.shape)
cv2.imshow('Display Gray Image', cv2.resize(src=img, dsize=(120 , 50)))
cv2.imshow('Display Gray Image Temp 1', img_temp)

cv2.waitKey(0)