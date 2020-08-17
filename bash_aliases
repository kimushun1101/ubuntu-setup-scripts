cdls ()
{
    \cd "$@" && ls
}
alias cd="cdls"
alias x="exit"
alias open="xdg-open"
alias pbcopy='xsel --clipboard --input'

alias cm="cd ~/catkin_ws && catkin_make && source devel/setup.bash"
alias cb="cd ~/ros2_ws && colcon build --symlink-install && source install/setup.bash"
## For turtlebot3_ws
# alias cb="cd ~/turtlebot3_ws && colcon build --symlink-install && source install/setup.bash"

## ROS1
# source /opt/ros/melodic/setup.bash
# source ~/catkin_ws/devel/setup.bash
# export TURTLEBOT3_MODEL=burger

## ROS2
# source /opt/ros/dashing/setup.bash
# source ~/turtlebot3_ws/install/setup.bash
# export ROS_DOMAIN_ID=30 #TURTLEBOT3
# export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/turtlebot3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models
