# This is the container for the CCPBioSim md_workshop.

# Start with ccpbiosimbase.
FROM ccpbiosim/ccpbiosimbase:latest

LABEL maintainer="James Gebbie-Rayet <james.gebbie@stfc.ac.uk>"

# Root to install "rooty" things
USER root

# Update and Install c-shell.
RUN apt-get update -y 
RUN apt-get install -y csh

# Back to jovyan user
USER $NB_USER

# Python Dependencies for the md_workshop
RUN pip install --user numpy
RUN pip install --user cython
RUN pip install --user scipy
RUN pip install --user pandas
RUN pip install --user scikit-image
RUN pip install --user matplotlib
RUN pip install --user mdtraj
RUN pip install --user pypcazip
RUN pip install --user ipywidgets
RUN pip install --user nglview
RUN pip install --user xbowflow

# Initialise NGLView.
RUN jupyter-nbextension install nglview --py --sys-prefix && \
    jupyter-nbextension enable nglview --py --sys-prefix

# For some reason pip installing tornado as part of xbowflow install
# breaks the JupyterHub kernel (even though two versions are installed
# in conda!).
RUN pip uninstall -y tornado

# Install procheck
ADD --chown=jovyan:100 procheck $HOME/.procheck
ENV PRODIR $HOME/.procheck

RUN cd ${PRODIR} && make
RUN echo 'set prodir = $HOME/.procheck' > $HOME/.cshrc && \
    echo 'setenv prodir $HOME/.procheck' >> $HOME/.cshrc && \
    echo 'alias procheck ${prodir}/procheck.scr' >> $HOME/.cshrc && \
    echo 'alias procheck_comp ${prodir}/procheck_comp.scr' >> $HOME/.cshrc && \
    echo 'alias procheck_nmr ${prodir}/procheck_nmr.scr' >> $HOME/.cshrc && \
    echo 'alias proplot ${prodir}/proplot.scr' >> $HOME/.cshrc && \
    echo 'alias proplot_comp ${prodir}/proplot_comp.scr' >> $HOME/.cshrc && \
    echo 'alias proplot_nmr ${prodir}/proplot_nmr.scr' >> $HOME/.cshrc && \
    echo 'alias gfac2pdb ${prodir}/gfac2pdb.scr' >> $HOME/.cshrc && \
    echo 'alias viol2pdb ${prodir}/viol2pdb.scr' >> $HOME/.cshrc && \
    echo 'alias wirplot ${prodir}/wirplot.scr' >> $HOME/.cshrc

RUN ln -s $HOME/.procheck/procheck.scr $HOME/.local/bin/procheck
RUN ln -s $HOME/.procheck/gfac2pdb.scr $HOME/.local/bin/gfac2pdb

# Add all of the workshop files to the home directory
ADD --chown=jovyan:100 *.ipynb $HOME/
ADD --chown=jovyan:100 data $HOME/data

# Move the utilities file to .local/lib.
RUN mv data/pca_analysis/utilities.py .local/lib/python3.6/site-packages/utilities.py

# Always finish with non-root user as a precaution.
USER $NB_USER
