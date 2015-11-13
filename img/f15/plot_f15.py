__author__ = 'mariosky'

from pylab import *

java_file = open("data/java.txt")
matlab_file = open("data/matlab.txt")
node_file = open("data/node.txt")
chrome_file = open("data/chrome.txt")
firefox_file = open("data/firefox.txt")
chrome_main_file = open("data/chrome_main_thread.txt")
firefox_main_file = open("data/firefox_main_thread.txt")

java_times = [float(time) for time in  java_file ]
matlab_times = [float(time)*1000 for time in  matlab_file ]
node_times = [float(time) for time in  node_file ]
chrome_times = [float(time.split(',')[0])   for time in  chrome_file ][:30]
firefox_times = [float(time.split(',')[0])   for time in  firefox_file ][:30]
chrome_times_main = [float(time.split(',')[0])   for time in  chrome_main_file ][:30]
firefox_times_main = [float(time.split(',')[0])   for time in  firefox_main_file ][:30]

print firefox_times_main
data = [java_times,matlab_times,node_times, chrome_times,chrome_times_main, firefox_times,firefox_times_main]

fig = figure()
ax1 = fig.add_subplot(111)

bp = plt.boxplot(data)



ax1.yaxis.grid(True, linestyle='-', which='major', color='lightgrey',
               alpha=0.5)

# Hide these grid behind plot objects
ax1.set_axisbelow(True)
ax1.set_title('Time in miliseconds for 10k evaluations, 30 runs')
ax1.set_xlabel('Implementation Language')
ax1.set_ylabel('Time in seconds')

xtickNames = plt.setp(ax1, xticklabels= ["Java","Matlab","node.js","chrome","chrome main","firefox","firefox main"] )
plt.setp(xtickNames, rotation=30, fontsize=8)
#plt.setp(xtickNames)
plt.ylim((0,1600))
#show()
plt.savefig('../f15_times.eps')