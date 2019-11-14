EXPERIMENT_NAME=$1
VARIANT=$2
NAME_WITH_VARIANT=$1
if [ $VARIANT ]
then
  NAME_WITH_VARIANT=$1_$2
fi
echo Starting experiment $NAME_WITH_VARIANT
RID=$(($RANDOM%10000))
BASE_DIR=/scratch/gobi1/eleni
CHECKPOINT_DIR=$BASE_DIR/meta_dataset_checkpoints/$NAME_WITH_VARIANT/$RID
SUMMARY_DIR=$BASE_DIR/meta_dataset_summaries/$NAME_WITH_VARIANT/$RID
RECORDS_DIR=$BASE_DIR/meta_dataset_records

python -m meta_dataset.train \
  --train_checkpoint_dir=$CHECKPOINT_DIR \
  --summary_dir=$SUMMARY_DIR \
  --records_root_dir=$RECORDS_DIR \
  --alsologtostderr \
  --gin_config=meta_dataset/learn/gin/best_v1/$EXPERIMENT_NAME.gin \
  --gin_bindings="LearnerConfig.experiment_name='$NAME_WITH_VARIANT'"
