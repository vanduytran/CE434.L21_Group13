import cv2

# Open webcam
webcam = cv2.VideoCapture(0)

# Specify the format of the video
format = "xvid"
fourcc = cv2.VideoWriter_fourcc(*format)
print("Format of the video: ", format)

# Get the frame size for the video
width = int(webcam.get(cv2.CAP_PROP_FRAME_WIDTH))
height = int(webcam.get(cv2.CAP_PROP_FRAME_HEIGHT))

print("Frame size of the video: ", width, "x", height)

# Determine the output format (file's name, codec code, fps, frame size)
out_stream_video = cv2.VideoWriter('stream_video.avi', fourcc, 30, (width, height))

# Use cap.isOpened () to check if the webcam is valid or not 
if(webcam.isOpened() == False):
    print("Cannot to stream video")
else:
    while(webcam.isOpened()):

        # Read frame from the webcam
        check , frame = webcam.read()
        
        if(check == False):
            break
        else:
            # Flip the frame
            flip_frame = cv2.flip(frame, 1)

            # Write stream video
            out_stream_video.write(flip_frame)

            # Display stream video
            cv2.imshow('Frame', flip_frame)

            # Check if q is pressed then exit
            if (cv2.waitKey(1) & 0xFF) == ord('q'):
                break
    
# Release webcam
webcam.release()

# Release file
out_stream_video.release()

# Close all window
cv2.destroyAllWindows()
