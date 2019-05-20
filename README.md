# Blur effect implementation in C with POSIX and OpenMP

## Abstract
Blur effect implementation on images with resolutions: 4k, 1080p and 720p, using parallel computing. Written in C language and using POSIX and OpenMP.

## Ubuntu requeriments
* Install GCC: `sudo apt install gcc`

## Steps
* Compile and run with POSIX: `sh run-blur.sh 1`
* Compile and run with OpenMP: `sh run-blur.sh 2`

## Code section of POSIX implementation
<pre>
for(i = 0; i < threads; i++) {
  thrdata[i].xmin = hp->width / threads * i;
  thrdata[i].xmax = hp->width / threads * (i + 1);
  thrdata[i].ymin = 0;
  thrdata[i].ymax = hp->height;
  thrdata[i].data = data;
  thrdata[i].blurSize = blurSize;
  thrdata[i].hp = hp;

  if((rc = pthread_create(&thread[i], NULL, parallel, &thrdata[i]))) {
    fprintf(stderr, "error: pthread_create, rc: %d\n", rc);
  }
}
</pre>

## Code section of OpenMP implementation
<pre>
#pragma omp parallel
{
  #pragma omp for
  for(i=0; i<threads; i++)
  {
    thrdata[i].xmin = hp->width / threads * i;
    thrdata[i].xmax = hp->width / threads * (i + 1);
    thrdata[i].ymin = 0;
    thrdata[i].ymax = hp->height;
    thrdata[i].data = data;
    thrdata[i].blurSize = blurSize;
    thrdata[i].hp = hp;
    parallel(&thrdata[i]); 
  }
}
</pre>