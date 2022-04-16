-- Задание: 1 
-- Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. 
-- Вывести: model, speed и hd

SELECT model, speed, hd
  FROM PC
WHERE price < 500

-- Задание: 2 
-- Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT maker
  FROM Product
WHERE type = 'printer'

-- Задание: 3 
-- Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

SELECT model, ram, screen
  FROM laptop
WHERE price > 1000

-- Задание: 4
-- Найдите все записи таблицы Printer для цветных принтеров.

SELECT *
  FROM printer
WHERE color = 'y'

-- Задание: 5
-- Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

SELECT model,speed,hd
  FROM PC
WHERE (cd = '12x' or cd = '24x') and price < 600

-- Задание: 6
-- Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, 
-- найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT DISTINCT Product.maker,Laptop.speed
FROM product 
JOIN laptop
  ON product.model = laptop.model
WHERE hd >= 10

-- Задание: 7
-- Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

SELECT DISTINCT 
  PC.model,
  PC.price 
FROM Product
JOIN 
  PC ON Product.model = PC.model
WHERE Product.maker = 'B'
UNION
SELECT DISTINCT
  Laptop.model,
  Laptop.price
FROM Product
JOIN 
  Laptop ON Product.model = Laptop.model
WHERE Product.maker = 'B'
UNION
SELECT DISTINCT 
  Printer.model,
  Printer.price
FROM Product
JOIN 
  Printer ON Product.model = Printer.model
WHERE Product.maker = 'B'

-- Задание: 8 
-- Найдите производителя, выпускающего ПК, но не ПК-блокноты

SELECT DISTINCT
  maker
FROM Product
WHERE type = 'PC'
EXCEPT 
SELECT DISTINCT
  maker
FROM Product
WHERE type = 'Laptop'

--

SELECT DISTINCT
 maker
FROM Product
WHERE type = 'PC'
and maker not in 
(
 SELECT
  maker
 FROM Product
 WHERE type = 'laptop'
)

-- Задание: 9 
-- Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

SELECT DISTINCT
  maker
FROM Product
JOIN 
  PC ON Product.model = PC.model
WHERE PC.speed >= 450

-- Задание: 10 
-- Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

SELECT DISTINCT
  model,
  price
FROM Printer
WHERE price = (
SELECT max(price)
FROM Printer
)

-- Задание: 11 
-- Найдите среднюю скорость ПК

SELECT 
  avg(speed)
FROM PC

-- Задание: 12 
-- Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT 
  avg(speed)
FROM Laptop
WHERE price > 1000

-- Задание: 13 
-- Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT 
  avg(speed)
FROM PC
LEFT JOIN Product
  ON Product.model = PC.model 
WHERE maker = 'A'

-- Задание: 14 
-- Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT DISTINCT 
  Classes.class,
  Ships.name,
  Classes.country 
FROM Ships
JOIN 
  Classes ON Ships.class = Classes.class
WHERE Classes.numGuns >= 10

-- Задание: 15 
-- Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT
  hd
FROM PC 
GROUP by hd
HAVING count(hd)>1

-- Задание: 16 
-- Найдите пары моделей PC, имеющих одинаковые скорость и RAM. 
-- В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), 
-- Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
-- С джоином эффективнее, чем с where

SELECT DISTINCT
  t1.model,
  t2.model,
  t1.speed,
  t1.ram
FROM PC t1
INNER JOIN PC t2
ON t1.model > t2.model
AND t1.speed = t2.speed
AND t1.ram = t2.ram

-- Задание: 17 
-- Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
-- Вывести: type, model, speed

SELECT DISTINCT 
  Product.type,
  Laptop.model,
  Laptop.speed
FROM Product, Laptop
WHERE speed < 
(
SELECT min(speed) 
FROM PC
)
AND Product.type = 'Laptop'
--
select distinct
 'Laptop' as type,
 model,
 speed
from Laptop
where speed < (select min(speed) from pc)

-- Задание: 18 
-- Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

SELECT DISTINCT
  Product.maker,
  Printer.price
FROM Product
INNER JOIN Printer ON
  Product.model = Printer.model
WHERE price = 
(
SELECT 
  min(price)
FROM Printer
WHERE color = 'y'
)
AND color = 'y'

-- Задание: 19 
-- Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
-- Вывести: maker, средний размер экрана.

SELECT
  Product.maker,
  AVG(Laptop.screen)
FROM Product
JOIN Laptop ON
  Product.model = Laptop.model
GROUP BY maker

-- Задание: 20 
-- Найдите производителей, выпускающих по меньшей мере три различных модели ПК. 
-- Вывести: Maker, число моделей ПК.

SELECT
  maker,
  COUNT(model)
FROM Product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(model) >= 3

-- Задание: 21
-- Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
-- Вывести: maker, максимальная цена.

SELECT
  t1.maker,
  max(t2.price)
FROM Product t1
INNER JOIN pc t2
ON t1.model=t2.model
GROUP by t1.maker

-- Задание: 22
-- Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. 
-- Вывести: speed, средняя цена.

SELECT
  speed,
  avg(price)
FROM PC
WHERE speed>600
GROUP BY speed


--Задание: 23 
--Найдите производителей, которые производили бы как ПК
--со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
--Вывести: Maker

SELECT distinct maker
FROM Product
JOIN PC ON Product.model = PC.model
WHERE speed >= 750 and maker IN
(
  SELECT maker
  FROM Product
  JOIN Laptop ON Product.model = Laptop.model
  WHERE speed >= 750
)

--Задание: 24
--Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

SELECT model
FROM 
(
  SELECT model, price
  FROM PC
  UNION
  SELECT model, price
  FROM Laptop
  UNION
  SELECT model, price
  FROM Printer
) t1
WHERE price = 
(
  SELECT MAX(price)
  FROM 
    (
      SELECT price
      FROM PC
      UNION
      SELECT price
      FROM Laptop
      UNION
      SELECT price
      FROM Printer
    ) t2
)

-- Задание: 25
-- Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором 
-- среди всех ПК, имеющих наименьший объем RAM. 
-- Вывести: Maker

SELECT DISTINCT maker
FROM product
WHERE model IN 
  (
  SELECT model
  FROM PC
  WHERE ram = 
  (
    SELECT min(ram)
	FROM PC
  )
  AND speed = 
    (
    SELECT max(speed)
	FROM PC
	WHERE ram = 
	  (
	  SELECT min(ram)
	  FROM PC
	  )
	)
  )
AND maker in 
(
  SELECT distinct maker
  FROM Product
  WHERE type = 'Printer'
)

-- Задание: 26
-- Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). 
-- Вывести: одна общая средняя цена.

SELECT AVG(price)
FROM 
(
  SELECT code, price, pc.model--, ram, hd
  FROM pc
  WHERE model IN 
  (
    SELECT model
    FROM product
    WHERE maker='A'
  )
  UNION
  SELECT code, price, laptop.model--, ram, hd
  FROM laptop
  WHERE model IN 
  (
    SELECT model
    FROM product
    WHERE maker='A'
  )
) t1

-- Задание: 27
-- Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. 
-- Вывести: maker, средний размер HD.

SELECT maker, AVG(hd) as avg_HD
FROM product t1 
JOIN pc t2 
ON t1.model=t2.model
WHERE maker IN 
(
SELECT maker
FROM product
WHERE type='printer'
)
GROUP BY maker

-- Задание: 28 
-- Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

SELECT count(maker) as qtty
FROM product
WHERE maker IN
(
SELECT distinct maker FROM product 
GROUP BY maker
HAVING count(model)=1
)
-- --//--
-- SELECT distinct count(maker) as qtty
-- FROM product
-- WHERE maker IN
-- (
-- SELECT maker FROM product 
-- GROUP BY maker
-- HAVING count(model)=1
-- )
-- --//--
-- SELECT count(maker) as qtty 
-- FROM (
-- SELECT distinct maker
-- FROM product 
-- GROUP BY maker 
-- HAVING COUNT(model) = 1) AS prod 

-- Задание: 29 
-- В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще 
-- одного раза в день [т.е. первичный ключ (пункт, дата)], 
-- написать запрос с выходными данными (пункт, дата, приход, расход). 
-- Использовать таблицы Income_o и Outcome_o.

SELECT t1.point, t1.date, inc, out
FROM Income_o t1
LEFT JOIN Outcome_o t2
on t1.point = t2.point and t1.date= t2.date
UNION
SELECT t2.point, t2.date, inc, out
FROM Outcome_o t2
LEFT JOIN Income_o t1
on t1.point = t2.point and t1.date= t2.date

-- Задание: 30
-- В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз 
-- (первичным ключом в таблицах является столбец code), требуется получить таблицу, 
-- в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
-- Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). 
-- Отсутствующие значения считать неопределенными (NULL).

SELECT point, date, SUM(sum_out), SUM(sum_inc)
FROM 
( 
  SELECT point, date, SUM(inc) as sum_inc, null as sum_out 
  FROM Income 
  GROUP by point, date
UNION
  SELECT point, date, null as sum_inc, SUM(out) as sum_out 
  FROM Outcome 
  GROUP by point, date 
) as t
GROUP by point, date 
ORDER by point

-- Задание: 31 
-- Для классов кораблей, калибр орудий которых не менее 16 дюймов, 
-- укажите класс и страну.

SELECT class, country
FROM classes
WHERE bore >= 16

-- Задание: 32 
-- Одной из характеристик корабля является половина куба калибра его главных орудий (mw). 
-- С точностью до 2 десятичных знаков определите среднее значение mw для кораблей каждой страны, 
-- у которой есть корабли в базе данных.

SELECT
  country,
  cast(avg((power(bore,3)/2)) as numeric(6,2)) as mw
FROM 
  (select 
    country, 
    classes.class, 
    bore, 
    name 
  from classes 
  left join ships on classes.class = ships.class
  union
  select  
    country, 
    class, 
    bore, 
    ship 
  from classes t1 
  left join outcomes t2 on t1.class = t2.ship
  where ship = class and ship not in (select name from ships)) a
WHERE name IS NOT NULL 
GROUP BY country

-- Задание: 33 
-- Укажите корабли, потопленные в сражениях в Северной Атлантике (North Atlantic). 
-- Вывод: ship.

SELECT
  ship
FROM Battles b
LEFT JOIN Outcomes o
  on o.battle = b.name
WHERE 
  o.result = 'sunk' and b.name = 'North Atlantic'

-- Задание: 34
-- По Вашингтонскому международному договору от начала 1922 г. запрещалось строить линейные корабли 
-- водоизмещением более 35 тыс.тонн. Укажите корабли, нарушившие этот договор 
-- (учитывать только корабли c известным годом спуска на воду). Вывести названия кораблей.

SELECT
  ships.name
FROM Classes, Ships
WHERE
  launched >= 1922 and
  displacement > 35000 and
  type = 'bb' and
  Ships.class = Classes .class

-- Задание: 35 
-- В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра).
-- Вывод: номер модели, тип модели.

SELECT
  model, type
FROM
  Product
WHERE 
  model not LIKE '%[^a-zA-Z]%' or 
  model not LIKE '%[^0-9]%'
