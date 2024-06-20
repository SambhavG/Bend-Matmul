import sys
import threading


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


def product_partial(m1, m2, start_row, end_row, result):
    for i in range(start_row, end_row):
        for j in range(len(m2[0])):
            result[i][j] = sum(m1[i][k] * m2[k][j] for k in range(len(m1[0])))


def product_with_threads(m1, m2, num_threads=4):
    result = [[0 for _ in range(len(m2[0]))] for _ in range(len(m1))]

    step = len(m1) // num_threads
    threads = []

    for i in range(num_threads):
        start_row = i * step
        end_row = start_row + step if i < num_threads - 1 else len(m1)
        thread = threading.Thread(
            target=product_partial, args=(m1, m2, start_row, end_row, result)
        )
        threads.append(thread)
        thread.start()

    for thread in threads:
        thread.join()

    return result


if __name__ == "__main__":
    n = int(sys.argv[1])
    t = int(sys.argv[2])
    id = identity(n)
    for _ in range(t):
        result = product_with_threads(id, id)
