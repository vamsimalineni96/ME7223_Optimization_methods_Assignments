import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
plt.style.use('seaborn-white')

x1=np.arange(-1.5,3.5,0.005)
z=3*x1**2-x1**3

xa=[0,2]
ya=[0,4]
plt.plot(xa[0],ya[0],'ro')

plt.annotate("Stable Equilibrium (0,0)",(0,0),xytext=(0,-2),arrowprops = dict(facecolor ='green',
                                  shrink = 0.05))
plt.annotate("Unstable Equilibrium(2,4)",(2,4),xytext=(2,6),arrowprops = dict(facecolor ='green',
                                  shrink = 0.05))
plt.plot(xa[1],ya[1],'ro')
plt.plot(x1,z,'b')

plt.ylabel("U(x)")
plt.xlabel("x")
plt.title("Question 4")
plt.grid()
plt.show()
