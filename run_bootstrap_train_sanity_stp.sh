#!/bin/bash
#SBATCH --cpus-per-task=6   # maximum CPU cores per GPU request: 6 on Cedar, 16 on Graham.
#SBATCH --mem=8000M        # memory per node
#SBATCH --time=00:10:00      # time (DD-HH:MM)
#SBATCH --output=%N-%j.out  # %N for node name, %j for jobID
#SBATCH --account=rrg-lelis

module load StdEnv/2020
module load python/3.8.2
source $HOME/hlevin-env/bin/activate
cd $SLURM_TMPDIR
pip freeze > requirements.txt
python -m venv env
deactivate
source env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt

cd /scratch/tjhia/h-levin

python src/main.py ${scheme} -a ${algorithm} -l ${loss} -m ${model} -p problems/stp/puzzles_5x5_train/ --learn -d SlidingTile -b 7000 -g 10

