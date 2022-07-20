-- 检测到有新版本时进行执行

INSERT INTO logdog_version (id, version, time_stamp, create_time) VALUES (null, 'v1.0', REPLACE(unix_timestamp(NOW(3)),'.',''), NOW());
INSERT INTO logdog_version (id, version, time_stamp, create_time) VALUES (null, 'v1.1', REPLACE(unix_timestamp(NOW(3)),'.',''), NOW());
