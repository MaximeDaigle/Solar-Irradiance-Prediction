# Solar Irradiance Prediction

[[Paper]](https://github.com/MaximeDaigle/Solar-Irradiance-Prediction/blob/master/GHI%20projections.pdf)
[[Visualization]](https://drive.google.com/file/d/1AO7Bj6Usk9A_CyrkIlHXUMt157EOd5v-/view)


![Processed data](https://media.giphy.com/media/RgzqdUy09gDbZVLW2o/source.gif)

# Execution
All the required python packages are installed on the cluster prior to execution in "evaluation_script.sh"

To run the evaluation: 
* Modify the "evaluation_script.sh to point to your own admin_config.json
* run on cluster with: sbatch evaluation_script.sh

# Training
The python requirements are part of the train_on_slurm.sh script.

To run training on the cluster:
* sbatch train_on_slurm.sh

There are multiple options when training. The 2 important files to consider are: user_config.json and train_config.json. 
* user_config.json in more details:
  * image_dim: determines the croping size around each station.
  * df_image_column: Let's us choose which type of image we want to learn from. The name corresponds to the dataframe column name.
  * random_subset_of_days: If you don't want to train on the whole subset of data, this specifies how mutch to keep. Remove if you want to train on the whole dataframe.
  * with_pass_values: it's possible to set delta times to get past images to feed the training model. As long as the delta does not exceed 24h before, it should be able to handle an many deltas as you wish. WARNING: the more past images added, the slower the dataloader becomes.
  * model_name: the model name we want to run during evaluation time.
  * other options: they are used to specify specefic information to load models for evaluation time. 

* train_config.json in more details:
  * It's verry similar to the admin_config.json except it has a bit more information.
  * batch_size: specify training batch size
  * buffer_size: used for buffering examples for the "shuffle" option of tensorflow dataloaders. 
  * start_bound: starting date that the dataframe will be cut off at. 
  * end_bound: ending date that the dataframe will be cut off at. WARNING: this may change if random_subset_of_days is set in user_config.json.
