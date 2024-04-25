#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define N 3 // Size of the puzzle

typedef struct {
    int board[N][N];
    int blank_row;
    int blank_col;
} Puzzle;

// Function to initialize the puzzle
void initPuzzle(Puzzle* puzzle, int initial[N][N]) {
    memcpy(puzzle->board, initial, sizeof(puzzle->board));

    // Find the position of the blank tile
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (puzzle->board[i][j] == 0) {
                puzzle->blank_row = i;
                puzzle->blank_col = j;
                return;
            }
        }
    }
}

// Function to print the puzzle
void printPuzzle(Puzzle* puzzle) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%d ", puzzle->board[i][j]);
        }
        printf("\n");
    }
}

// Function to check if the puzzle is solved
bool isSolved(Puzzle* puzzle) {
    int counter = 1;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (puzzle->board[i][j] != counter % (N*N)) {
                return false;
            }
            counter++;
        }
    }
    return true;
}

// Function to move the blank tile
void moveBlank(Puzzle* puzzle, int row, int col) {
    int temp = puzzle->board[puzzle->blank_row][puzzle->blank_col];
    puzzle->board[puzzle->blank_row][puzzle->blank_col] = puzzle->board[row][col];
    puzzle->board[row][col] = temp;
    puzzle->blank_row = row;
    puzzle->blank_col = col;
}

// Function to solve the puzzle using breadth-first search
void solvePuzzle(Puzzle* puzzle) {
    // TODO: Implement breadth-first search algorithm
}

int main() {
    int initial[N][N] = {
        {1, 2, 3},
        {4, 0, 5},
        {6, 7, 8}
    };

    Puzzle puzzle;
    initPuzzle(&puzzle, initial);

    printf("Initial Puzzle:\n");
    printPuzzle(&puzzle);

    if (isSolved(&puzzle)) {
        printf("Puzzle is already solved!\n");
    } else {
        printf("Solving the puzzle...\n");
        solvePuzzle(&puzzle);
    }

    return 0;
}



￼Enter
