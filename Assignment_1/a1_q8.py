import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
plt.style.use('seaborn-white')

fig=plt.figure()
ax=fig.add_subplot(111)
u=np.linspace(-10,10,1000)
x,y=np.meshgrid(u,u)


f=x**2+y**2
g=x*y-1


objective=plt.contour(x,y,f,colors='black')
plt.clabel(objective,inline=True,fontsize=8)
#plt.contourf(x,y,f)

constraint=plt.contour(x,y,g,colors='red')
plt.clabel(constraint,inline=True,fontsize=8)
#plt.contourf(x,y,g)

labels = ['f(x,y)', 'g(x,y)']
objective.collections[0].set_label(labels[0])
constraint.collections[1].set_label(labels[1])
plt.legend(bbox_to_anchor=(1.1,1.15))
plt.title("Question 8")
plt.xlabel("x")
plt.ylabel("y")
plt.show()

