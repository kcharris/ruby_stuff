def fibonacci(n)
  n == 0 ? 1 : n * fibonacci(n - 1)
  #recursion uses the return values of the function starting with the smallest case and building up to the solution. Little hard to wrap head around.
end

def merge_sort(arr)
  if arr.length < 3
    a = arr[0]
    b = arr[1]
    if b == nil
      [a]
    else
      a <= b ? [a, b] : [b, a]
    end
  else
    a = merge_sort(arr.slice!(0, arr.length / 2))
    b = merge_sort(arr)
    new_array = []
    while a.length > 0 && b.length > 0
      new_array << (a[0] <= b[0] ? a.shift : b.shift)
    end
    if a.length == 0
      new_array.concat(b)
    else
      new_array.concat(a)
    end
    new_array
  end
end

array = [1, 5, 8, 3, 4, 2, 9, 4, 5, 4]
print merge_sort(array)
