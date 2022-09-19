CREATE TABLE `t_cluster` (
`id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
`cluster_id` varchar(100) NOT NULL COMMENT '集群名',
`hash_code` int(11) NOT NULL,
`version` bigint(11) NOT NULL COMMENT '版本号',
`status` int(11) DEFAULT '1' COMMENT '集群状态',
`group_count` int(11) DEFAULT NULL COMMENT '分组数',
`qps` int(11) DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `uniq_c` (`cluster_id`)
);

CREATE TABLE `t_group_node` (
`id` bigint(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
`group_id` int(11) NOT NULL COMMENT '分组Id',
`cluster_id` varchar(100) NOT NULL COMMENT '集群 id',
`server` varchar(100) NOT NULL COMMENT '拉取配置的服务端节点',
`use_master` tinyint(4) NOT NULL COMMENT '是否开启 master 选举',
`node_list` varchar(500) NOT NULL COMMENT '该节点该分组下的节点列表',
`load_balance` tinyint(4) NOT NULL COMMENT '是否开启 master 负载均衡',
`create_time` datetime NOT NULL COMMENT '创建时间',
`update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
PRIMARY KEY (`id`)
);

CREATE TABLE `t_group_server_ref` (
`id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
`group_id` int(11) NOT NULL COMMENT '分组Id',
`cluster_id` varchar(100) NOT NULL COMMENT '集群名',
`server` varchar(100) NOT NULL COMMENT 'IP+port',
`create_time` datetime NOT NULL COMMENT '创建时间',
`update_time` datetime NOT NULL COMMENT '更新时间',
`version` bigint(20) NOT NULL COMMENT '版本'
);

CREATE TABLE `t_key` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `name` varchar(255) NOT NULL COMMENT '秘钥名',
  `hash_key` varchar(255) NOT NULL,
  `cluster_id` varchar(100) NOT NULL COMMENT '集群名',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `creator` varchar(255) COMMENT '创建人',
  `create_time` datetime  COMMENT '创建时间',
  `group_id` int(10) DEFAULT NULL COMMENT '分组ID',
  `qps` int(11) NOT NULL COMMENT 'qps',
  `auto_renew` int(10) NOT NULL DEFAULT '0' COMMENT '是否自动续约',
  `multi_group` tinyint(4) DEFAULT '0' COMMENT '多分组标志0单分组，1多分组',
  `group_ids` varchar(255) DEFAULT NULL COMMENT '分组列表，多分组才会使用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_h` (`hash_key`),
  UNIQUE KEY `uniq_m` (`name`)
);

CREATE TABLE `t_migrate` (
`id` bigint(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
`version` bigint(18) NOT NULL COMMENT '迁移操作的版本',
`group_id` int(11) NOT NULL COMMENT '分组Id',
`cluster` varchar(100) NOT NULL COMMENT '集群名',
`migrate_state` tinyint(4) NOT NULL COMMENT '迁移状态',
`server` varchar(100) NOT NULL COMMENT '服务端节点',
`execute_result` tinyint(4) NOT NULL COMMENT '执行结果 : 0,1',
`key_hash` varchar(255) NOT NULL COMMENT '秘钥哈希',
`is_end` tinyint(4) NOT NULL COMMENT '是否结束 : 0,1',
`create_time` datetime NOT NULL COMMENT '创建时间',
`update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ;

CREATE TABLE `t_migrate_process` (
  `id` bigint(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state` tinyint(4) NOT NULL COMMENT '迁移状态',
  `key_hash` varchar(255) NOT NULL COMMENT '秘钥hash',
  `migrate_key_version` bigint(18) NOT NULL COMMENT 't_migrate 对应的 version',
  `is_end` tinyint(4) NOT NULL COMMENT '是否完成 : 0,1',
  `groups` varchar(255) NOT NULL COMMENT '迁移的 group',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `node_list` varchar(500) DEFAULT NULL COMMENT '迁移节点列表'
);

CREATE TABLE `t_server` (
`id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
`sequence_id` int(11) NOT NULL COMMENT '序列Id',
`server` varchar(100) NOT NULL COMMENT 'IP+Port',
`paxos_port` int(11) NOT NULL COMMENT 'paxos端口号',
`udp_port` int(11) NOT NULL COMMENT 'udp端口号',
`cluster_id` varchar(100) NOT NULL COMMENT '集群名',
`state` tinyint(1) NOT NULL COMMENT '状态',
`last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ;


