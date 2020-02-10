#!/bin/bash
#SBATCH --time=60:00
#SBATCH --gres=gpu:k80:1
#SBATCH --cpus-per-task=2
#SBATCH --mem=10000M

module load python/3.7
virtualenv --no-download $SLURM_TMPDIR/env
echo $SLURM_TMPDIR
source $SLURM_TMPDIR/env/bin/activate


pip install --no-index tensorflow_gpu==2
pip install --no-index pandas
pip install /project/cq-training-1/project1/teams/team07/lz4-3.0.2-cp37-cp37m-linux_x86_64.whl
pip install --no-index opencv-python
pip install --no-index matplotlib
pip install --no-index tqdm

# python --version
# which python
# which pip
# pip freeze

python ./train.py $PWD"/train_config.json" -n 1 -m "CNN2D" --train True --scratch_dir $SCRATCH 
python ./test.py

