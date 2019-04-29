# Utility functions for the workshop.

import numpy as np
import mdtraj as mdt
from matplotlib import pyplot as plt

def plot_rmsd(traj, datanames):
    """
    This function takes an MDTraj trajectory and a list of data names 
    and produces an rmsd plot.
    
    """
    traj.superpose(traj[0]) # least squares fits each snapshot to the first.
    frames_per_set = len(traj) // len(datanames) # we assume each trajectory file is the same length.
    for i in range(len(datanames)):
        # The next two lines do the rmsd calculation:
        diff = traj.xyz[i * frames_per_set : (i + 1) * frames_per_set] - traj.xyz[0]
        rmsd = np.sqrt((diff * diff).sum(axis=2).mean(axis=1))
        plt.plot(rmsd, label=datanames[i]) # plot the line for this dataset on the graph.
    plt.xlabel('Frame number')
    plt.ylabel('RMSD (nm.)')
    plt.legend(loc='lower right')

def plot_rmsf(traj):
    """
    Plots the root mean square fluctuations of the atoms in a MDTraj trajectory
    
    """
    diff = traj.xyz - traj.xyz.mean(axis=0)
    rmsf = np.sqrt((diff * diff).sum(axis=2).mean(axis=0))
    plt.xlabel('atom number')
    plt.ylabel('RMSF (nm.)')
    plt.plot(rmsf)
    
    
def plot_pca(pca_model, datanames, highlight=None):
    """
    Plots the projection of each trajectory in the cofasu in the PC1/PC2 subspace.
    
    If highlight is a number, this dataset is plotted in red against all others in grey.
    
    """
    p1 = pca_model.projs[0] # the projection of each snapshot along the first principal component
    p2 = pca_model.projs[1] # the projec tion along the second.

    frames_per_rep = len(p1) // len(datanames) # number of frames (snapshots) in each dataset - assumed equal length
    for i in range(len(datanames)):
        start = i * frames_per_rep
        end = (i + 1) * frames_per_rep
        if highlight is None: # each dataset is plotted with a different colour
            plt.plot(p1[start:end], p2[start:end], label=datanames[i]) 
            plt.text(p1[start], p2[start], 'start')
            plt.text(p1[end-1], p2[end-1], 'end')
        else:
            if i != highlight:
                plt.plot(p1[start:end], p2[start:end], color='grey')
    if highlight is not None:
        start = highlight * frames_per_rep
        end = (highlight + 1) * frames_per_rep
        plt.plot(p1[start:end], p2[start:end], color='red', label=datanames[highlight])
        plt.text(p1[start], p2[start], 'start')
        plt.text(p1[end-1], p2[end-1], 'end')

    plt.xlabel('PC1')
    plt.ylabel('PC2')
    plt.legend(loc='upper left')


