#Multiply matrices, where vectors are maps and matrices are maps of maps

type Matrix:
  Vector {values, length} #values is a map from int to number
  Matrix {rows, length} #rows is a map from int to Matrix/Vector

def dotProduct(v1, v2, l, r):
  if l == r:
    return v1[l] * v2[r]
  else:
    return dotProduct(v1, v2, l, (l+r)/2) + dotProduct(v1, v2, (l+r)/2+1, r)

def vectorDotProduct(v1, v2):
  match v1:
    case Matrix/Vector:
      match v2:
        case Matrix/Vector:
          return dotProduct(v1.values, v2.values, 0, v1.length - 1)
        case _:
          return "Invalid input"
    case _:
      return "Invalid input"

def mergeTwoMaps(m1, l1, r1, m2, l2, r2):
  if l2 == r2+1:
    return m1
  else:
    newM1 = m1
    newM1[l2] = m2[l2]
    return mergeTwoMaps(newM1, l1, r1+1, m2, l2+1, r2)

def mergeTwoVectors(v1, l1, r1, v2, l2, r2):
  match v1:
    case Matrix/Vector:
      match v2:
        case Matrix/Vector:
          return Matrix/Vector(mergeTwoMaps(v1.values, l1, r1, v2.values, l2, r2), r2 - l1 + 1)
        case _:
          return "Invalid input"
    case _:
      return "Invalid input"

#Multiply a vector with rows l through r of a matrix
#Always returns a vector
def vectorTimesMatrix(v1, m2, l, r):
  match v1:
    case Matrix/Vector:
      match m2:
        case Matrix/Matrix:
          match m2.rows:
            case Map:
              if l == r:
                match m2.rows[l]:
                  case Matrix/Vector:
                    return Matrix/Vector({l: vectorDotProduct(v1, m2.rows[l])}, 1)
                  case _:
                    return "Invalid input"
              else: #Merge the two vectors
                return mergeTwoVectors(vectorTimesMatrix(v1, m2, l, (l+r)/2), l, (l+r)/2, vectorTimesMatrix(v1, m2, (l+r)/2+1, r), (l+r)/2+1, r)
            case _:
              return "Invalid input"
        case _:
          return "Invalid input"
    case _:
      return "Invalid input"

#Merge the rows from l1 to r1 of m1 with the rows from l2 to r2 of m2, assuming r1 + 1 = l2
#Always returns a matrix
def mergeTwoMatrices(m1, l1, r1, m2, l2, r2):
  if l2 == r2+1:
    return m1
  else:
    match m1:
      case Matrix/Matrix:
        match m2:
          case Matrix/Matrix:
            newRows = m1.rows
            match newRows:
              case Map:
                newRows[l2] = m2.rows[l2]
                return mergeTwoMatrices(Matrix/Matrix(newRows, m1.length + 1), l1, r1+1, m2, l2+1, r2)
              case _:
                return "Invalid input"
          case _:
            return "Invalid input"
      case _:
        return "Invalid input"

#Need this function to bring vectors up to combinable matrices
def vectorToMatrix(v, i):
  return Matrix/Matrix({i: v}, 1)

#Multiply rows of m1 from l1 to r1 with columns of m2^T from l2 to r2
#Always returns a matrix
def matrixTimesMatrix(m1, l1, r1, m2, l2, r2):
  match m1:
    case Matrix/Matrix:
      match m2:
        case Matrix/Matrix:
          match m1.rows:
            case Map:
              if l1 == r1:
                match m1.rows[l1]:
                  case Matrix/Vector:
                    return vectorToMatrix(vectorTimesMatrix(m1.rows[l1], m2, l2, r2), l1)
                  case _:
                    return "Invalid input"
              else: #Split the first matrix, multiply, merge
                return mergeTwoMatrices(
                    matrixTimesMatrix(m1, l1, (l1+r1)/2, m2, l2, r2), 
                    l1, 
                    (l1+r1)/2, 
                    matrixTimesMatrix(m1, (l1+r1)/2+1, r1, m2, l2, r2), 
                    (l1+r1)/2+1, 
                    r1)
            case _:
              return "Invalid input"
        case _:
          return "Invalid input"
    case _:
      return "Invalid input"

# Construct standard basis vector e_i of size 2^n
def standardBasis(n, i, soFar, numSoFar):
  if numSoFar == twoPower(n):
    return Matrix/Vector(soFar, twoPower(n))
  else:
    newSoFar = soFar
    if numSoFar == i:
      newSoFar[numSoFar] = 1
      return standardBasis(n, i, newSoFar, numSoFar+1)
    else:
      newSoFar[numSoFar] = 0
      return standardBasis(n, i, newSoFar, numSoFar+1)

# Construct the identity matrix of order 2^n
def identity(n, soFar, numSoFar):
  if numSoFar == twoPower(n):
    return Matrix/Matrix(soFar, twoPower(n))
  else:
    newSoFar = soFar
    newSoFar[numSoFar] = standardBasis(n, numSoFar, {}, 0)
    return identity(n, newSoFar, numSoFar+1)

def twoPower(n):
  if n == 0:
    return 1
  else:
    return 2 * twoPower(n - 1)

def main(n, t):
  size = twoPower(n)
  m1 = identity(n, {}, 0)
  m2 = identity(n, {}, 0)
  mult = matrixTimesMatrix(m1, 0, size - 1, m2, 0, size - 1)
  if t == 2:
    mult2 = matrixTimesMatrix(m1, 0, size - 1, m2, 0, size - 1)
    return "Done"
  else:
    return "Done"