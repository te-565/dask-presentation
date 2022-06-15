# Based on: https://towardsdatascience.com/create-virtualenv-for-data-science-projects-with-one-command-only-7bec3548419f

# Load in Environment Variables
include .env
export $(shell sed 's/=.*//' .env)

# Variables
ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate
DEACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda deactivate ; conda deactivate

# Help
.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


# Environment Management
.PHONY: create-environment 
create-environment: ## Create the env, install packages, create a kernel and write to environment.yaml
	conda create --name $(CONDA_ENVIRONMENT_NAME) --channel conda-forge --yes python=$(PYTHON_VERSION)
	$(ACTIVATE) $(CONDA_ENVIRONMENT_NAME) && \
	conda config --add channels conda-forge && \
	conda config --set channel_priority strict && \
	conda install --yes --file requirements-conda.txt && \
	pip install -r requirements-pip.txt && \
	conda env export > environment.yaml && \
	ipython kernel install --user --name=$(CONDA_ENVIRONMENT_NAME)
	$(DEACTIVATE)

.PHONY: install-all-requirements
install-all-requirements: ## Install packages in requirements-conda & requirements-pip and write to environment.yaml
	$(ACTIVATE) $(CONDA_ENVIRONMENT_NAME) && \
	conda install --yes --file requirements-conda.txt && \
	pip install -r requirements-pip.txt && \
	conda env export > environment.yaml
	$(DEACTIVATE)

.PHONY: install-conda-requirements
install-conda-requirements: ## Install packages in requirements-conda file and write to environment.yaml
	$(ACTIVATE) $(CONDA_ENVIRONMENT_NAME) && \
	conda install --yes --file requirements-conda.txt && \
	conda env export > environment.yaml
	$(DEACTIVATE)

.PHONY: install-pip-requirements
install-pip-requirements: ## Install the packages in the requirements-pip file and write to environment.yaml
	$(ACTIVATE) $(CONDA_ENVIRONMENT_NAME) && \
	pip install -r requirements-pip.txt && \
	conda env export > environment.yaml
	$(DEACTIVATE) 

.PHONY: remove-environment 
remove-environment: ## Remove the environment and any relevant files
	conda env remove --name $(CONDA_ENVIRONMENT_NAME)

# Jupyter kernel management
.PHONY: create-kernel
create-kernel: ## Register the conda environment to Jupyter
	$(ACTIVATE) $(CONDA_ENVIRONMENT_NAME) && \
	ipython kernel install --user --name=$(CONDA_ENVIRONMENT_NAME)
	$(DEACTIVATE) 

.PHONY: remove-kernel
remove-kernel: ## Remove the conda environment from Jupyter
	jupyter kernelspec uninstall $(CONDA_ENVIRONMENT_NAME)
