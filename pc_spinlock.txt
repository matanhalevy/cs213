#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "spinlock.h"
#include "uthread.h"
#include "uthread_util.h"

#define MAX_ITEMS 10

int items = 0;
spinlock_t itemsLock;
spinlock_t pwc;
spinlock_t cwc;

const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS = 2;
const int NUM_PRODUCERS = 2;

int producer_wait_count; // # of times producer had to wait
int consumer_wait_count; // # of times consumer had to wait
int histogram [MAX_ITEMS + 1]; // histogram [i] == # of times list stored i items

void produce() {
    // TODO ensure proper synchronization
    while (1) {
        while (items == MAX_ITEMS) {
            spinlock_lock(&pwc);
            producer_wait_count++;
            spinlock_unlock(&pwc);
        }
        spinlock_lock(&itemsLock);
        if (0 <= items < MAX_ITEMS) {
            items++;
            histogram [items]++;
            spinlock_unlock(&itemsLock);
            break;
        }
        spinlock_unlock(&itemsLock);
    }
}

void consume() {
    // TODO ensure proper synchronization
    while (1) {
        while (items == 0) {
            spinlock_lock(&cwc);
            consumer_wait_count++;
            spinlock_unlock(&cwc);
        }
        spinlock_lock(&itemsLock);
        if (0 < items <= MAX_ITEMS) {
            items--;
            histogram [items]++;
            spinlock_unlock(&itemsLock);
            break;
        }
        spinlock_unlock(&itemsLock);
    }
}

void producer() {
    for (int i = 0; i < NUM_ITERATIONS; i++)
        produce();
}

void consumer() {
    for (int i = 0; i < NUM_ITERATIONS; i++)
        consume();
}

int main(int argc, char** argv) {
    // TODO create threads to run the producers and consumers
    spinlock_create(&itemsLock);
    spinlock_create(&pwc);
    spinlock_create(&cwc);

    uthread_init(4);
    uthread_t pthread[NUM_PRODUCERS];
    uthread_t cthread[NUM_CONSUMERS];

    // create consumer threads

    for (int i = 0; i < NUM_CONSUMERS; i++) {
        cthread[i] = uthread_create((void*) consumer, (void*) 0);
    }

    // create producer threads
    for (int i = 0; i < NUM_PRODUCERS; i++) {
        pthread[i] = uthread_create((void*) producer, (void*) 0);
    }
    
    uthread_join(pthread[0], 0);
    uthread_join(cthread[0], 0);
    uthread_join(pthread[1], 0);
    uthread_join(cthread[1], 0);

    printf("Producer wait: %d\nConsumer wait: %d\n",
            producer_wait_count, consumer_wait_count);

    for (int i = 0; i < MAX_ITEMS + 1; i++)
        //sum += histogram[i];
        printf("items %d count %d\n", i, histogram[i]);

    /*
    int sum = 0; 
    for (int i = 0; i < MAX_ITEMS + 1; i++)
        sum += histogram[i];
    
    printf("total: %d\n", sum);
     */

}
