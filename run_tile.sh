set -e
if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
else
    echo "conda not found"; exit 1;
fi

conda deactivate
conda activate hovernet

jobid=$1
nodes=1
ntasks=1


srun -u  --nodes $nodes --ntasks $ntasks \
    python run_infer.py \
    --gpu='0' \
    --nr_types=6 \
    --type_info_path=type_info.json \
    --batch_size=64 \
    --model_mode=fast \
    --model_path=./pretrained/hovernet_fast_pannuke_type_tf2pytorch.tar \
    --nr_inference_workers=8 \
    --nr_post_proc_workers=16 \
    tile \
    --input_dir="dataset/TCGA-HisMMDM-immune_pathways_nc/images" \
    --output_dir="dataset/TCGA-HisMMDM-immune_pathways_nc/pred" \
    --mem_usage=0.1 \
    --draw_dot \
    --save_qupath \
    --save_raw_map
