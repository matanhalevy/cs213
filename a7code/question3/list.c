#include <stdlib.h>
#include "list.h"

const int INITIAL_SIZE  = 10;
const int GROWTH_FACTOR = 5;

/**
 * Structure describing a list.
 */
struct list {
  void** data;
  int    len;
  int    size;
};

/**
 * Create a new empty list.
 */
list_t list_create () {
  list_t l = malloc (sizeof (*l));
  l->data  = malloc (sizeof (void*) * INITIAL_SIZE);
  l->len   = 0;
  l->size  = INITIAL_SIZE;
  return l;
}

/**
 * Destroy list.
 */
void list_destroy (list_t l) {
  free (l->data);
  free (l);
}

/**
 * Expand the capacity of the list.  
 * New size is old size times GROWTH_FACTOR.
 * Internal helper function.
 */
static void expand_list (list_t l) {
  // TODO
}

/**
 * Append e to end of list.
 */
void list_append (list_t l, void* e) {
  // TODO
}

/**
 * Append a[0] .. a[n-1] to end of list.
 */
void list_append_array (list_t l, void** a, int n) {
  for (int i = 0; i < n; i++)
    list_append (l, a [i]);
}

/**
 * Insert e at position pos (0..len-1).
 * Moves elements down to make room for the new element.
 */
void list_insert (list_t l, int pos, void* e) {
  // TODO
}

/**
 * Remove element at position pos (0..len-1).
 * Move elements up to occupy position of removed element.
 */
void list_remove (list_t l, int pos) {
  // TODO
}

/**
 * Return element at position pos (0..len-1).
 */
void* list_get (list_t l, int pos) {
  return l->data [pos];
}

/**
 * Return the position (0..len-1) of e where equality
 * is established by equality function, which returns 1 
 * iff two objects are equal.
 */
int list_index (list_t l, void* e, int (*equal) (void*, void*)) {
  for (int i = 0; i < l->len; i++)
    if (equal (l->data [i], e))
      return i;
  return -1;
}

/**
 * Return the length of the list.
 */
int list_len (list_t l) {
  return l->len;
}

/**
 * Map function f onto list l placing results in r.
 * The lists r and l must not be the same list.
 */
void list_map1 (void (*f) (void**, void*), list_t r, list_t l) {
  // TODO
}

/**
 * Map function f onto lists l0 and l1 placing results in r.
 * The target list r must not be one of l0 or l1.
 */
void list_map2 (void (*f) (void**, void*, void*), list_t r, list_t l0, list_t l1) {
  // TODO
}

/**
 * Fold list l using function f placing result in r.
 */
void list_foldl (void f (void**, void*, void*), void** r,  list_t l) {
  // TODO
}

/**
 * Filter list l using function f placing result in r.
 * List r contains elements of l for which f returns true (i.e., non-zero).
 * List r and l must not be the same list.
 */
void list_filter (int (*f) (void*), list_t r, list_t l) {
  // TODO
}

/**
 * Execute function f for each element of list l.
 */
void list_foreach (void (*f) (void*), list_t l) {
  // TODO
}
