#!/bin/bash

execute_blur_effect () {
  kernel=3;
  while [ $kernel -le 15 ]
  do
    ./blur-effect-${parallel_type} images/${image_name}.bmp outputs/${parallel_type}-${image_name}-${kernel}-${threads}.bmp $kernel $threads | tee -a logs/${parallel_type}-${image_name}.csv
    kernel=$(($kernel + 1))
  done
}

execute_by_image () {
  processing_message="Processing ${image_name} image with ${parallel_type}"
  echo '═════════════════════════════════'
  echo $processing_message
  echo '═════════════════════════════════'
  echo "K\tT\ts"
  echo '═════════════════════════════════'
  echo "K\tT\ts" > logs//${parallel_type}-${image_name}.csv
  threads=1; execute_blur_effect
  threads=2; execute_blur_effect
  threads=4; execute_blur_effect
  threads=8; execute_blur_effect
  threads=16; execute_blur_effect
  echo '' # Break line
}

# Main
if [ $1 -eq "1" ]; then
  parallel_type="posix"
  gcc blur-effect-${parallel_type}.c -pthread -o blur-effect-${parallel_type}
elif [ $1 -eq "2" ]; then
  parallel_type="openmp"
  gcc blur-effect-${parallel_type}.c -fopenmp -o blur-effect-${parallel_type}
fi

image_name="4k"; execute_by_image
image_name="1080"; execute_by_image
image_name="720"; execute_by_image
