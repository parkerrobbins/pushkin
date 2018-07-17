#!/bin/bash

##############################################
# sources
##############################################

set -e
pushkin_conf_dir="$PWD"/.pushkin

source "${pushkin_conf_dir}/pushkin_config_vars.sh"
source "${pushkin_conf_dir}/bin/core.sh"
source "${pushkin_env_file}"
set +e

##############################################
# variables
# WORKING DIR: pushkin root
##############################################
set -e

log () { echo "${boldFont}makeDockerCompose:${normalFont} ${1}"; }

env_file="${pushkin_env_file}"
dc_file="${pushkin_docker_compose_file}"
dc_noDep_file="${pushkin_docker_compose_noDep_file}"

user_quizzes="${pushkin_user_quizzes}"
set +e

##############################################
# start
##############################################

log "making no-env dependency file"
set -a
. "${env_file}"
set +a
cat "${dc_file}" | envsubst > "${dc_noDep_file}"

log "appending quiz-compose appendages"
sed -i.sedBak '/^#@AUTOAPPENDBELOWTHISLINE$/,$d' ${dc_noDep_file}
echo '#@AUTOAPPENDBELOWTHISLINE' >> ${dc_noDep_file}

for qPath in "${user_quizzes}"/*; do
	if [ ! -d "${qPath}" ]; then
		# if there are no quizzes * won't expand, so ignore that
		continue
	fi

	qName=$(basename "$qPath")
	if [ -f "$qPath/worker/docker_compose_appendage.yml" ]; then
		cat "${qPath}/worker/docker_compose_appendage.yml" >> "${dc_noDep_file}"
	fi
done

log "done"
