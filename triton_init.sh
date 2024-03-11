cp -r /model /triton

cp /engine/* /triton/model/tensorrt_llm/1/

python3 tools/fill_template.py --in_place /triton/model/tensorrt_llm/config.pbtxt decoupled_mode:true,engine_dir:/triton/model/tensorrt_llm/1,batch_scheduler_policy:guaranteed_no_evict,kv_cache_free_gpu_mem_fraction:0.9,max_num_sequences:32,batching_strategy:inflight_fused_batching,max_beam_width:1,triton_max_batch_size:8,max_queue_delay_microseconds:0,exclude_input_in_output:True,enable_trt_overlap:False

python3 tools/fill_template.py --in_place /triton/model/preprocessing/config.pbtxt tokenizer_type:llama,tokenizer_dir:/tokenizer,triton_max_batch_size:8,preprocessing_instance_count:1

python3 tools/fill_template.py --in_place /triton/model/postprocessing/config.pbtxt tokenizer_type:llama,tokenizer_dir:/tokenizer,triton_max_batch_size:8,postprocessing_instance_count:1

python3 tools/fill_template.py --in_place /triton/model/tensorrt_llm_bls/config.pbtxt tokenizer_type:llama,tokenizer_dir:/tokenizer,triton_max_batch_size:8,bls_instance_count:1,decoupled_mode:true

python3 tools/fill_template.py --in_place /triton/model/ensemble/config.pbtxt tokenizer_type:llama,tokenizer_dir:/tokenizer,triton_max_batch_size:8,ensemble_count:1,decoupled_mode:true

tritonserver --model-repository=/triton/model
