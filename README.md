# vearch_docker

vearch for MacOS 11.2 使用通过

1. sh docker-init.sh

2. check cluster stats

   curl -XGET http://0.0.0.0:8817/_cluster/stats

3. now create db

   curl -v --user "root:secret" -H "content-type: application/json" -XPUT -d '{"name":"test_vector_db"}' http://0.0.0.0:8817/db/_create

4. list db

   curl -XGET http://0.0.0.0:8817/list/db

5. create space

   curl -v --user "root:secret" -H "content-type: application/json" -XPUT -d  '{"name": "vector_space",
   	"dynamic_schema": "strict",
   	"partition_num": 1,
   	"replica_num": 1,
   	"engine": {
   		"name": "gamma",
   		"index_size": 100000,
   		"id_type": "string",
   		"retrieval_type": "IVFPQ",
   		"retrieval_param": {
   			"metric_type": "InnerProduct",
   			"ncentroids": -1,
   			"nsubvector": -1
   		}
   	},
   	"properties": {
   		"string": {
   			"type": "keyword",
   			"index": true
   		},
   		"int": {
   			"type": "integer",
   			"index": true
   		},
   		"float": {
   			"type": "float",
   			"index": true
   		},
   		"vector": {
   			"type": "vector",
   			"model_id": "img",
   			"dimension": 128,
   			"format": "normalization"
   		},
   		"string_tags": {
   			"type": "string",
   			"array": true,
   			"index": true
   		},
   		"int_tags": {
   			"type": "integer",
   			"array": true,
   			"index": true
   		},
   		"float_tags": {
   			"type": "float",
   			"array": true,
   			"index": true
   		}
   	},
   	"models": [{
   		"model_id": "vgg16",
   		"fields": ["string"],
   		"out": "feature"
   	}]
   }'  http://localhost:8817/space/test_vector_db/_create

6. create document

   curl -XPUT -H "content-type: application/json" -d' { "name": "test_vector_db", "partition_num": 1, "replica_num": 1, "engine": { "name": "gamma", "index_size": 9999, "max_size": 100000, "nprobe": 10, "metric_type": "InnerProduct" }, "properties": { "imageId":{ "type":"keyword", "index":true }, "itemId":{ "type":"keyword", "index":true }, "productId":{ "type":"long", "index":true }, "skuId":{ "type":"long", "index":true }, "feature":{ "type":"vector", "model_id":"img", "dimension":256, "store_type":"RocksDB" } } } ' http://localhost:8817/space/test_vector_db/_create

7. Another test

   [向量检索系统Vearch 之从零开始源码编译安装 by 知乎](https://zhuanlan.zhihu.com/p/118640909)

   [向量存储和检索解决方案--Vearch by CSDN](https://blog.csdn.net/yinpengfei1124/article/details/109187458)

8. other to see [Vearch Curl API Manual](https://github.com/vearch/vearch/blob/master/docs/APILowLevel.md)

Thanks to Docker Hub!
