insert into Role (id, name) VALUES (1, 'ROLE_ADMIN'),(2, 'ROLE_USER');
insert into UrlAccessRule (id, access, pattern, application) VALUES
(1, '/dh/web/**', 'ADMIN', 'dental_hygiene'), (2, '/dh/api/**', 'USER', 'dental_hygiene'),
(3, '/ksm/web/**', 'ADMIN', 'ksm'), (4, '/ksm/api/**', 'USER', 'ksm'),
(5, '/sc/web/**', 'ADMIN', 'shoppingcart'), (6, '/sc/api/**', 'USER', 'shoppingcart'),
(7, '/blog/web/**', 'ADMIN', 'blogs'), (8, '/blog/api/**', 'USER', 'blogs'),
(9, '/gig/web/**', 'ADMIN', 'GIG'), (10, '/gig/api/**', 'USER', 'GIG');
