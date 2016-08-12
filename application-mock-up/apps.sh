#!/bin/bash

# 200 students
# “<student_name>_<week>_<year>.pdf”

export UPLOAD_PATH=/var/www/upload

DoW=`date +%V`
Year=`date +%Y`

for DoW in `seq 1 48`;
do
    echo "Generating Week ${DoW} Student files."
	for i in `seq 1 200`;
	do
	    student="JohnDoe$-${i}";
	    upload_filename=${student}_${DoW}_${Year}.pdf
	    echo "${student}" > ${UPLOAD_PATH}/${upload_filename}
	    echo "Student file upload of ${upload_filename} is completed!"
	    sleep 1
	done

	sleep 5
done
