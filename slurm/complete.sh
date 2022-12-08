#!/usr/bin/env bash

## Logging
# SBATCH --job-name=dltpy-training
# SBATCH --output=slurm-runs/training.txt
# SBATCH --mail-user=benjamin.sparks@stud.uni-heidelberg.de

## Resources
# SBATCH --nodes=count 8
# SBATCH --gres=gpu:1
# SBATCH --time=12:00:00




source .venv/bin/activate
pip install -r requirements.txt

python preprocessing/pipeline.py --jobs 8

(cd input-preparation; python generate_df.py)
(cd input-preparation; python df_to_vec.py)

mkdir -p input_datasets/mypy-dependents
cp -r output/{data,ml_inputs,vectors} input_datasets/mypy-dependents

(cd learning; python learn.py mypy-dependents)