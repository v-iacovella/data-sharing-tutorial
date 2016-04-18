#!/usr/bin/python

import glob
import sys

import numpy as np

in_dir=sys.argv[1]
out_dir=sys.argv[2]

dirlist=np.sort(glob.glob(in_dir+"/[0-9]*"))

the_IDs=np.random.permutation(dirlist.shape[0])+1

atable=np.vstack([np.array([dirlist[i].split("/")[-1] for i in np.arange(dirlist.shape[0])]), np.array(["sub-0"+str(the_IDs[i]) for i in np.arange(dirlist.shape[0])])]).T
print atable

np.savetxt(out_dir+"/study_keys.txt",atable,fmt="%s")
