import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
ylim=66
xlim=-10
#setting up the data
fig=plt.figure()
ax=fig.add_subplot(111)
ax.set_aspect('equal',adjustable='box')
u=np.linspace(xlim,ylim,1000)
x,y=np.meshgrid(u,u)

z=y+0.58*x
levs=[-1.3,19]

#Plotting the contours
#conmin=plt.contour(x,y,z,levels=levs,colors='black')
con=plt.contour(x,y,z,colors='black')
plt.clabel(con,inline=True,fontsize=8)
#plt.clabel(conmin,inline=True,fontsize=8)

#plotting the feasible region
plt.imshow(((y<=2*x+5)&  # constraint 1
            (y<=x+7.5)&  # constraint 2
            (y<=66-5.5*x)&# constraint 3
            (9-(x-7)**2-(y-15)**2<=0)&(y>=0)).astype(int),extent=(x.min(),x.max(),y.min(),y.max()),
            origin='lower',cmap='Greys',alpha=0.3)

#plotting the linear constraints
x=np.linspace(xlim,ylim,1000)
y1=2*x+5
y2=x+7.5
y3=66-5.5*x
y4=0*x
plt.plot(x,y1,label=r'$y-2x-5\leq 0$')
plt.plot(x,y2,label=r'$y-x-7.5\leq 0$')
plt.plot(x,y3,label=r'$y+5.5x-66\leq 0$')
plt.plot(x,y4,label=r'$y\geq 0$')

plt.ylim(-10,ylim)

#plotting the circle constraint:
x = np.linspace( xlim , ylim , 1000 )
y = np.linspace( xlim , ylim , 1000 )
a, b = np.meshgrid( x , y )
C = (a-7) ** 2 + (b-15) ** 2 - 9
cs=plt.contour( a , b , C , [0] )

labels = [r'$(x-7)^2+(y-15)^2-9\geq 0$',r'$f=y+0.58x$']
cs.collections[0].set_label(labels[0])
con.collections[0].set_label(labels[1])


#plotting the set diagram
plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
plt.grid()
plt.title("Question 2")
plt.xlabel("x")
plt.ylabel("y")


#plotting the maxima and minima points : 
xm=[-2.5,9.55]
ym=[0,13.46]
plt.plot(xm[0],ym[0],'ro',label='Minima')
plt.annotate("Minima(-2.5,0)",(-2.5,0),xytext=(-3,1))
plt.plot(xm[1],ym[1],'r*',label='Maxima')
plt.annotate("Maxima(9.55,13.46)",(9.55,13.46),xytext=(10,14))

plt.show()