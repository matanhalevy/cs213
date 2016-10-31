#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#define MAX_ITEMS 10


const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

struct Pool {
  uthread_mutex_t mutex;
  uthread_cond_t  notEmpty;
  uthread_cond_t  notFull;
  int             items;
};

struct Pool* createPool() {
  struct Pool* pool = malloc (sizeof (struct Pool));
  pool->mutex    = uthread_mutex_create();
  pool->notEmpty = uthread_cond_create (pool->mutex);
  pool->notFull  = uthread_cond_create (pool->mutex);
  pool->items    = 0;
  return pool;
}

void produce(struct Pool* pool) {
	assert (0 <= pool->items <= MAX_ITEMS);
	uthread_mutex_lock(pool->mutex);
        while (pool->items >= MAX_ITEMS) {
            producer_wait_count++;
			uthread_cond_wait(pool->notFull);
        }
		pool->items++;
		histogram [pool->items]++;
		uthread_cond_signal(pool->notEmpty);
		uthread_mutex_unlock(pool->mutex);
	
}

void consume(struct Pool* pool) {
	assert (0 <= pool->items <= MAX_ITEMS);
	uthread_mutex_lock(pool->mutex);
        while (pool->items <= 0) {
            consumer_wait_count++;
            uthread_cond_wait(pool->notEmpty);
        }
		pool->items--;
		histogram [pool->items]++;
		if (pool->items < MAX_ITEMS)
			uthread_cond_signal (pool->notFull);
        uthread_mutex_unlock(pool->mutex);
}

void* producer (void* pv) {
  struct Pool* p = pv;
  
  for (int i=0; i<NUM_ITERATIONS; i++) {
    produce(p);
  }
  return NULL;
}

void* consumer (void* pv) {
  struct Pool* p = pv;
  
  for (int i=0; i<NUM_ITERATIONS; i++) {
    consume(p);
  }
  return NULL;
}
	
int main (int argc, char** argv) {
  uthread_t t[4];
  uthread_init (4);
  
  
  struct Pool* p = createPool();
  t[0] = uthread_create (producer, p);
  t[1] = uthread_create (consumer, p);
  t[2] = uthread_create (producer, p);
  t[3] = uthread_create (consumer, p);
  
  for (int j=0; j < 4; j++)
    uthread_join (t[j], NULL);
  
  printf ("producer_wait_count=%d, consumer_wait_count=%d\n", producer_wait_count, consumer_wait_count);
  printf ("items value histogram:\n");
  int sum=0;
  for (int i = 0; i <= MAX_ITEMS; i++) {
    printf ("  items=%d, %d times\n", i, histogram [i]);
    sum += histogram [i];
  }
  assert (sum == sizeof (t) / sizeof (uthread_t) * NUM_ITERATIONS);
}