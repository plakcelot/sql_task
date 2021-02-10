CREATE TABLE users (user_id INTEGER, email VARCHAR(30));
CREATE TABLE orders (user_id INTEGER, order_id INTEGER);

INSERT INTO users (user_id, email)
     VALUES (111, 'test111@mail.ru'), (222, 'test222@mail.ru'), (333, 'test333@mail.ru'),
            (444, 'test444@mail.ru'), (555, 'test555@mail.ru'), (666, 'test666@mail.ru');

INSERT INTO orders (user_id, order_id)
     VALUES (111, 1111), (111, 1112), (222, 2222), (222, 2223), (333, 3333),
     	  (333, 3334), (444, 4444), (555, 5555), (555, 5556), (666, 6666);

/* С помощью JOIN вывести E-mail пользователей, имеющих заказы № 1111 или 2222 */
SELECT DISTINCT email
     FROM users
     INNER JOIN orders
     ON orders.user_id = users.user_id
     WHERE order_id IN (1111, 2222);

/* С помощью подзапроса вывести E-mail пользователей, имеющих заказы № 1111 или 2222 */
SELECT DISTINCT email
     FROM users
     WHERE user_id IN (
               SELECT user_id
               FROM orders
               WHERE order_id IN (1111, 2222)
          );

/* Вывести количество заказов из таблицы orders для каждого юзера, используя группировку,
при этом отсеять те записи, где кол-во заказов меньше 2-х + отсортировать по user_id по убыванию */
SELECT COUNT(order_id), user_id
     FROM orders
     GROUP BY user_id
     HAVING COUNT(order_id) > 1
     ORDER BY user_id DESC;

/* Поместить результат выборки первого задания во временную таблицу и выбрать из нее все строки */
WITH temp_table AS
     (
          SELECT email
          FROM users
          INNER JOIN orders
          ON orders.user_id = users.user_id
          WHERE order_id IN (1111, 2222)
     )
SELECT * FROM temp_table;