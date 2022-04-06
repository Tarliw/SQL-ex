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
