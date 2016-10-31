#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "uthread_sem.h"

#define MAX_ITEMS 10
const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

struct Pool {
  uthread_sem_t lock;
  uthread_sem_t full;
  uthread_sem_t empty;
  int           items;
};

struct Pool* createPool() {
  struct Pool* pool = malloc (sizeof (struct Pool));
  pool->full = uthread_sem_create(0);
  pool->empty = uthread_sem_create(MAX_ITEMS);
  pool->lock = uthread_sem_create(1);
  pool->items     = 0;
  return pool;
}

void produce(struct Pool * p){
  assert (0 <= p->items && p->items <=MAX_ITEMS);
  uthread_sem_wait(p->empty);
  uthread_sem_wait(p->lock);
  p->items++;
  histogram[p->items]++;
  uthread_sem_signal(p->lock);
  uthread_sem_signal(p->full);
  producer_wait_count++;
}

void consume(struct Pool * p){
  assert (0 <= p->items && p->items <= MAX_ITEMS);
  uthread_sem_wait(p->full);
  uthread_sem_wait(p->lock);
  p->items--;
  histogram[p->items]++;
  uthread_sem_signal(p->lock);
  uthread_sem_signal(p->empty);
  consumer_wait_count++;
}

void* producer (void* pv) {
  struct Pool* p = pv;

  // TODO
  for(int i = 0; i < NUM_ITERATIONS; i++)
    produce(p);
  return NULL;
}

void* consumer (void* pv) {
  struct Pool* p = pv;
  
  // TODO
  for(int i = 0; i < NUM_ITERATIONS; i++)
    consume(p);
  return NULL;
}

int main (int argc, char** argv) {
  uthread_t t[4];

  uthread_init (4);
  struct Pool* p = createPool();
  
  // TODO
  t[0] = uthread_create(producer,p);
  t[1] = uthread_create(consumer,p);
  t[2] = uthread_create(producer,p);
  t[3] = uthread_create(consumer,p);

  for(int i =0; i<4;i++){
    uthread_join(t[i], NULL);
}

  uthread_sem_destroy(p->full);
  uthread_sem_destroy(p->empty);
  uthread_sem_destroy(p->lock);
  
  printf ("producer_wait_count=%d, consumer_wait_count=%d\n", producer_wait_count, consumer_wait_count);
  printf ("items value histogram:\n");
  int sum=0;
  for (int i = 0; i <= MAX_ITEMS; i++) {
    printf ("  items=%d, %d times\n", i, histogram [i]);
    sum += histogram [i];
  }
  assert (sum == sizeof (t) / sizeof (uthread_t) * NUM_ITERATIONS);
}