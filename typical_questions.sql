-- Типичные вопросы на собеседовании по SQL

-- Задача 1
-- Строчки с каким ID из таблицы ниже вернет следующий запрос

-- ID NAME CLASS_ITEM
-- 1 Арфа A -- При сравнении с А будет нет, ибо то же значение
-- 2 аккордеон NULL -- При сравнении с NULL тоже будет нет!
-- 3 Барабан B -- При сравнении с B будет да, ибо другое значение
-- 4 рояль NULL -- При сравнении с NULL тоже будет нет!
-- 5 труба  A
-- 6 Пианино C

SELECT ID 
    FROM Table1
    WHERE CLASS_ITEM <> 'A';


-- ЗАДАЧА 2
-- Выберите верные утверждения (возможно несколько вариантов):
-- 1) NULL <> 1 -- false
-- 2) NULL <> NULL -- false
-- 3) NULL = NULL -- false
-- 4) NULL IS NOT NULL -- false
-- 5) NULL IS NULL -- true


-- ЗАДАЧА 3
-- Строчки с каким ID из таблицы ниже вернет следующий запрос:

-- ID NAME CLASS_ITEM
-- 1 Арфа A -- TRUE
-- 2 аккордеон NULL
-- 3 Барабан B
-- 4 рояль NULL
-- 5 труба A -- TRUE
-- 6 Пианино C

SELECT ID
    FROM Table1
    WHERE NAME LIKE `A%`; 

-- The `LIKE` keyword in SQL is useed to search for a specified pattern in a column.
-- In this case, % matches any sequence of characters after A,
-- which means any value that starts with letter "A",
-- followed by any number of other characters


-- ЧАСТЬ 2.
-- Вопросы на собеседовании по SQL.

-- ЗАДАЧА 1
-- В чем разница между UNION и UNION ALL:

-- Столбец1 Столбец2 Столбец3
-- Арфа A 10
-- Аккордеон B 20
-- Барабан C 30

-- Столбец1 Столбец2 Столбец3
-- Маракасы D 40
-- Арфа A 10
-- Пианино E 50

SELECT Столбец1, Столбец2, Столбец3
    FROM Таблица
    WHERE Условия

UNION

SELECT Столбец1, Столбец2, Столбец3
    FROM Таблица2
    WHERE Условия;

-- Итак, если мы используем просто UNION,
-- то у нас соединятся строки без дублирования,
-- а дублированные строки сократятся, например:

-- Столбец1 Столбец2 Столбец3
-- Арфа A 10
-- Аккордеон B 20
-- Барабан C 30
-- Маракасы D 40
-- Пианино E 50

-- Если же мы используем UNION ALL,
-- то у нас в одной таблице соединятся все, даже дублированные строки

SELECT Столбец1, Столбец2, Столбец3
    FROM Таблица
    WHERE Условия

UNION ALL

SELECT Столбец1, Столбец2, Столбец3
    FROM Таблица2
    WHERE Условия;

-- Столбец1 Столбец2 Столбец3
-- Арфа A 10
-- Аккордеон B 20
-- Барабан C 30
-- Маракасы D 40
-- Арфа A 10
-- Пианино E 50


-- 2024 02 24 

-- ЗАДАЧА 2
-- Найдите ошибку в SQL запросе

SELECT
    ID_ITEM,
    NAME_ITEM,
    EXTRACT(YEAR FROM DATE_IMPORT) AS YEAR_IMPORT
FROM Table1
WHERE YEAR_IMPORT > 2010;

-- Ошибки:

-- WHERE выполняется до того, как столбцу будет присвоен псевдоним (alias),
-- а это невозможно, псевдомним в запросе всегда присваивается последним.
-- Поэтому псевдоним (alias) во WHERE еще использовать нельзя!

-- Как исправить:
-- Начнем с того, что будем через WHERE проверять не alias, а само значение
SELECT
    ID_ITEM,
    NAME_ITEM,
    EXTRACT(YEAR FROM DATE_IMPORT) AS YEAR_IMPORT
FROM Table1
WHERE EXTRACT(YEAR FROM DATE_IMPORT) > 2010;

-- Только в блоке ORDER BY можно использовать alias,
-- то есть использовать данное нами имя столбца.
-- Потому что данные уже отфильтрованы с помощью WHERE,
-- они, если нужно, сгруппированы, преобразованы к нужному виду,
-- всё, что нужно, уже сделано.
-- Осталось, если нужно, только отсортировать...
-- Вот только в вблоке ORDER BY можно использовать элиас столбца.
SELECT
    ID_ITEM,
    NAME_ITEM,
    EXTRACT(YEAR FROM DATE_IMPORT) AS YEAR_IMPORT
FROM Table1
WHERE EXTRACT(YEAR FROM DATE_IMPORT) > 2010
ORDER BY YEAR_IMPORT;


-- 2024 02 24

-- ЗАДАЧА 3
-- В чём разница между WHERE и HAVING?:

-- WHERE нужен, чтобы наскалывать условие на весь набор данных
SELECT  c.ID_CLIENT,
        s.DATE_SALE,
        s.SUM_PAYMENT
    FROM Clients c
    JOIN Sales s
    ON s.ID_CLIENT = c.ID_CLIENT
    WHERE s.DATE_SALE BETWEEN to_date('01.01.2019', 'dd.mm.yyyy') AND to_date('31.12.2019', 'dd.mm.yyyy');

-- Тееперь будем подбираться к вопросу HAVING:

-- Теперь выведем сумму продаж по каждому клиенту,
-- т.е. по каждому клиенту число выведется только один раз
SELECT c.ID_CLIENT
        SUM(s.SUM_PAYMENT) AS TOTAL_SUM
    FROM Clients c
    JOIN Sales s
    ON s.ID_CLIENT = c.ID_CLIENT
    WHERE s.DATE_SALE BETWEEN to_date('0.01.2019','dd.mmm.yyyy') AND to_date('31.12.2019','dd.mm.yyyy')
    GROUP BY c.ID_CLIENT;

-- С другой стороны, HAVING нужен для проверки отдельных данных.
-- Например, мы можем посмотреть по каждой сумме по каждому клиенту
-- HAVING нужен, чтобы фильтровать данные по сгруппированной информации
-- Не на момент набора данных, а когда данные уже получены
SELECT c.ID_CLIENT,
        SUM(s.SUM_PAYMENT) AS TOTAL_SUM
        FROM Clients c
        JOIN Sales s
        ON s.ID_CLIENT = c.ID_CLIENT
        WHERE s.DATE_SALE BETWEEN to_date('01.01.2019','dd.mm.yyyy') AND to_date('31.12.2019','dd.mm.yyyy')
        GROUP BY c.ID_CLIENT
        HAVING SUM(s.SUM_PAYMENT) > 1000000


--2024 02 25 -- 13:24

-- ЗАДАЧА 4
-- Какие типы соединений таблиц вы знаете?

-- INNER JOIN
-- LEFT JOIN -- то же что и LEFT OUTER JOIN
-- RIGHT JOIN -- то же что и RIGHT OUTER JOIN
-- CROSS JOIN
-- FULL JOIN -- Сперва сделает INNER JOIN, затем LEFT JOIN, затем RIGHT JOIN


-- ЗАДАЧА 5
-- Какие команды DML вы знаете?
-- DML это команды манипуляции с данными, их всего 4:
-- SELECT
-- INSERT
-- UPDATE
-- DELETE
