import sys
import numpy as np

if __name__ == "__main__":
    n = int(sys.argv[1])
    t = int(sys.argv[2])
    id = np.identity(2**n)
    for _ in range(t):
        result = np.dot(id, id)
