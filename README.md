# Práctica: Blur effect in C with POSIX and OpenMP

## Steps
* Compile and run with POSIX: `sh run-blur.sh 1`
* Compile and run with OpenMP: `sh run-blur.sh 2`

## Section code of POSIX implementation
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

## Section code of OpenMP implementation
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