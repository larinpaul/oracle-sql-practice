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
