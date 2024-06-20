#This file is bend, not python

#Everything is represented as a tree

type MatrixTree:
  Leaf { value } #Single value in a vector
  Vector {~left, ~right} #Vector of values divided in two
  Matrix {~topHalf, ~bottomHalf} #Matrix of vectors divided in two
  Nil

#Takes two MatrixTree/Vector and returns a number
def dotProduct(v1, v2):
  match v1:
    case MatrixTree/Vector:
      match v2:
        case MatrixTree/Vector:
          return dotProduct(v1.left, v2.left) + dotProduct(v1.right, v2.right)
        case _:
          return "Invalid input"

    case MatrixTree/Leaf:
      match v2:
        case MatrixTree/Leaf:
          return v1.value * v2.value
        case _:
          return "Invalid input"
    case _:
      return "Invalid input"

#Takes a vector and a matrix, returns a vector
def vectorTimesMatrix(v1, m2):
  #Multiply v1 with each column of m2
  match m2:
    case MatrixTree/Matrix:
      return MatrixTree/Vector(vectorTimesMatrix(v1, m2.topHalf), vectorTimesMatrix(v1, m2.bottomHalf))
    case MatrixTree/Vector:
      return MatrixTree/Leaf(dotProduct(v1, m2))
    case _:
      return "Invalid input"

#Takes two matrices, returns a matrix
def matrixProduct(m1, m2):
  #Reduce m1 to a vector, then multiply it with each column of m2

  match m1:
    case MatrixTree/Matrix:
      return MatrixTree/Matrix(matrixProduct(m1.topHalf, m2), matrixProduct(m1.bottomHalf, m2))
    case MatrixTree/Vector:
      return vectorTimesMatrix(m1, m2)
    case _:
      return "Invalid input"

#Returns the standard basis vector e_i of size 2^n
def standardBasis(n, i):
  bend rowNum = 0, levels = 0:
    when levels < n:
      mat = MatrixTree/Vector(fork(rowNum*2, levels+1), fork(rowNum*2+1, levels+1))
    else:
      if rowNum == i:
        mat = MatrixTree/Leaf(1)
      else:
        mat = MatrixTree/Leaf(0)
  return mat

#Returns the identity matrix of order 2^n
def identity(n):
  bend rowNum = 0, levels = 0:
    when levels < n:
      mat = MatrixTree/Matrix(fork(rowNum*2, levels+1), fork(rowNum*2+1, levels+1))
    else:
      mat = standardBasis(n, rowNum)
  return mat

def numRows(m):
  match m:
    case MatrixTree/Matrix:
      return numRows(m.topHalf) + numRows(m.bottomHalf)
    case MatrixTree/Vector:
      return 1
    case _:
      return "Invalid input"
  

def main(n, t):
  #Define two 2^n x 2^n matrices
  m1 = identity(n)
  m2 = identity(n)
  prod = matrixProduct(m1, m2)
  if t == 2:
    prod2 = matrixProduct(m1, m2)
    return "Done"
  else:
    return "Done"