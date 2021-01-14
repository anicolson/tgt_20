#!/bin/bash

# The tgt_20 project.
# Copyright (C) 2020  Aaron Nicolson
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --gres=gpu:1
#SBATCH --time=120:00:00
#SBATCH --mem=16000MB

case `whoami` in
  nic261)
    echo Loading modules...
    module load python/3.7.2
    module load cuda/10.1.168
    module load cudnn/v7.6.4-cuda101
esac

source /scratch1/nic261/venv/deepspeech/bin/activate

# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/ibm_mse_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/ibm_mse_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/ibm_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/ibm_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/irm_mse_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/irm_mse_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/irm_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/irm_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/mag_norm_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/mag_norm_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/pow_db_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/pow_db_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/pow_db_std_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/pow_db_std_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/pow_db_norm_mse_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/pow_db_norm_mse_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/pow_db_norm_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/pow_db_norm_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/mag_bar_mse_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/mag_bar_mse_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/mag_bar_demand_vb_mha/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/mag_bar_mha_e125
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_norm_mse_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_norm_mse_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_norm_mse_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_norm_mse_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_norm_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_norm_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_norm_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_norm_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_std_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_std_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_std_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_std_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_norm_mse_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_norm_mse_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_norm_mse_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_norm_mse_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_norm_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_norm_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_norm_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_norm_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_bar_mse_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_bar_mse_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_bar_mse_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_bar_mse_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_bar_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_bar_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_bar_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_bar_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_norm_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_norm_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_db_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_db_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_db_norm_mse_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_db_norm_mse_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_db_norm_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_db_norm_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_bar_mse_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_mse_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_bar_demand_vb_mha/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_mha_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/iam_demand_vb/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/iam_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/iam_mmsa_demand_vb/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/iam_mmsa_e125_mmse-lsa
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/iam_mse_demand_vb/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/iam_mse_e125_mmse-lsa

# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_bar_demand_vb_mha/e125/y/wf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_mha_e125_wf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_bar_demand_vb_mha/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_mha_e125_srwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_bar_demand_vb_mha/e125/y/cwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_mha_e125_cwf
# ./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_bar_demand_vb_mha/e125/y/mmse-stsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_mha_e125_mmse-stsa


./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/ibm_mse_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/ibm_mse_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/ibm_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/ibm_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/irm_mse_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/irm_mse_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/irm_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/irm_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/mag_norm_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/mag_norm_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/pow_db_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/pow_db_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/pow_db_std_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/pow_db_std_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/pow_db_norm_mse_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/pow_db_norm_mse_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/pow_db_norm_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/pow_db_norm_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/mag_bar_mse_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/mag_bar_mse_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/mag_bar_demand_vb_chimerapp/e125/y  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/mag_bar_chimerapp_e125
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_norm_mse_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_norm_mse_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_norm_mse_demand_vb_chimerapp/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_norm_mse_chimerapp_e125_srwf
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_norm_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_norm_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_norm_demand_vb_chimerapp/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_norm_chimerapp_e125_srwf
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_demand_vb_chimerapp/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_chimerapp_e125_srwf
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_std_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_std_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_std_demand_vb_chimerapp/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_std_chimerapp_e125_srwf
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_norm_mse_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_norm_mse_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_norm_mse_demand_vb_chimerapp/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_norm_mse_chimerapp_e125_srwf
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_norm_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_norm_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_db_norm_demand_vb_chimerapp/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_db_norm_chimerapp_e125_srwf
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_bar_mse_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_bar_mse_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_bar_mse_demand_vb_chimerapp/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_bar_mse_chimerapp_e125_srwf
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_bar_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_bar_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_bar_demand_vb_chimerapp/e125/y/srwf  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_bar_chimerapp_e125_srwf
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_norm_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_norm_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_db_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_db_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_db_norm_mse_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_db_norm_mse_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_db_norm_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_db_norm_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_bar_mse_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_mse_chimerapp_e125_mmse-lsa
./run.sh /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/xi_gamma_bar_demand_vb_chimerapp/e125/y/mmse-lsa  /datasets/work/hb-mlaifsp-mm/work/Outputs/tgt_20/hyp_trans/demand_vb/xi_gamma_bar_chimerapp_e125_mmse-lsa

