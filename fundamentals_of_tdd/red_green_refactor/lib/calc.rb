class Calculator
  
  def add(a, b)
    a + b
  end

  def factorial(n)
    return 1 if n === 0
    (1..n).reduce(:*)
  end

end
