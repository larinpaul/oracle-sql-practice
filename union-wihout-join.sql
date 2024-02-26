-- 2024 02 25

-- Соединения таблиц в SQL-запросах во WHERE, без джоинов 
-- (SELECT без JOIN) Плюсы и минусы.
-- (Так делать обычно НЕ СОВЕТУЕТСЯ!)

-- Перечисления без джойнов, то есть WHERE и перечисляем связки таблиц
-- Но есть несколько тонких моментов, которые нужно осветить.

-- Например у нас есть таблица сотрудники
SELECT *
    FROM Persons

SELECT *
    FROM Phones

-- Теперь посмотрим как делать соединения таблиц без джойнов,
-- в одном запросе.
SELECT *
    FROM Persons, Phones -- То есть без джойнА, просто выбираем первая, вторая, третья и так далее...

-- Но нужно указать, как телефон относится к сотрудникам, как их соединять...
SELECT *  -- Можно также давать короткие имена, например Persons p, Phones ph
    FROM Persons p, Phones ph
    WHERE ph.Personid = p.Personid
-- Плюсы:
-- Такой способ лёгок для понимания начинающим (НО ОН ПЛОХОЙ! И он не поддерживается многими СУБД...)
-- Минусы:
-- Не поддерживается многими СУБД
-- Не поддерживается стандартом IEC
-- Когда будет много таблиц, и когда таблицы соединяются, например, сразу по нескольким столбцам,
-- То снизу получится каша и будет труден для чтения...
SELECT *
    FROM Persons p, Phones ph, Department d, Filial f
    WHERE ph.Personid = p.Personid
    AND d.departmentid = p.Departmentid
    AND f.filialid = p.Filialid
-- Важно понимать, что в таком случае вы всегда соединяете по INNER JOIN
-- То есть отображаются только те строки, которые есть в обеих таблицах
-- Но если, к примеру, сотрудников больше чем телефонов,
-- то часть сотрудников не отобразится!

-- Нам нужно, чтобы, к примеру, Phones не ограничивала данные из Persons
-- Тогда посмотрим в соединения и увидим где Persons соединяется в Phones.
-- Это происходит только в одной строке,
-- WHERE ph.Personid = p.Personid
-- вот тут-то и надо поставить небольшую подсказку Ораклу
-- "вот тут соединения опциональные, т.е. по возможности, не ограничивай пожалуйста меня в том случае, если данные не найдутся"
-- WHERE ph.Personid (+) = p.Personid
SELECT * 
    FROM Persons p, Phones ph,
         Department d, Filial f
    WHERE ph.Personid (+) = p.Personid
    AND d.departmentid = p.Departmentid
    AND f.filialid = p.Filialid
-- Теперь нам вывудтся все сотрудники, даже у которых телефона нет.

-- А вот что если мы попробуем вывести также с дополнительными условиями,
-- например выводим только сотрудников с мобильными телефонами.
SELECT *
    FROM    Persons p, Phones ph,
            Department d, Filial f
    WHERE ph.Personid (+) = p.Personid
    AND ph.phone_type (+) = 'мобильный'
    AND d.departmentid = p.Departmentid
    AND f.filialid = p.Filialid
-- То есть если какая-то табличка к такой-то таблице присоединяется опционально,
-- то нужно после указания этой таблицы, до равно, нужно поставить плюс в скобках (+)
 