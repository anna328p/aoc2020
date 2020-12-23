#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>

#ifndef LIST_SIZE
#define LIST_SIZE 1000000
#endif

#ifndef DEBUG
#define DEBUG false
#endif

#ifndef DEBUG_LIST
#define DEBUG_LIST false
#endif


void parse_input(char const *filename, int *result) {
	char line[100];
	FILE *input = fopen(filename, "r");

	if (fgets(line, 100, input))
		for (size_t idx = 0; idx < 9; idx++)
			result[idx] = (int) line[idx] - '0';
	else { perror("Could not read from file"); exit(EXIT_FAILURE); }
}

struct node {
	int val;
	struct node *next;
};

struct node * mk_node(void) {
	return (struct node *) malloc(sizeof(struct node));
}

void debug_list(struct node *list) {
	struct node *temp = list;

	do {
		fprintf(stderr, "%d ", list->val);
		list = list->next;
	} while (list != temp);

	fprintf(stderr, "\n");
}

void debug_map(struct node *map[], size_t size) {
	for (size_t ix = 1; ix <= size; ix++)
		fprintf(stderr, "%06u: %d\n", (unsigned int) ix, map[ix]->val);
}

void build_list(struct node *list,
		struct node *map[],
		int *src, size_t size, int max) {

	struct node *cur = list;
	struct node *prev = cur;

	for (size_t ix = 0; ix < (size_t) max; ix++) {
		if (ix < size)
			cur->val = src[ix];
		else
			cur->val = ix + 1;

		map[cur->val] = cur;

		cur->next = mk_node();
		prev = cur;
		cur = cur->next;
	}

	free(cur);
	prev->next = list;
}

void pick_cups(int *picked, struct node *cur) {
	struct node *temp = cur->next;

	if (DEBUG) fprintf(stderr, "picking: ");

	for (int i = 0; i < 3; i++) {
		if (DEBUG) fprintf(stderr, "%d ", temp->val);

		picked[i] = temp->val;
		temp = temp->next;
	}

	cur->next = temp;

	if (DEBUG) fprintf(stderr, "\n");
}

int find_dest(int dest, int picked[3], int max) {
	bool found_dest = false;

	if (DEBUG) fprintf(stderr, "finding dest (init %d): ", dest);

	while (!found_dest)
		if (picked[0] == dest || picked[1] == dest || picked[2] == dest) dest--;
		else if (dest < 1) dest = max;
		else found_dest = true;

	if (DEBUG_LIST) fprintf(stderr, "%d\n", dest);

	return dest;
}

struct node * find_elem(struct node *cur, int elem) {
	while (cur->val != elem) cur = cur->next;
	return cur;
}

void insert_at(struct node *node_map[], int dest, int picked[3]) {

	struct node *temp, *cur;

	if (DEBUG) fprintf(stderr, "inserting, searching for %d: ", dest);

	cur = node_map[dest];

	temp = cur->next;
	for (int i = 0; i < 3; i++) {
		cur->next = node_map[picked[i]];
		cur = cur->next;
	}
	cur->next = temp;

	if (DEBUG) fprintf(stderr, "\n\n");
}

void iteration(struct node *cur, struct node *node_map[], int max) {
	int current_cup = cur->val;
	int picked[3];

	if (DEBUG_LIST) {
		fprintf(stderr, "list: ");
		debug_list(cur);
	}

	if (DEBUG) fprintf(stderr, "current cup: %d\n", current_cup);

	pick_cups(picked, cur);

	if (DEBUG_LIST) {
		fprintf(stderr, "after picking: ");
		debug_list(cur);
	}

	int dest = find_dest(current_cup - 1, picked, max);
	insert_at(node_map, dest, picked);
}

uint64_t run_part2(int *init_cups, int iters) {
	bool found = false;

	struct node *node_map[LIST_SIZE + 1];

	struct node *cups = mk_node();
	build_list(cups, node_map, init_cups, 9, LIST_SIZE);


	for (int iter = 0; iter < iters; iter++) {
		if (DEBUG) fprintf(stderr, "iteration %d\n", iter);
		iteration(cups, node_map, LIST_SIZE);
		cups = cups->next;
	}

	if (DEBUG_LIST) {
		fprintf(stderr, "finished! list: ");
		debug_list(cups);
	}

	int a = 0, b = 0;
	struct node *cur = cups;

	if (DEBUG) fprintf(stderr, "finding value 1\n");
	while (!found) {
		if (cur->val == 1) {
			cur = cur->next;
			a = cur->val;
			cur = cur->next;
			b = cur->val;

			found = true;
		} else {
			cur = cur->next;
		}
	}

	return (uint64_t) a * b;
}

int main(int argc, char **argv) {
	char *filename = "input.txt";
	int iter_count = 10000000;

	if (argc > 1) filename = argv[1];
	if (argc > 2) iter_count = strtol(argv[2], NULL, 10);

	int res[9];
	parse_input(filename, res);

	uint64_t result = run_part2(res, iter_count);
	printf("%lu\n", result);

	return 0;
}
