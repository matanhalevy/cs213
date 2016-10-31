#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "spinlock.h"
#include "uthread.h"
#include "uthread_util.h"

#define MAX_ITEMS 10

int items = 0;
spinlock_t mainLock;
spinlock_t lk1;
spinlock_t lk2;

const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

void produce() {
  // TODO ensure proper synchronization
  while (1){
    while (items == MAX_ITEMS){
      spinlock_lock(&lk1);
      producer_wait_count++;
      spinlock_unlock(&lk1);
    }
    spinlock_lock(&mainLock);
    if (items < MAX_ITEMS)
    {
      items++;
      histogram [items]++;
      spinlock_unlock(&mainLock);
      break;
    }
    spinlock_unlock(&mainLock);
  }
}

void consume() {
  // TODO ensure proper synchronization
  while(1){
    while(items==0){
      spinlock_lock(&lk2);
      consumer_wait_count++;
      spinlock_unlock(&lk2);
    }
    spinlock_lock(&mainLock);
    if (items < MAX_ITEMS)
    {
      items--;
      histogram [items]++;
      spinlock_unlock(&mainLock);
      break;
    }
    spinlock_unlock(&mainLock);
  }
}

void producer() {
  for (int i=0; i < NUM_ITERATIONS; i++)
    produce();
}

void consumer() {
  for (int i=0; i< NUM_ITERATIONS; i++)
    consume();
}

int main (int argc, char** argv) {
  // TODO create threads to run the producers and consumers
  spinlock_create(&mainLock);
  spinlock_create(&lk1);
  spinlock_create(&lk2);

  uthread_init(4);
  uthread_t thread[4];

  for (int i = 0; i < NUM_PRODUCERS; i++)
  {
    thread[i] = uthread_create((void*) producer, (void*) 0);
  }

  for (int i = 0; i < NUM_CONSUMERS; i++)
  {
    thread[i+2] = uthread_create((void*) consumer, (void*) 0));
  }

  for (int i = 0; i < 4; i++)
  {
    uthred_join(thread[i], 0);
  }

  printf("Producer wait: %d\nConsumer wait: %d\n",
         producer_wait_count, consumer_wait_count);
  for(int i=0;i<MAX_ITEMS+1;i++)
    printf("items %d count %d\n", i, histogram[i]);
}