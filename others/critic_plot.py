import matplotlib.pyplot as plt
import math

in_filename = "critic.csv"
lines = [line.rstrip() for line in open(in_filename)]

science = []
cost = []
res = []

for line in lines:
    array = line.split(":")
    science.append(float(array[1]))
    cost.append(float(array[2]))
    res.append(float(array[3]))

plt.figure()
plt.scatter(science, cost, c = res, s = 35)
plt.colorbar()
plt.xlim(0, 0.3)
plt.ylim(0, 12000)
plt.title('Results critic agent')
plt.show()
