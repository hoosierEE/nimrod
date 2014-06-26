# this is a comment
# going to try a pragma here:

{. checks:off, optimization:speed .}

from strutils import parseInt

when false: # this is how to comment out a block of code
  echo("What is your name? ")
  # var name: string  = readLine(stdin) # using a var, which may be re-assigned
  let name = readLine(stdin)
  if name == "name":
    echo("Very funny, your name is name.")
  elif name == "Alex":
    echo("Cool name!")
  else:
    echo ("Hi, "& name, "!")

  echo("A number please: ")
  let n = parseInt(readLine(stdin))
  case n
  of 0..2, 4..7: echo("The number is in the set: {0, 1, 2, 4, 5, 6, 7}")
  of 3, 8: echo("The number is 3 or 8")
  else: discard

  echo("Counting from 0..10")
  for i in countup(0, 10):
    echo($i)
  # the when false block is indentation-based

  # code here will not be "commented out"
  when system.hostOS == "windows":
    echo("running on Windows!")
  elif system.hostOS == "linux":
    echo("running on Linux!")
  elif system.hostOS == "macosx":
    echo("running on Mac OS X!")
  else:
    echo("unknown operating system")

  # parens and semicolon allow using statements where typically only expressions can go:
  const fac3 = (var x = 1; for i in 1..3: x *= i; x)
  echo ($fac3)

  proc sumTillNegative(x: varargs[int]): int =
    for i in x:
      if i < 0:
        return
      result += i

  echo sumTillNegative()
  echo sumTillNegative(3, 4, 5)
  echo sumTillNegative(3, 4, -1, 12)
  # end when false block

  # the discardable pragma allows...
  proc p(x,y: int): int {.discardable.}=
    return x + y
  p(9, 10) # ... this to not be an error
  echo($p(3, 4)) # this is fine either way

  proc addOne(x: var int): int =
    x += 1
    return x

  var x: int
  x = 1
  for i in 1..4:
    echo($addOne(x))

  # overloading functions is possible, like in C++
  proc toString(x: int): string =
    return $x
  proc tostring(x: bool): string =
    if x: result = "truly overloaded"
    else: result = "false and still overloaded"
  echo(toString(48))
  echo(toString(true))
    
  # we can define our own iterators
  iterator upByTwo(a, b: int): int =
    var res = a
    while res <= b:
      yield res
      res += 2

  for i in upByTwo(1, 14):
    echo($i)

# prints the max value on this machine. ARM Chromebook (1): 2147483647
echo($high(int))
