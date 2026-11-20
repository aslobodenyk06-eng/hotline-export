INSERT INTO shop VALUES (1, 'TechNova', 40514, 'https://technova.example.ua', 41.5);
INSERT INTO category VALUES (1, NULL, 'Комп''ютерна техніка');
INSERT INTO category VALUES (2, 1, 'Ноутбуки');
INSERT INTO category VALUES (3, 1, 'Монітори');
INSERT INTO category VALUES (4, NULL, 'Периферія');
INSERT INTO category VALUES (5, 4, 'Миші');
INSERT INTO category VALUES (6, 4, 'Клавіатури');
INSERT INTO product VALUES (1, 2, 'NB-1001', '4711387123456', 'ASUS', 'ASUS TUF Gaming F15 FX507ZC4', 'Ігровий ноутбук 15.6" 144 Гц, Intel Core i5-12500H, 16 ГБ, 512 ГБ SSD, RTX 3050', 'https://technova.example.ua/p/nb-1001', 'https://technova.example.ua/img/nb-1001.jpg', 38999, 'В наявності', 12, NULL, 0);
INSERT INTO product VALUES (2, 2, 'NB-1002', '4711387654321', 'Lenovo', 'Lenovo IdeaPad Slim 3 15IAH8', 'Ноутбук 15.6" IPS, Intel Core i5-12450H, 16 ГБ, 512 ГБ SSD', 'https://technova.example.ua/p/nb-1002', 'https://technova.example.ua/img/nb-1002.jpg', 24499, 'В наявності', 12, NULL, 0);
INSERT INTO product VALUES (3, 2, 'NB-1003', '0195908765432', 'Apple', 'Apple MacBook Air 13 M3 8/256GB', 'Ноутбук 13.6" Liquid Retina, Apple M3, 8 ГБ, 256 ГБ SSD', 'https://technova.example.ua/p/nb-1003', 'https://technova.example.ua/img/nb-1003.jpg', 47999, 'Під замовлення', 12, 7, 0);
INSERT INTO product VALUES (4, 3, 'MN-2001', '8806094123987', 'Samsung', 'Samsung Odyssey G5 27" LS27CG510', 'Монітор 27" VA 2560x1440, 165 Гц, 1 мс', 'https://technova.example.ua/p/mn-2001', 'https://technova.example.ua/img/mn-2001.jpg', 10999, 'В наявності', 36, NULL, 0);
INSERT INTO product VALUES (5, 3, 'MN-2002', '4718755123654', 'AOC', 'AOC 24G2SPU/BK', 'Монітор 23.8" IPS 1920x1080, 165 Гц', 'https://technova.example.ua/p/mn-2002', 'https://technova.example.ua/img/mn-2002.jpg', 6299, 'В наявності', 36, NULL, 0);
INSERT INTO product VALUES (6, 5, 'MS-3001', '5099206098718', 'Logitech', 'Logitech G502 X Lightspeed', 'Бездротова ігрова миша, сенсор HERO 25K', 'https://technova.example.ua/p/ms-3001', 'https://technova.example.ua/img/ms-3001.jpg', 5199, 'В наявності', 24, NULL, 0);
INSERT INTO product VALUES (7, 5, 'MS-3002', '6935280812345', 'Razer', 'Razer DeathAdder Essential', 'Дротова ігрова миша, 6400 DPI', 'https://technova.example.ua/p/ms-3002', 'https://technova.example.ua/img/ms-3002.jpg', 999, 'Немає', 12, NULL, 0);
INSERT INTO product VALUES (8, 6, 'KB-4001', '4710562755432', 'HyperX', 'HyperX Alloy Origins Core', 'Механічна клавіатура TKL, перемикачі HyperX Red, RGB', 'https://technova.example.ua/p/kb-4001', 'https://technova.example.ua/img/kb-4001.jpg', 3499, 'В наявності', 24, NULL, 0);
INSERT INTO product_param (product_id, name, value) VALUES
 (1, 'Діагональ', '15.6"'), (1, 'Процесор', 'Intel Core i5-12500H'), (1, 'Відеокарта', 'NVIDIA GeForce RTX 3050'), (1, 'ОЗП', '16 ГБ'),
 (2, 'Діагональ', '15.6"'), (2, 'Процесор', 'Intel Core i5-12450H'), (2, 'ОЗП', '16 ГБ'),
 (3, 'Діагональ', '13.6"'), (3, 'Процесор', 'Apple M3'), (3, 'ОЗП', '8 ГБ'),
 (4, 'Діагональ', '27"'), (4, 'Роздільна здатність', '2560x1440'), (4, 'Частота оновлення', '165 Гц'),
 (5, 'Діагональ', '23.8"'), (5, 'Тип матриці', 'IPS'), (5, 'Частота оновлення', '165 Гц'),
 (6, 'Тип підключення', 'Бездротове'), (6, 'Роздільна здатність сенсора', '25600 DPI'),
 (7, 'Тип підключення', 'Дротове'), (7, 'Роздільна здатність сенсора', '6400 DPI'),
 (8, 'Тип перемикачів', 'HyperX Red'), (8, 'Форм-фактор', 'TKL');
