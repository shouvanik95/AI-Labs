import csv

attendance = 0
food = 0
extra = 0
mood = [0,0,0,0]
moodt = [0,0,0,0]
grade = [0,0,0,0]
gradet = [0,0,0,0]
phd = [0,0,0,0]
phdt = [0,0,0,0]
job = [0,0,0,0]
jobt = [0,0,0,0]
counter = [0,0,0]

with open('data.csv','r') as f1:
    f = csv.reader(f1,delimiter=',')
    for rows in f:
        row = map(int,rows)
        for i in range(0,3):
            counter[i] = counter[i] + row[i]
        mood[row[1] + 2*row[2]] = mood[row[1] + 2*row[2]] + row[3]
        grade[row[3] + 2*row[0]] = grade[row[3] + 2*row[0]] + row[4]
        phd[row[4] + 2*row[0]] = phd[row[4] + 2*row[0]] + row[5]
        job[row[4] + 2*row[2]] = job[row[4] + 2*row[2]] + row[6]
        moodt[row[1] + 2*row[2]] = moodt[row[1] + 2*row[2]] + 1
        gradet[row[3] + 2*row[0]] = gradet[row[3] + 2*row[0]] + 1
        phdt[row[4] + 2*row[0]] = phdt[row[4] + 2*row[0]] + 1
        jobt[row[4] + 2*row[2]] = jobt[row[4] + 2*row[2]] + 1

print counter
print map(lambda x: float(x)/200.0, counter)
print mood,moodt
print map(lambda x,y: float(x)/ float(y), mood, moodt)
print grade,gradet
print map(lambda x,y: float(x)/ float(y), grade, gradet)
print phd,phdt
print map(lambda x,y: float(x)/ float(y), phd, phdt)
print job,jobt
print map(lambda x,y: float(x)/ float(y), job, jobt)

