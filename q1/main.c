#include <stdio.h>
#include <stdlib.h>

// Define the struct exactly as the assignment specified
struct Node {
    int val;
    struct Node* left;
    struct Node* right;
};

// Declare your assembly functions
extern struct Node* make_node(int val);
extern struct Node* insert(struct Node* root, int val);
extern struct Node* get(struct Node* root, int val);
extern int getAtMost(int val, struct Node* root);

int main() {
    struct Node* root = NULL;

    printf("--- Testing Insert ---\n");
    root = insert(root, 50);
    root = insert(root, 30);
    root = insert(root, 70);
    root = insert(root, 20);
    root = insert(root, 40);
    root = insert(root, 60);
    root = insert(root, 80);
    printf("Nodes inserted successfully.\n\n");

    printf("--- Testing Get ---\n");
    struct Node* found = get(root, 60);
    if (found != NULL) {
        printf("get(60) -> Found node with value: %d\n", found->val);
    } else {
        printf("get(60) -> Node not found.\n");
    }

    struct Node* not_found = get(root, 99);
    if (not_found != NULL) {
        printf("get(99) -> Found node with value: %d\n", not_found->val);
    } else {
        printf("get(99) -> Node not found (Correct!).\n");
    }
    printf("\n");

    printf("--- Testing getAtMost ---\n");
    // Should find exact match
    printf("getAtMost(40) -> Expected: 40, Got: %d\n", getAtMost(40, root)); 
    // Should find 30 (greatest value <= 35)
    printf("getAtMost(35) -> Expected: 30, Got: %d\n", getAtMost(35, root)); 
    // Should return -1 (no value <= 10 exists)
    printf("getAtMost(10) -> Expected: -1, Got: %d\n", getAtMost(10, root)); 

    return 0;
}