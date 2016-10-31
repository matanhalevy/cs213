#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "spinlock.h"


#define MAX_ITEMS 10

int items = 0;
int true = 1;
spinlock_t lockmain;
spinlock_t lock1;
spinlock_t lock2;
  
const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

void produce() {
	while (true) {
        while (items >= MAX_ITEMS) {
            spinlock_lock(&lock1);
            producer_wait_count++;
            spinlock_unlock(&lock1);
        }
        spinlock_lock(&lockmain);
        if (items < MAX_ITEMS) {
            items++;
            histogram [items]++;
            spinlock_unlock(&lockmain);
            break;
        }
        spinlock_unlock(&lockmain);
    }
}

void consume() {
  // test condition
    while (true) {
        while (items == 0) {
            spinlock_lock(&lock2);
            consumer_wait_count++;
            spinlock_unlock(&lock2);
        }
        spinlock_lock(&lockmain);
        if (items > 0) {
            items--;
            histogram [items]++;
            spinlock_unlock(&lockmain);
            break;
        }
        spinlock_unlock(&lockmain);
    }
}

void* producer(void* args) {
  for (int i=0; i < NUM_ITERATIONS; i++)
    produce();
  return NULL;
}
	
void* consumer(void* args) {
  for (int i=0; i< NUM_ITERATIONS; i++)
    consume();
  return NULL;
}

int main (int argc, char** argv) {
  uthread_init(4);
  uthread_t thread [4];
  
  spinlock_create(&lockmain);
  spinlock_create(&lock1);
  spinlock_create(&lock2);
  
  for (int a=0; a < NUM_PRODUCERS; a++)
    thread[a] = uthread_create (producer, 0); 
  for (int b=0; b < NUM_CONSUMERS; b++)
    thread[b+2] = uthread_create (consumer, 0);

  for (int j=0; j < 4; j++)
    uthread_join (thread [j], 0);
  
  printf("Producer wait: %d\nConsumer wait: %d\n",
         producer_wait_count, consumer_wait_count);
  for(int i=0;i<MAX_ITEMS+1;i++)
    printf("items %d count %d\n", i, histogram[i]);
}