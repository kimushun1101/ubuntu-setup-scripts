#!/bin/bash
cd `dirname $0`

./2_set_preference.bash
./3_install_software.bash
./4_set_github_config.bash