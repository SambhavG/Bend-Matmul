#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int** createIdentityMatrix(int n) {
    int** matrix = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        matrix[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            matrix[i][j] = (i == j) ? 1 : 0;
        }
    }
    return matrix;
}

int** multiplyMatrices(int** mat1, int** mat2, int rows1, int cols1, int cols2) {
    int** result = (int**)malloc(rows1 * sizeof(int*));
    for (int i = 0; i < rows1; i++) {
        result[i] = (int*)malloc(cols2 * sizeof(int));
        for (int j = 0; j < cols2; j++) {
            result[i][j] = 0;
            for (int k = 0; k < cols1; k++) {
                result[i][j] += mat1[i][k] * mat2[k][j];
            }
        }
    }
    return result;
}

// Main function
int main(int argc, char* argv[]) {
    int n = 1;
    int t = 1;
    if (argc >= 2) {
        n = atoi(argv[1]);
    }
    if (argc >= 3) {
        t = atoi(argv[2]);
    }
    n = pow(2, n);
    int** identityMatrix = createIdentityMatrix(n);
    int** identityMatrix2 = createIdentityMatrix(n);
    for (int i = 0; i < t; i++) {
        int** result = multiplyMatrices((int**)identityMatrix, (int**)identityMatrix2, n, n, n);
    }

    return 0;
}
