import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
plt.style.use('seaborn-white')

#setting up the parameters
fig=plt.figure()
ax=fig.add_subplot(111)
u=np.linspace(-15,10,1000)
x,y=np.meshgrid(u,u)

#Finding the values of obj func
z=25*x**2+12*y**2-20*x*y+120*y

#plotting the contours
con=plt.contour(x,y,z,colors='black')
conmin=plt.contour(x,y,z,levels=[-70],colors='blue')
#labelling the contours
plt.clabel(con,inline=True,fontsize=8)
plt.clabel(conmin,inline=True,fontsize=8)

#plotting the feasible region
plt.imshow((y>=-x).astype(int),extent=(x.min(),x.max(),y.min(),y.max()),
            origin='lower',cmap='Greys',alpha=0.3)

labels = [r'$z=25x^2+12y^2-20xy+120y$']
con.collections[0].set_label(labels[0])

#plotting the constraint
xa=np.arange(-10,10,0.005)
ya=-xa
plt.plot(xa,ya,'r',label=r'$x+y\geq 0$')

#plotting the minima point
xp=[0.86]
yp=[-0.87]
plt.plot(xp,yp,'ro')
plt.annotate("Minima(0.86,-0.87)",(0.86,-0.87),xytext=(0,0.2))

plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
plt.title("Question 1")
plt.xlabel("x")
plt.ylabel("y")
plt.grid()
plt.show()
