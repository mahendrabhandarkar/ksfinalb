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
INSERT INTO Category (id, name) VALUES (1, 'Electronics'), (2, 'Computers'), (3, 'Mobile Phones'), (4, 'Home Appliances'), (5, 'Furniture'), (6, 'Books'), (7, 'Clothing'), (8, 'Footwear'), (9, 'Sports & Fitness'), (10, 'Beauty & Personal Care'), (11, 'Toys & Games'), (12, 'Automotive'), (13, 'Groceries'), (14, 'Health & Wellness'), (15, 'Jewelry');
INSERT INTO Product (id, brand, description, inventory, name, price, category_id)
VALUES (1, 'Samsung', 'Latest Android smartphone with AMOLED display', 50, 'Galaxy S24', 79999.00, 3),
(2, 'Apple', 'Premium smartphone with A18 chip', 35, 'iPhone 16', 89999.00, 3),
(3, 'Dell', '15-inch laptop for business and personal use', 20, 'Inspiron 15', 54999.00, 2),
(4, 'HP', 'All-in-one desktop computer', 15, 'HP Pavilion AIO', 62999.00, 2),
(5, 'Sony', 'Noise-cancelling wireless headphones', 40, 'WH-1000XM5', 24999.00, 1),
(6, 'LG', 'Double-door refrigerator', 10, 'LG Frost Free 360L', 38999.00, 4),
(7, 'Godrej', 'Wooden wardrobe with 3 doors', 8, 'Godrej Wardrobe', 21999.00, 5),
(8, 'Penguin', 'Best-selling self-help book', 100, 'Atomic Habits', 599.00, 6),
(9, 'Levis', 'Slim fit denim jeans', 75, '511 Slim Fit Jeans', 2499.00, 7),
(10, 'Nike', 'Comfortable running shoes', 60, 'Air Zoom Pegasus', 7999.00, 8),
(11, 'Adidas', 'Training shoes for gym workouts', 45, 'Duramo SL', 4999.00, 8),
(12, 'Cosco', 'Professional cricket bat', 25, 'English Willow Bat', 3499.00, 9),
(13, 'Lakme', 'Daily moisturizing lotion', 120, 'Peach Milk Moisturizer', 299.00, 10),
(14, 'Funskool', 'Educational board game for kids', 55, 'Business Game', 799.00, 11),
(15, 'Bosch', 'Car cleaning vacuum cleaner', 18, 'Mini Vacuum Cleaner', 3499.00, 12),
(16, 'Tata', 'Premium basmati rice 5kg pack', 200, 'Basmati Rice', 799.00, 13),
(17, 'Dabur', 'Natural honey 500g', 150, 'Pure Honey', 349.00, 14),
(18, 'Titan', 'Elegant analog wrist watch', 30, 'Titan Neo', 4999.00, 15),
(19, 'Boat', 'Bluetooth wireless speaker', 80, 'Stone 620', 1999.00, 1),
(20, 'Asus', 'Gaming laptop with RTX graphics', 12, 'ROG Strix G16', 124999.00, 2);
INSERT INTO Image (id, downloadUrl, fileName, fileType, image, product_id)
VALUES (1, 'https://example.com/images/galaxy-s24-1.jpg', 'galaxy-s24-1.jpg', 'image/jpeg', NULL, 1),
(2, 'https://example.com/images/galaxy-s24-2.jpg', 'galaxy-s24-2.jpg', 'image/jpeg', NULL, 1),
(3, 'https://example.com/images/iphone-16-1.jpg', 'iphone-16-1.jpg', 'image/jpeg', NULL, 2),
(4, 'https://example.com/images/iphone-16-2.jpg', 'iphone-16-2.jpg', 'image/jpeg', NULL, 2),
(5, 'https://example.com/images/inspiron-15.jpg', 'inspiron-15.jpg', 'image/jpeg', NULL, 3),
(6, 'https://example.com/images/hp-pavilion.jpg', 'hp-pavilion.jpg', 'image/jpeg', NULL, 4),
(7, 'https://example.com/images/sony-headphones.jpg', 'sony-headphones.jpg', 'image/jpeg', NULL, 5),
(8, 'https://example.com/images/lg-fridge.jpg', 'lg-fridge.jpg', 'image/jpeg', NULL, 6),
(9, 'https://example.com/images/godrej-wardrobe.jpg', 'godrej-wardrobe.jpg', 'image/jpeg', NULL, 7),
(10, 'https://example.com/images/atomic-habits.jpg', 'atomic-habits.jpg', 'image/jpeg', NULL, 8),
(11, 'https://example.com/images/levis-jeans.jpg', 'levis-jeans.jpg', 'image/jpeg', NULL, 9),
(12, 'https://example.com/images/nike-pegasus.jpg', 'nike-pegasus.jpg', 'image/jpeg', NULL, 10),
(13, 'https://example.com/images/adidas-duramo.jpg', 'adidas-duramo.jpg', 'image/jpeg', NULL, 11),
(14, 'https://example.com/images/cricket-bat.jpg', 'cricket-bat.jpg', 'image/jpeg', NULL, 12),
(15, 'https://example.com/images/lakme-lotion.jpg', 'lakme-lotion.jpg', 'image/jpeg', NULL, 13),
(16, 'https://example.com/images/business-game.jpg', 'business-game.jpg', 'image/jpeg', NULL, 14),
(17, 'https://example.com/images/bosch-vacuum.jpg', 'bosch-vacuum.jpg', 'image/jpeg', NULL, 15),
(18, 'https://example.com/images/tata-basmati.jpg', 'tata-basmati.jpg', 'image/jpeg', NULL, 16),
(19, 'https://example.com/images/dabur-honey.jpg', 'dabur-honey.jpg', 'image/jpeg', NULL, 17),
(20, 'https://example.com/images/titan-watch.jpg', 'titan-watch.jpg', 'image/jpeg', NULL, 18),
(21, 'https://example.com/images/boat-speaker.jpg', 'boat-speaker.jpg', 'image/jpeg', NULL, 19),
(22, 'https://example.com/images/asus-rog.jpg', 'asus-rog.jpg', 'image/jpeg', NULL, 20);