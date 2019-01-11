# Setting up and Running Molecular Dynamics Simulations: Good Practice and Pitfalls

## Aimed at: 
Anyone interested learning how to set up and run molecular dynamics simulations.

## Requirements: 
Basic knowledge of the Linux command line.

## Abstract: 
Whether you are a user of Amber, Charmm, Gromacs, NAMD or any other MD package, there are a good number of on-line tutorials that will take you through the mechanics of setting up and running an MD simulation. However in general there is less discussion in these about how to ensure you end up with a good simulation. In this workshop we will explore some of the issues in simulation preparation and analysis that can trip up the unwary, and how to avoid them.

## Training Material

The "setting up" part of the workshop takes the form of an informal lecture with interspersed activities. You can find a copy of the notes for this presentation, and data files for the activities, in the 'Presentation' folder.

The "analysis" part of the workshop consists of a series of Jupyter notebooks:

1. **Basic Analysis**: An introduction to interactive MD data analysis with Jupyter notebooks and MDTraj.
2. **PCA Analysis**: An introduction to the use of Principal Component Analysis methods for the analysis of sampling and convergence of MD simulations.
3. **Statistical Analysis**: An introduction to the use of statistical methods to assess the significance of data extracted from MD simulations.
4. **Ubiquitin Analysis**: Application of some of the methods in the other notebooks to the analysis of data from an MD simulation of ubiquitin.
4. **Procheck  Analysis**: A slightly more advanced notebook that demonstartes how you can automate the Procheck analysis of a multi-model PDB file of an NMR-derived protein structure.

These can be run using the 
<a href="https://ccpbiosim.github.io/workshop/events/bristol2018/server.html" target="_blank">workshop jupyter server</a>. 
Once you have started the server, navigate to the `md_workshop` directory and you will find the
notebooks there.

If you want to take a copy for your own use back home, the simplest approach is to clone this repository:
```
git clone https://github.com/CCPBioSim/md_workshop.git
```

