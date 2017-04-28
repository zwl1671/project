#!/bin/bash

#-----------------------------------------------
#   This is a shell script for setting up a
# multi-sub ensemble tasks by perturbing the 
# initial T field with white noise. You should 
# set the basic parameters as below. Good Luck!
#
# 2015-11-17 Created
# 2016-01-16 Change to fit HPC4
#
#                      A L_Zealot Product
#-----------------------------------------------

#=========================================================
# 1. The following namelist variables must be set properly
# in your case env_run.xml
#
#   RUN_TYPE="hybrid" (and relavant configurations)
#
# 2. Please set "ncdata" namelist variable in user_nl_cam,
# which share the same name as INIT_NAME 
#
# 3. Please check your specific init conditions and restart
# files are in the proper dir, also provide your rpointers 
# in a separate dir
#=========================================================

#*************************************************************
#--------------Below for user defined part--------------------
#*************************************************************
source ~/.bashrc_cesm
alias task="/opt/gridview/pbs/dispatcher/bin/qstat -u yangsong3"

# Workspace Path
WPATH=/users/yangsong3/L_Zealot/F/Nudging

# Case Name
CASENAME=`basename $WPATH`

# Storage Path
SPATH=/users/yangsong3/L_Zealot/F/DATA_Nudging

# Storage Dir Prefix 
SDPRE=ESMn3_

# Init Dir PATH (must be a separate dir)
INIT_DIR=$WPATH/init

# Init File Name (same as ncdata in user_nl_cam)
INIT_NAME=CLIM-Trans-2015.cam.i.0006-01-01-00000.nc

#*************Below to execute the changes*********************
# WARNING:
#   If you are willing to change anything below, you need to be
# VERY CAREFUL to do so.
#*************************************************************
echo "                                                              "
echo "*******************CESM ENSEMBLE RUN SCRIPT*******************"
echo "You may use this script with full access, and any kind of     "
echo "redistribution. It's totally Open-sourced!                    "
echo "                                                              "
echo "     Contact: http://met.sysu.edu.cn/GloCli/Team/?page_id=1008"
echo "                                            A L_Zealot Product"
echo "                                                    2016/12/18"
echo "**************************************************************"
echo "                                                              "

echo "Current working PATH: ${WPATH}"
# Init DIR Validation
if [ $INIT_DIR == "" ] || [ ! -d $INIT_DIR ]; then
    echo "PATH: \"${INIT_DIR}\" NO FOUND! Please check it!"
    exit 1
fi

# Backup rpointer files and initial files 
RP_DIR=${WPATH}/rpoint
if [ ! -d $RP_DIR ]; then
    mkdir $RP_DIR
fi
cp ${WPATH}/exe/rpoint* $RP_DIR

# Clean the cesm.log 
if [ -f  $WPATH/run.log ]; then
    rm $WPATH/run.log
fi


# Main Loop
II=1
N_ESM=`ll $INIT_DIR | wc -l`
N_ESM=$((N_ESM-1))
for INI_FILE in $INIT_DIR/*.nc
do
    echo "ESM${II}/${N_ESM}, with init condition: ${INI_FILE}, is processing!"
    
    cp $INI_FILE $WPATH/exe/$INIT_NAME

    # Submit task
    $WPATH/$CASENAME.run 
    echo "ESM${II}/${N_ESM}, with perturbated init condition: ${INI_FILE}, has been submitted!"
    
    #Check status
    while [ ! -f "$WPATH/run.log" ]
    do
        TASK=`task | grep lzn`
        if [ -n "$TASK" ]; then
            echo "Task on but run.log not found, will try another time..."    
            sleep 60
        else
            echo "No task info and no run.log, error may occur..."
            exit
        fi
    done

    # Loop until finished
    while [ "1" == "1" ]
    do
        
        # Check status
        LOG_SIZE0=`ls -l ${WPATH}/run.log | awk '{ print $5 }'`
        echo "run.log with size ${LOG_SIZE0} byte detected."

        sleep 300
        
        LOG_SIZE1=`ls -l ${WPATH}/run.log | awk '{ print $5 }'`
        
        if [ "$LOG_SIZE0" -eq "$LOG_SIZE1" -a $LOG_SIZE1 -gt 102400 ]; then
            
            TASK=`task | grep lzn`
            if [ -n "$TASK" ]; then
                echo "Still found running task, wait next test or interupt.."
            else
                FINISH=$(date)" ESM${II}/${N_ESM} finished!!! "
                echo "                                  "
                echo "**********************************"
                echo $FINISH
                echo "**********************************"
                echo "                                  "
                
                # post process the output
                echo "Post process, moving history files..."
                if [ ! -d $SPATH ]; then
                    mkdir $SPATH
                fi
                mkdir $SPATH/${SDPRE}${II}
                mv $WPATH/exe/*cam.h1* $SPATH/${SDPRE}${II}
                mv $WPATH/exe/*cam.h0* $SPATH/${SDPRE}${II}
                mv $WPATH/exe/*pop.h* $SPATH/${SDPRE}${II}
                mv $WPATH/run.log $SPATH/${SDPRE}${II}
                break

            fi
        else
            if [ "$LOG_SIZE0" -eq "$LOG_SIZE1" ]; then
                echo "Log file size increment stopped, please check if ESM${II}/${N_ESM} failed."
                exit
            else
                DIFF_LOG_SIZ=`expr $LOG_SIZE1 - $LOG_SIZE0`
                TIMER=$(date)" ${CASENAME} ESM${II}/${N_ESM} with size increment $DIFF_LOG_SIZ is still running..."
                echo $TIMER
            fi
        fi
    done
    
    # Move back the rpointers
    cp  $RP_DIR/* ${WPATH}/exe/
    
    if [ $II == $N_ESM ]; then
        echo "                                                              "
        echo "*******************CESM ENSEMBLE RUN SCRIPT*******************"
        echo "                                                              "
        echo "                                                              "
        echo "              CONGRATULATIONS!!! ALL TASKS DONE!!!            "
        echo "                                                              "
        echo "                                                              "
        echo "                                            A L_Zealot Product"
        echo "                                                    2016/12/18"
        echo "**************************************************************"
        echo "                                                              "
    fi
    II=$((II+1))
done


