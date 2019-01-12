import cmath
def frange(start, stop, step):
    i = start
    while i < stop:
        yield i
        i += step

class poly:
    def __init__(self,nums):
        lol = False
        self.list = []
        for i in nums:
            if (i != 0) or lol:
                lol = True
                self.list.append(i)
#       input(self.list)
    def height(self):
        b = len(self.list) - 2
        for i in self.list:
            b += abs(i)
#       print(self.string()+" is "+str(b))
        if b == -1:
            return 0
        else:
            return b
    def string(self):
        stri = ""
        b = len(self.list)
        for i in self.list:
            b-=1
            if b == 0:
                stri += " + " + str(i)
            elif b == 1:
                if b == len(self.list)-1:
                    stri += str(i) + "x"
                else:
                    stri += " + " + str(i) + "x"
            elif(b == len(self.list)-1):
                stri += str(i) + "x^" + str(b)
            else:
                stri += " + " + str(i) + "x^" + str(b)
#   if self.height() == 1:
#           print(stri)
        return stri
    def evaluate(self, x):
        b = len(self.list) - 1
        c = 0
        for i in self.list:
            c += i*x**b
            b -= 1
        ##print('{} is {}'.format(self.string(), c))
        return c
    def solve(self,degree):
        g = None
        for i in frange(-100,100,degree):
            if g == None:
                g = i
            if abs(self.evaluate(i)) <= abs(self.evaluate(g)):
                #print("best {}".format(self.evaluate(g)))
                g = i
        return g
    def solve_old(self):
        if len(self.list) == 1:
            return((None))
        elif len(self.list) == 2:
            return((str(self.list[0]) + "/" + str(self.list[1]),None))
        elif len(self.list) == 3:
            a = self.list[0]
            b = self.list[1]
            c = self.list[2]
            sol1 = None
            sol2 = None
            if a !=0:
                d = (b**2) - (4*a*c)
                sol1 = str(-b)
                if d != 0:
                    sol1 += "-sqrt(" + str(d) +")"
                if d !=0 and b != 0:
                    sol1 += ")/(2*"+str(a)+")"
                sol2 = (-b+cmath.sqrt(d))/(2*a)
            return((sol1,sol2,None))
        else:
            return(("0",None))
