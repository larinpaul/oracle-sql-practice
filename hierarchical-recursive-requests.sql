-- 2024 03 01

-- Иерархические (рекурсивные) запросы

-- Иерархические, или рекурсивные запросы нужны, когда у нас в одной таблице
-- есть информация о главных элементах и о дочерних элементах.
-- А также о дочерних элементах этих дочерних элементов.
-- То есть когда всё внутри одной таблицы, БЕЗ ДЖОЙНОВ!
-- Например:
-- TablID   FIO      BossID  StatusName
-- 1      Глав А.Г.          Генеральный Директор
-- 2      Задумч Л.А.  1     Главный бухгалтер
-- 3      Скоро А.В.   1     Директор по продажам
-- 4      Прав П.И.    3     Менеджер
-- 5      Дебе О.В.    2     Бухгалтер
-- 6      Диск Д.К.    4     Программист
-- 7      Двой Р.М.    4     Инженер
-- И например нужен отчет который бы показал всю иерархию, всю глубину, все связи.

-- То есть иерархические запросы позволяют строить соедниения таблицы самой с собой
-- Вы не джойните одну таблицу к другой, а вы указываете СУБД,
-- что нужно соединяться с самой собой пока не будет построена вся иерархия.
-- пока не выведутся все листики дерева.
-- Например, начальник, его подчиненные, и их подчиненные, вплоть до последнего сотрудника

-- По сути можно построить полноценное дерево, от корня к листикам и наоборот.

-- На практике они применяются не так часто, но тема имеет место быть.


CREATE TABLE Sotrudniki (
    ID NUMBER PRIMARY KEY,
    FIO VARCHAR(100),
    BossID NUMBER,
    StatusName VARCHAR(100),
);

insert into Sotrudniki (ID,FIO,BossID,StatusName) VALUES (1, Главаг, NULL, Гендир)

...

COMMIT;

-- Напишем наш первый иерархический запрос.

SELECT *
    FROM Sotrudniki 

SELECT *
    FROM Sotrudniki s


SELECT
    s.id,
    s.fio,
    s.statusname
    FROM Sotrudniki s

-- Итак, чтобы соединить сотрудников с самими собой...
-- Нужно написать магическое слово CONNECT BY и указать как соединять

SELECT
    s.di,
    s.fio,
    s.statusname,
    s.Bossid
    FROM Sotrudniki s
    CONNECT BY prior ID = BossID
    -- Мы идем к подчиненным, поэтому ID слева, а BossID справа
    -- а также пишем слово prior
    -- а затем надо показать кто пойдёт первым

SELECT
    s.id,
    s.fio,
    s.statusname,
    s.Bossid
    FROM Sotrudniki s
    CONNECT BY prior ID = BossID
    START WITH BOSSID IS NULL


-- А дальше будет чуть посложнее
-- Посмотрим какие вещи еще можно использовать в запросах не по прямому назначению...

-- К примеру, в обычном запросе у нас FIO выводится по-нормальному, как три слова
-- А мы, к примеру, хотим слева сделать отступ.




























