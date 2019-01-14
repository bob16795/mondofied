import cmath
from decimal import *
def frange(start: Decimal, stop, step: Decimal):
    i = Decimal(start)
    while i < stop:
        yield i
        i += Decimal(step)

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
    def evaluate(self, x:Decimal):
        b = len(self.list) - 1
        c = Decimal('0')
        for i in self.list:
            if(b !=0):
                c += Decimal(i*x**b)
            else:
                c += Decimal(i)
            b -= 1
        #print('{} of x={} is {}'.format(self.string(),x, c))
        return c
    def solve(self, accuracy, accuracy_cur = 1, around = None, rerun = False):
        getcontext().prec = 28
        g = around
        if around == None:
            around = 0
        accuracy_dec = Decimal('.'+'0'*(accuracy_cur-1)+'1')
        mid = Decimal(around)
        for i in frange(mid-10*(accuracy_dec),mid+10*(accuracy_dec),accuracy_dec):
            if g == None:
                g = i
            if abs(self.evaluate(i)) <= abs(self.evaluate(g)):
                #print("best {}".format(self.evaluate(g)))
                g = i
        if accuracy_cur != accuracy:
            g  =self.solve(accuracy,accuracy_cur+1,g,True) 
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

if __name__ == "__main__":
    lol = poly([6,6,6,6])
    print(lol.solve(6))
