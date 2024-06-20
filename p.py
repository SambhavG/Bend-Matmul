import sys


def identity(n):
    mat = []
    for i in range(2**n):
        mat.append([])
        for j in range(2**n):
            if i == j:
                mat[i].append(1)
            else:
                mat[i].append(0)
    return mat


def product(m1, m2):
    mat = []
    for i in range(len(m1)):
        mat.append([])
        for j in range(len(m2[0])):
            mat[i].append(0)
            for k in range(len(m1[0])):
                mat[i][j] += m1[i][k] * m2[k][j]
    return mat


if __name__ == "__main__":
    n = int(sys.argv[1])
    t = int(sys.argv[2])
    id = identity(n)
    for _ in range(t):
        result = product(id, id)
