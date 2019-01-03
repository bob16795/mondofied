import cmath
class poly:
	def __init__(self,nums):
		lol = False
		self.list = []
		for i in nums:
			if (i != 0) or lol:
				lol = True
				self.list.append(i)
#		input(self.list)
	def height(self):
		b = len(self.list) - 2
		for i in self.list:
			b += abs(i)
#		print(self.string()+" is "+str(b))
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
#		if self.height() == 1:
#			print(stri)
		return stri
	def solve(self):
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
#	input("Press Enter to continue...")
