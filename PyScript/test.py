import numpy as np
class Calc():
    def add_(self,a, b):
        return a+b
    def minus_(self,a, b):
        return a-b
    def mult_(self,a, b):
        return a*b
    def div_(self,a, b):
        if b:
            return a/b 
        else:
            return np.inf
    def show(self, a, b):
        return [self.add_(a,b),self.minus_(a,b),self.mult_(a,b),self.div_(a,b)]

a, b = 1, 2
calc = Calc()
print(calc.show(a,b))