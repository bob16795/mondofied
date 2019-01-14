from polynomial import *
if True:
    list = [[None]]*153
    print(list)
    for i in range(-50,50):
      print(str(i+50)+"%")
      for j in range(-50,50):
        for k in range(-50,50):
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
          if j.solve(9) != None:
            if not(j.solve(9) in nums):
              nums.append(j.solve(9))
              #print(j.string() +":"+ str(j.solve(9)))
              print(j.solve(9))
    #  input("Press Enter to continue...")
else:
    lol = poly([9,8,7,6,5,4,3,2,1,2,3,4,5,6,7,8,9])
    print(lol.solve(.001))
