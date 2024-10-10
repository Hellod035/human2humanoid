conda activate omnih2o
cd ~/projects/human2humanoid/legged_gym
cd /opt/data/private/SWD_ROOT/human2humanoid/legged_gym

# OmniH2O Training and Playing Teacher Policy 
python legged_gym/scripts/train_hydra.py \
--config-name=config_teleop \
task=h1:teleop \
run_name=OmniH2O_TEACHER \
env.num_observations=913 \
env.num_privileged_obs=990 \
motion.teleop_obs_version=v-teleop-extend-max-full \
motion=motion_full \
motion.extend_head=True \
num_envs=4096 \
asset.zero_out_far=False \
asset.termination_scales.max_ref_motion_distance=1.5 \
sim_device=cuda:0 \
motion.motion_file=resources/motions/h1/amass_phc_filtered.pkl \
rewards=rewards_teleop_omnih2o_teacher \
rewards.penalty_curriculum=True \
rewards.penalty_scale=0.5

# OmniH2O Play Teacher Policy
python  legged_gym/scripts/play_hydra.py \
--config-name=config_teleop \
task=h1:teleop \
env.num_observations=913 \
env.num_privileged_obs=990 \
motion.future_tracks=True \
motion.teleop_obs_version=v-teleop-extend-max-full \
motion=motion_full  \
motion.extend_head=True \
asset.zero_out_far=False \
asset.termination_scales.max_ref_motion_distance=10.0  \
sim_device=cuda:0 \
load_run=OmniH2O_TEACHER \
checkpoint=XXXX \
num_envs=1 \
headless=False