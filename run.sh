conda activate omnih2o
cd ~/projects/human2humanoid/legged_gym
cd /opt/data/private/SWD_ROOT/human2humanoid/legged_gym

# OmniH2O Training Teacher Policy 
python legged_gym/scripts/train_hydra.py \
--config-name=config_teleop_teacher

# OmniH2O Play Teacher Policy
python  legged_gym/scripts/play_hydra.py \
--config-name=config_teleop_teacher \
num_envs=1 \
motion.future_tracks=True \
asset.termination_scales.max_ref_motion_distance=10.0  \
load_run=24_10_11_01-28-50_OmniH2O_TEACHER \
checkpoint=25500 \
headless=False



# OmniH2O Distill Student Policy
python legged_gym/scripts/train_hydra.py \
--config-name=config_teleop_student \
train.dagger.load_run_dagger=24_10_11_20-54-47_OmniH2O_TEACHER \
train.dagger.checkpoint_dagger=0

# OmniH2O Play Student Policy
python legged_gym/scripts/play_hydra.py \
--config-name=config_teleop_student \
num_envs=1 \
train.dagger.load_run_dagger=24_10_11_20-54-47_OmniH2O_TEACHER \
train.dagger.checkpoint_dagger=0 \
asset.termination_scales.max_ref_motion_distance=10.0 \
load_run=24_10_11_20-56-57_OmniH2O_STUDENT \
checkpoint=0 \
headless=False 
