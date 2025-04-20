#vcdparse.py
#Takes a VCD file and returns the final value of each variable in a pickled python dictionary.
#Written by Jayden Rogers

from optparse import OptionParser
import pickle

#-------------------functions
def b2d(b):
    '''
    Returns decimal string equivalent of binary string. \n
    If the input is 'b0101', the output will be '5'. \n
    If the input is 'bxxxx', the output will be 'x'. \n
    If the input is 'bx1x1', the output will just be 'x'.
    '''
    if b[0]=='b':
        value_wo_b=b[1:b.__len__()]
        is_same=all(i==value_wo_b[0] for i in value_wo_b)
        if (is_same and not(value_wo_b[0]=='1')):
            return value_wo_b[0]
        else:
            try: 
                return int(value_wo_b,2)
            except:
                #print('unusual value: ' + b)
                return 'x'
    else:
        return b

#-------------------makes the script function in the command line
parser = OptionParser()
parser.add_option('-i','--in',
                dest='infile',
                type='string',
                help='specify the input file for vcdparse.')
parser.add_option('-o','--out',
                dest='outfile',
                type='string',
                help='specify the output file for the dictionary.')
parser.add_option('-v', '--view',
                dest='viewoutput',
                action='store_true',
                default=False,
                help='writes signals to a text file in a readable format: [signalname, [value, size]] scope')
(options,args)=parser.parse_args()


#-------------------get the vcd file
filename=options.infile
if (filename.__len__()>=4 and filename[-4]+filename[-3]+filename[-2]+filename[-1]=='.vcd'):
    print('File type seems to be valid, program will start.')
else:
    print('ERROR: file does not end in ".vcd", try again.'+'\n')
    exit()

#------------------go line by line and get the $var lines
#------------------once you see #0, get states of all the variables, updating for each timestep

dictionary={}                               #holds all the information
scopelist=[]                                #records every module scope

with open(filename,'r') as file:
    
    line=''                                 #the entire line
    splitline=['']                          #the line divded by each space
    scopes=['']                             #stack of the module scopes

    while (not(splitline[0]=='#0')):        #while in the first part of the VCD
        line=file.readline()                
        splitline=line.split()              

        if (splitline[0]=='$scope'):        #captures the scope of the variables
            scopes.append(splitline[2])
            scopelist.append(splitline[2])
        elif (splitline[0]=='$upscope'):
            scopes.pop()
        
        if (splitline[0]=='$var'):           #captures the actual variables
            symbol=splitline[3]
            name=splitline[4]
            size=splitline[2]
            if (name[0]==':' or scopes[-1][0:8]=='jasper::'):    #removes unneeded variables when exporting VCD from Jasper
                pass
            else:
                dictionary[symbol]=[name,'initial_value',scopes[-1],size]


    while(not(line=='')):                   #while the file hasn't ended
        line=file.readline()                #will skip the #0 line
        splitline=line.split()
        if (not(line=='')):                  #if the line is not blank
            if (line[0]=='#'):               #if at next timestep
                pass
            else:
                if (splitline.__len__()==2):
                    value=splitline[0]
                    symbol=splitline[1]
                    if (symbol in dictionary):
                        dictionary[symbol][1]=value
                else:
                    value=line[0]
                    symbol=line[1:line.__len__()].rstrip()  #removes trailing newline '\n'
                    if (symbol in dictionary):
                        dictionary[symbol][1]=value
    print('File read.')
    file.close()

print('Restructuring data...')

bigdictionary={}                                    #holds all information, but restructured
for i in range(scopelist.__len__()):
    bigdictionary[scopelist[i]]={}                  #create nested dictionary for every module scope

for signal in dictionary:
    scope=dictionary[signal][2]
    name=dictionary[signal][0]
    value=dictionary[signal][1]
    size=dictionary[signal][3]
    bigdictionary[scope][name]=[b2d(value),size]     #fill in data in the new format

print('Data restructured.')

#-------------------export the data

if (options.outfile==None):
    with open(options.infile+'.pickle', 'wb') as handle:
        print('File opened for writing.')
        pickle.dump(bigdictionary, handle)
        print('File written.')
        handle.close()
else:
    with open(options.outfile, 'wb') as handle:
        print('File opened for writing.')
        pickle.dump(bigdictionary, handle)
        print('File written.')
        handle.close()

#to visually check data
viewingoutput=options.viewoutput
if (viewingoutput):
    with open(options.outfile+'_view.txt','w') as file:
        print('File opened for writing.')
        for scope in bigdictionary:
            for signal in bigdictionary[scope]:
                file.write(str([signal,bigdictionary[scope][signal]])+"  "+scope)
                file.write('\n')
        print('File written.')
        file.close()