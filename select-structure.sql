-- 2024 09 29

-- Язык SQL

-- Команды DML (Data Manipulation Language)
-- SELECT - Выборка (получение) данных
-- INSERT - Вставка данных
-- UPDATE - Редактирование (изименение) данных
-- DELETE - Удаление (строчек) данных

-- Комадны DDL (Data Definition Language)
-- CREATE - Создание объект базы данных (например, таблицы) или самой базы данных
-- ALTER - Редактирование объекта
-- DROP - Удаление объекта

-- Команды TCL (Transaction Control Language)

-- Команды DCL (Data Control Language)


-- Язык SQL. Оператор SELECT
SELECT <Столбец1>, <Столбец2>, ... <СтолбецN>
    FROM <Имя_таблицы>

SELECT ID, Name, BirthDate
    FROM Persons

SELECT <Столбец1>, <Столбец2>, ... <СтолбецN>
    FROM <Имя_таблицы>
    ORDER BY <Столбец1>, ... -- СОРТИРОВКА, очень важный момент!

-- А теперь ФИЛЬТРАЦИЯ с помощью WHERE
SELECT <Столбец1>, <Столбец2>, ... <СтолбецN>
    FROM <Имя_таблицы>
    WHERE <Условие или условия отбора данных из таблицы>
    ORDER BY <Столбец1>, ...


-- Еще одна опция для SELECT, это JOIN, то есть возможность соединения дополнительных таблиц
SELECT <Столбец1>, <Столбец2>, ... <СтолбецN>
    FROM <Имя_таблицы>
    JOIN -ы (Соединения дополнительных таблиц)
    WHERE <Условие или условия отбора данных из таблицы>
    ORDER BY <Столбец1>, ...


-- Также нам иногда нужно данные группировать, для этого есть GROUP BY <Признак группировки>
SELECT <Column1>, <Column2>, ... <ColumnN>
    FROM <Table_name>
    JOIN -ы (Соединения догполнительных таблиц)
    WHERE <Условие или условия отбора данных из таблицы>
    GROUP BY <Признак группировки>
    ORDER BY <Столбец1>, ...


-- Есть еще одна опция команды SELECT, это опция HAVING
SELECT <Столбец1>, <Столбец2>, ... <СтолбецN>
    FROM <Имя_таблицы>
    JOIN -ы (Соединения дополнительных таблиц)
    WHERE <Условие или условия отбора данных из таблицы>
    GROUP BY <Признак группировки>
    HAVING <Условия отбора на основе данных группировки>
    ORDER BY <Столбец1>, ...


SELECT ID, Name, BirthDate
    FROM Persons
    WHERE FILIALID = 1


-- Что еще можно использовать для сравнения данных?
= -- Равно
<> -- Не равно
!= -- Не равно 
> -- Больше
< -- Меньше
>= -- Больше или равно
<= -- Меньше или равно

SELECT ID, Name, BirthDate
    FROM Persons
    WHERE FILIALID <> 1
    ORDER BY BirthDate -- Самые поздние сотрудники будут выведены в конце

-- А чтобы вывости самых поздних в начале, надо использовать ORDER BY BirthDate desc
SELECT ID, Name, BirthDate
    FROM Persons
    WHERE FILIALID <> 1
    ORDER BY BirthDate desc
-- desc означает обратный порядок
-- Для прямого порядка сортировки нужно писать asc или вообще ничего не писать


-- Если нужно вывести все столбцы из таблицы
SELECT *
    FROM Persons
    WHERE FILIALID = 1 OR FILIALID = 2
    ORDER BY BirthDate


-- Заходим в PL/SQL Developer
-- Нажимаем New -> SQL Window


SELECT *
    FROM Persons
-- Нажимаем на зеленый треугольник, Executre the current window (F8)


-- Слева будет PersonID, а справа Name
SELECT PersonID, Name
    FROM Persons

-- Слева будет Name, а справа PersonID
SELECT Name, PersonID
    FROM Persons


-- Теперь попрактикуемся делать небольшие условия
SELECT *
    FROM Persons
    WHERE FilialID = 1

SELECT *
    FROM Persons
    WHERE FilialID = 1 OR FilialID = 2

-- А вот так мы не увидим ни одной строчки
SELECT *
    FROM Persons
    WHERE FilialID = 1 AND FilialID = 2

-- А вот тут уже все будте норм, ибо разные столбцы
SELECT *
    FROM Persons
    WHERE FilialID = 1 AND DepartmentID = 2

-- Отсортируем данные по филиалу с помощью команды ORDER BY
SELECT *
    FROM Filial
    ORDER BY FilialName

SELECT *
    FROM Filial
    ORDER BY FilialName desc

SELECT *
    FROM Filial
    ORDER BY FilialName asc


select * from Canteendishes

select *
    from Canteendishes
    order by DishName

SELECT *
    FROM Canteendishes
    ORDER BY DishName
