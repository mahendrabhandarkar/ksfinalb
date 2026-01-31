insert into Role (id, name) VALUES (1, 'ROLE_ADMIN'),(2, 'ROLE_USER');
insert into UrlAccessRule (id, access, pattern, application) VALUES
(1, '/dh/web/**', 'ADMIN', 'dental_hygiene'), (2, '/dh/api/**', 'USER', 'dental_hygiene'),
(3, '/ksm/web/**', 'ADMIN', 'ksm'), (4, '/ksm/api/**', 'USER', 'ksm'),
(5, '/sc/web/**', 'ADMIN', 'shoppingcart'), (6, '/sc/api/**', 'USER', 'shoppingcart'),
(7, '/blog/web/**', 'ADMIN', 'blogs'), (8, '/blog/api/**', 'USER', 'blogs'),
(9, '/gig/web/**', 'ADMIN', 'GIG'), (10, '/gig/api/**', 'USER', 'GIG');
INSERT INTO tbl_wf_queue_node_event (node_event_id, queue_event_desc, queue_event_name) VALUES (1, 'CREATE', 'CREATE'), (2, 'READ', 'READ'), (3, 'UPDATE', 'UPDATE'), (4, 'DELETE', 'DELETE'),  (5, 'VIEW', 'VIEW'), (6, 'ALL', 'ALL');
INSERT INTO tbl_wf_queue_node_mst (node_id, node_name, node_short_code, status) VALUES (1, 'ANONYMOUS_ENTER_PROFILE', 'ENTER_PROFILE', true), (2, 'FRONT_DESK_APPROVER', 'FRONT_DESK', true), (3, 'COMMUNITY_LOCAL_HEAD_APPROVER', 'LOCAL_HEAD', true), (4, 'COMMUNITY_REGIONAL_HEAD_APPROVER', 'REGIONAL_HEAD', true), (5, 'COMMUNITY_APPROVER', 'COMMUNITY_APPROVER', true);
INSERT INTO tbl_wf_queue_process_mst (process_id, process_name, process_short_code, status) VALUES (1, 'COMMUNITY_PROFILE_SCREENING','CPSP', true);
INSERT INTO tbl_wf_queue_role_mst (role_id, role_name, role_short_code, status) VALUES (1, 'ANONYMOUS_ENTER_PROFILE', 'AEPR', true), (2, 'BRIDE_PROFILE', 'BPR', true), (3, 'GROOM_PROFILE', 'GPR', true), (4, 'FRONT_DESK_APPROVER', 'FDAR', true), (5, 'COMMUNITY_LOCAL_HEAD_APPROVER', 'CLHAR', true), (6, 'COMMUNITY_REGIONAL_HEAD_APPROVER', 'CRHAR', true), (7, 'COMMUNITY_APPROVER', 'CAR', true), (8, 'SUPER_ADMIN_APPROVER', 'SAAR', true);
INSERT INTO tbl_wf_queue_role_process (role_process_id, process_id, role_id, status) VALUES (1,1,1,true), (2,1,4,true), (3,1,5,true), (4,1,6, true), (5,1,7, true);
INSERT INTO tbl_wf_queue_node_process_mst (node_process_id, node_id, role_process_id, start_flag, end_flag, status) VALUES (1, 1, 1, true, false, true), (2,2,1,false, false, true), (3,3,1,false, false, true), (4,4,1,false, false, true), (5,5,1,false, true, true);

INSERT INTO tbl_wf_queue_role_rank (role_rank_id, rank_id, role_process_id, status) VALUES (1, 1, 1, true);

INSERT INTO tbl_wf_queue_stt_transition_mst (stt_transition_id, node_event_id, parent_node_process_id, next_node_process_id) VALUES (1, 1, 1, 1);

INSERT INTO "User" (id, first_name, last_name, email, password) VALUES (1, 'M', 'B', 'mb@test.com', 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad');
insert into user_roles (user_id, role_id) VALUES (1,1);

INSERT INTO tbl_wf_queue_role_rank_user (role_rank_user_id, role_rank_id, user_id, status) VALUES (1,1,1, true);
INSERT INTO tbl_wf_queue_stt_flow_definition (stt_definition_id, stt_transition_id, record_id, record_type, role_rank_user_id, created_at, created_by) VALUES (1,1, 1, 'PROFILE', 1, NOW(), 1);
