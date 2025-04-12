from calvin_env.envs.play_table_env import get_env
import os

os.environ['PYOPENGL_PLATFORM'] = 'egl'

val_folder = '/data/task_D_D/validation'
env = get_env(val_folder, show_gui=False)
