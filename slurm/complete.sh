#!/usr/bin/env bash

#SBATCH --job-name=dltpy-training
#SBATCH --output=slurm-runs/training.txt

source .venv/bin/activate
pip install -r requirements.txt

python preprocessing/pipeline.py

(cd input-preparation; python generate_df.py)
(cd input-preparation; python df_to_vec.py)

mkdir -p input_datasets/mypy-dependents
cp -r output/{data,ml_inputs,vectors} input_datasets/mypy-dependents

(cd learning; python learn.py mypy-dependents)