from polynomial import *
if False:
    list = [[None]]*153
    print(list)
    for i in range(0,50):
      print(str(i+50)+"%")
      for j in range(0,50):
        for k in range(0,50):
          lol = poly([i,j,k])
          #input(list)
          list[lol.height()] = list[lol.height()] + [lol]
    nums = []
    c = 0
    #input(list[2])
    for i in list:
      c+=1
      print(c)
      for j in i:
        if j != None:
          if j.solve() != None:
            if not(j.solve()[0] in nums):
              nums.append(j.solve()[0])
              print(j.string() +":"+ j.solve()[0])
    #  input("Press Enter to continue...")
else:
    lol = poly([5,2,4,7,8])
    print(lol.solve())
