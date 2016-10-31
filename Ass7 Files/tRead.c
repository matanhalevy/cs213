#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/errno.h>
#include <assert.h>
#include "queue.h"
#include "disk.h"
#include "uthread.h"

int sum = 0;


/**
 * Queue of pending reads.
 */
queue_t prq;


void interruptServiceRoutine () {
  // TODO
  uthread_t thread = queue_dequeue(&prq) ;

  // unblocking the thread
  uthread_unblock(thread) ;
}

void blockUntilComplete() {
  // TODO
    uthread_block();
 }

void handleRead (char* buf, int nbytes, int blockno) {
  assert (*((int*)buf) == blockno);

  // added to our handle read
  sum += *(((int*) buf) + 1);
}

/**
 * Struct provided as argument to readAndHandleBlock
 */
struct readAndHandleBlockArgs {
  char* buf;
  int   nbytes;
  int   blockno;
};

void* readAndHandleBlock (void* args_voidstar) {
  // TODO
  // Synchronously:
  //   (1) call disk_scheduleRead to request the block
  //   (2) wait read for it to complete
  //   (3) call handleRead

                                // struct uthread_t* mythread = (uthread_t*) uthread_self ;
  //1
  queue_enqueue(&prq, uthread_self()) ;

  struct readAndHandleBlockArgs* item = args_voidstar ;
  disk_scheduleRead( item->buf, item->nbytes , item->blockno ) ;

  //2 wait for read until it is complete
  blockUntilComplete();
  // call handle read
  handleRead(item->buf, item->nbytes, item->blockno) ;
  return NULL;
}

void run (int numBlocks) {
  uthread_t thread [numBlocks];
  for (int blockno = 0; blockno < numBlocks; blockno++) {
    // TODO
    // call readAndHandleBlock in a way that allows this
    // operation to be synchronous without stalling the CPU
    struct readAndHandleBlockArgs* block = malloc(sizeof(struct readAndHandleBlockArgs));
    char* buffer = malloc(8);
    block->buf = buffer;
    block->nbytes = 8;
    block->blockno = blockno;

    thread[blockno] = uthread_create(readAndHandleBlock, block);
  }
  for (int i=0; i<numBlocks; i++) {
    uthread_join (thread [i], 0);
  }
}

int main (int argc, char** argv) {

  queue_init(&prq) ;

  static const char* usage = "usage: aRead numBlocks";
  int numBlocks = 0;

  if (argc == 2)
    numBlocks = strtol (argv [1], NULL, 10);
  if (argc != 2 || (numBlocks == 0 && errno == EINVAL)) {
    printf ("%s\n", usage);
    return EXIT_FAILURE;
  }

  uthread_init (1);
  disk_start   (interruptServiceRoutine);

  run (numBlocks);

  printf ("%d\n", sum);
}
